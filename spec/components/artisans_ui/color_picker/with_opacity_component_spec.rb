# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::ColorPicker::WithOpacityComponent, type: :component do
  it "renders Shoelace color picker with opacity enabled" do
    render_inline(described_class.new)
    expect(rendered_content).to include("sl-color-picker")
    expect(rendered_content).to include("opacity")
  end

  it "renders with default label" do
    render_inline(described_class.new)
    expect(rendered_content).to include('label="Background Color"')
  end

  it "renders with custom label" do
    render_inline(described_class.new(label: "Overlay Color"))
    expect(rendered_content).to include('label="Overlay Color"')
  end

  it "renders with default value including alpha" do
    render_inline(described_class.new)
    expect(rendered_content).to include('value="#f5a623ff"')
  end

  it "renders with custom value" do
    render_inline(described_class.new(value: "#3b82f680"))
    expect(rendered_content).to include('value="#3b82f680"')
  end

  it "sets format to hex" do
    render_inline(described_class.new)
    expect(rendered_content).to include('format="hex"')
  end

  it "disables format toggle" do
    render_inline(described_class.new)
    expect(rendered_content).to include("no-format-toggle")
  end

  it "renders HEX with alpha display" do
    render_inline(described_class.new(value: "#f5a623ff"))
    expect(rendered_content).to include("Hex (with alpha):")
    expect(rendered_content).to include("#f5a623ff")
  end

  it "renders RGBA display with correct conversion" do
    render_inline(described_class.new(value: "#f5a623ff"))
    expect(rendered_content).to include("RGBA:")
    expect(rendered_content).to include("rgba(245, 166, 35, 1.0)")
  end

  it "handles alpha channel in RGBA conversion" do
    render_inline(described_class.new(value: "#3b82f680"))
    expect(rendered_content).to include("rgba(59, 130, 246, 0.5)")
  end

  it "renders transparency preview section" do
    render_inline(described_class.new)
    expect(rendered_content).to include("Preview:")
    expect(rendered_content).to include("text-center")
  end

  it "renders checkerboard background for transparency" do
    render_inline(described_class.new)
    expect(rendered_content).to include("checkerboard-bg")
    expect(rendered_content).to include("opacity-20")
  end

  it "includes CSS for checkerboard pattern" do
    render_inline(described_class.new)
    expect(rendered_content).to include("linear-gradient(45deg, #e5e7eb 25%, transparent 25%)")
    expect(rendered_content).to include("background-size: 20px 20px")
  end

  it "includes dark mode checkerboard pattern" do
    render_inline(described_class.new)
    expect(rendered_content).to include(".dark .checkerboard-bg")
    expect(rendered_content).to include("#374151")
  end

  it "renders color preview overlay" do
    render_inline(described_class.new(value: "#f5a623ff", id: "test-opacity"))
    expect(rendered_content).to include('id="test-opacity-preview"')
    expect(rendered_content).to include("background-color: #f5a623ff")
  end

  it "includes JavaScript for color conversion" do
    render_inline(described_class.new(id: "test-picker"))
    expect(rendered_content).to include("document.addEventListener(&#39;turbo:load&#39;")
    expect(rendered_content).to include("sl-change")
    expect(rendered_content).to include("parseInt(color.slice(1, 3), 16)")
    expect(rendered_content).to include("/ 255).toFixed(2)")
  end

  it "generates unique ID when not provided" do
    render_inline(described_class.new)
    expect(rendered_content).to match(/id="opacity_picker_[a-f0-9]{8}"/)
  end

  it "includes proper styling classes" do
    render_inline(described_class.new)
    expect(rendered_content).to include("space-y-4")
    expect(rendered_content).to include("flex flex-col gap-2")
    expect(rendered_content).to include("rounded-lg")
  end

  it "includes dark mode classes" do
    render_inline(described_class.new)
    expect(rendered_content).to include("dark:text-neutral-400")
    expect(rendered_content).to include("dark:bg-neutral-800")
    expect(rendered_content).to include("dark:outline-white/20")
  end
end
