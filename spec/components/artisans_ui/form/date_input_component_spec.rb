# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Form::DateInputComponent, type: :component do
  it "renders a date input" do
    render_inline(described_class.new)
    expect(rendered_content).to include('type="date"')
    expect(rendered_content).to include('<input')
  end

  it "includes default styling" do
    render_inline(described_class.new)
    expect(rendered_content).to include("border-neutral-300")
    expect(rendered_content).to include("rounded-lg")
  end

  it "supports dark mode" do
    render_inline(described_class.new)
    expect(rendered_content).to include("dark:bg-neutral-900")
    expect(rendered_content).to include("dark:text-white")
  end

  it "accepts HTML options" do
    render_inline(described_class.new(name: :birth_date, required: true))
    expect(rendered_content).to include('name="birth_date"')
    expect(rendered_content).to include("required")
  end

  it "accepts min attribute" do
    render_inline(described_class.new(min: "2024-01-01"))
    expect(rendered_content).to include('min="2024-01-01"')
  end

  it "accepts max attribute" do
    render_inline(described_class.new(max: "2024-12-31"))
    expect(rendered_content).to include('max="2024-12-31"')
  end
end
