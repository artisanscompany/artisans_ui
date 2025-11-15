# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Kbd::BasicComponent, type: :component do
  it "renders a kbd element" do
    render_inline(described_class.new) { "A" }
    expect(rendered_content).to include("<kbd>")
    expect(rendered_content).to include("A")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(class: "custom-class")) { "Ctrl" }
    expect(rendered_content).to include("custom-class")
    expect(rendered_content).to include("Ctrl")
  end

  it "renders content from block" do
    render_inline(described_class.new) { "Enter" }
    expect(rendered_content).to include("Enter")
  end

  it "renders special characters" do
    render_inline(described_class.new) { "⌘" }
    expect(rendered_content).to include("⌘")
  end

  it "renders with data attributes" do
    render_inline(described_class.new(data: { test: "value" })) { "S" }
    expect(rendered_content).to include('data-test="value"')
    expect(rendered_content).to include("S")
  end

  it "renders as proper kbd element" do
    render_inline(described_class.new) { "Shift" }
    expect(rendered_content).to include("<kbd>")
    expect(rendered_content).to include("</kbd>")
  end
end
