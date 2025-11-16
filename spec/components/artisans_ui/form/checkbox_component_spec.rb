# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Form::CheckboxComponent, type: :component do
  it "renders a checkbox input" do
    render_inline(described_class.new)
    expect(rendered_content).to include('type="checkbox"')
    expect(rendered_content).to include('<input')
  end

  it "includes default styling" do
    render_inline(described_class.new)
    expect(rendered_content).to include("h-4 w-4")
    expect(rendered_content).to include("rounded")
    expect(rendered_content).to include("border-neutral-200")
  end

  it "supports dark mode" do
    render_inline(described_class.new)
    expect(rendered_content).to include("dark:bg-neutral-900")
    expect(rendered_content).to include("dark:border-neutral-800")
  end

  it "accepts HTML options" do
    render_inline(described_class.new(name: :agree, id: :agree))
    expect(rendered_content).to include('name="agree"')
    expect(rendered_content).to include('id="agree"')
  end

  it "accepts checked attribute" do
    render_inline(described_class.new(checked: true))
    expect(rendered_content).to include("checked")
  end

  it "accepts value attribute" do
    render_inline(described_class.new(value: "1"))
    expect(rendered_content).to include('value="1"')
  end
end
