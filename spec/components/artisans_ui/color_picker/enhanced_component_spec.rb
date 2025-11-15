# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::ColorPicker::EnhancedComponent, type: :component do
  it "renders Shoelace color picker element" do
    render_inline(described_class.new)
    expect(rendered_content).to include("sl-color-picker")
  end

  it "renders with default label" do
    render_inline(described_class.new)
    expect(rendered_content).to include('label="Brand Color"')
  end

  it "renders with custom label" do
    render_inline(described_class.new(label: "Theme Color"))
    expect(rendered_content).to include('label="Theme Color"')
  end

  it "renders with default value" do
    render_inline(described_class.new)
    expect(rendered_content).to include('value="#3b82f6"')
  end

  it "renders with custom value" do
    render_inline(described_class.new(value: "#8b5cf6"))
    expect(rendered_content).to include('value="#8b5cf6"')
  end

  it "renders with default hex format" do
    render_inline(described_class.new)
    expect(rendered_content).to include('format="hex"')
  end

  it "renders with custom format" do
    render_inline(described_class.new(format: "rgb"))
    expect(rendered_content).to include('format="rgb"')
  end

  it "renders with default medium size" do
    render_inline(described_class.new)
    expect(rendered_content).to include('size="medium"')
  end

  it "renders current value display" do
    render_inline(described_class.new(value: "#3b82f6"))
    expect(rendered_content).to include("Current value:")
    expect(rendered_content).to include("#3b82f6")
    expect(rendered_content).to include("font-mono")
  end

  it "includes proper styling for value display" do
    render_inline(described_class.new)
    expect(rendered_content).to include("text-neutral-600")
    expect(rendered_content).to include("dark:text-neutral-400")
    expect(rendered_content).to include("bg-neutral-100")
    expect(rendered_content).to include("dark:bg-neutral-800")
  end

  it "generates unique ID when not provided" do
    render_inline(described_class.new)
    expect(rendered_content).to match(/id="enhanced_picker_[a-f0-9]{8}"/)
  end

  it "uses custom ID when provided" do
    render_inline(described_class.new(id: "custom-enhanced"))
    expect(rendered_content).to include('id="custom-enhanced"')
  end

  it "includes JavaScript for sl-change event handling" do
    render_inline(described_class.new(id: "test-picker"))
    expect(rendered_content).to include("document.addEventListener(&#39;turbo:load&#39;")
    expect(rendered_content).to include("getElementById(&#39;test-picker&#39;)")
    expect(rendered_content).to include("sl-change")
    expect(rendered_content).to include("e.target.value")
  end

  it "wraps content in proper container" do
    render_inline(described_class.new)
    expect(rendered_content).to include("space-y-4")
    expect(rendered_content).to include("flex flex-col items-center gap-2")
  end

  it "includes dark mode classes" do
    render_inline(described_class.new)
    expect(rendered_content).to include("dark:text-neutral-400")
    expect(rendered_content).to include("dark:bg-neutral-800")
  end
end
