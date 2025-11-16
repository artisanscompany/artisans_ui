# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Form::TelInputComponent, type: :component do
  it "renders a tel input" do
    render_inline(described_class.new)
    expect(rendered_content).to include('type="tel"')
    expect(rendered_content).to include('<input')
  end

  it "includes default styling" do
    render_inline(described_class.new)
    expect(rendered_content).to include("border-neutral-200")
    expect(rendered_content).to include("rounded-lg")
  end

  it "supports dark mode" do
    render_inline(described_class.new)
    expect(rendered_content).to include("dark:bg-neutral-900")
    expect(rendered_content).to include("dark:text-white")
  end

  it "accepts HTML options" do
    render_inline(described_class.new(name: :phone, placeholder: "123-456-7890"))
    expect(rendered_content).to include('name="phone"')
    expect(rendered_content).to include('placeholder="123-456-7890"')
  end

  it "accepts pattern attribute" do
    render_inline(described_class.new(pattern: "[0-9]{3}-[0-9]{3}-[0-9]{4}"))
    expect(rendered_content).to include('pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}"')
  end
end
