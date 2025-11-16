# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Form::NumberInputComponent, type: :component do
  it "renders a number input" do
    render_inline(described_class.new)
    expect(rendered_content).to include('type="number"')
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
    render_inline(described_class.new(name: :quantity, min: 0, max: 100))
    expect(rendered_content).to include('name="quantity"')
    expect(rendered_content).to include('min="0"')
    expect(rendered_content).to include('max="100"')
  end

  it "accepts step attribute" do
    render_inline(described_class.new(step: 0.01))
    expect(rendered_content).to include('step="0.01"')
  end

  it "accepts custom classes" do
    render_inline(described_class.new(class: "custom-class"))
    expect(rendered_content).to include("custom-class")
  end
end
