# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::ColorPicker::WithPaletteComponent, type: :component do
  it "renders Shoelace color picker with swatches" do
    render_inline(described_class.new)
    expect(rendered_content).to include("sl-color-picker")
    expect(rendered_content).to include("swatches=")
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
    expect(rendered_content).to include('value="#4a5568"')
  end

  it "renders with custom value" do
    render_inline(described_class.new(value: "#3b82f6"))
    expect(rendered_content).to include('value="#3b82f6"')
  end

  it "renders Brand Palette heading" do
    render_inline(described_class.new)
    expect(rendered_content).to include("Brand Palette")
    expect(rendered_content).to include("text-neutral-600")
    expect(rendered_content).to include("dark:text-neutral-400")
  end

  it "renders Neutrals color group" do
    render_inline(described_class.new)
    expect(rendered_content).to include("Neutrals")
    expect(rendered_content).to include("uppercase")
    expect(rendered_content).to include("tracking-wide")
  end

  it "renders Accents color group" do
    render_inline(described_class.new)
    expect(rendered_content).to include("Accents")
  end

  it "renders default neutral colors" do
    render_inline(described_class.new)
    expect(rendered_content).to include("#1a202c") # Gray 900
    expect(rendered_content).to include("#4a5568") # Gray 700
    expect(rendered_content).to include("#f7fafc") # Gray 50
  end

  it "renders default accent colors" do
    render_inline(described_class.new)
    expect(rendered_content).to include("#fed7d7") # Red 100
    expect(rendered_content).to include("#e53e3e") # Red 500
    expect(rendered_content).to include("#742a2a") # Red 800
  end

  it "renders custom neutral colors" do
    render_inline(described_class.new(neutrals: ["#000000", "#ffffff"]))
    expect(rendered_content).to include("#000000")
    expect(rendered_content).to include("#ffffff")
  end

  it "renders custom accent colors" do
    render_inline(described_class.new(accents: ["#ff0000", "#00ff00"]))
    expect(rendered_content).to include("#ff0000")
    expect(rendered_content).to include("#00ff00")
  end

  it "renders swatch buttons with proper styling" do
    render_inline(described_class.new)
    expect(rendered_content).to include("h-8 w-8")
    expect(rendered_content).to include("rounded-md")
    expect(rendered_content).to include("hover:scale-110")
    expect(rendered_content).to include("transition-transform")
  end

  it "includes data-color attributes on swatch buttons" do
    render_inline(described_class.new)
    expect(rendered_content).to include('data-color="#1a202c"')
    expect(rendered_content).to include('data-color="#fed7d7"')
  end

  it "renders selected color section" do
    render_inline(described_class.new)
    expect(rendered_content).to include("Selected Color:")
    expect(rendered_content).to include("bg-neutral-50")
    expect(rendered_content).to include("dark:bg-neutral-800/50")
  end

  it "renders current value display" do
    render_inline(described_class.new(value: "#4a5568"))
    expect(rendered_content).to include("#4a5568")
    expect(rendered_content).to include("font-mono")
  end

  it "renders Add to Palette button" do
    render_inline(described_class.new)
    expect(rendered_content).to include("Add to Palette")
    expect(rendered_content).to include("bg-white")
    expect(rendered_content).to include("dark:bg-neutral-900")
  end

  it "includes JavaScript for swatch interactions" do
    render_inline(described_class.new(id: "test-palette"))
    expect(rendered_content).to include("document.addEventListener(&#39;turbo:load&#39;")
    expect(rendered_content).to include("getElementById(&#39;test-palette&#39;)")
    expect(rendered_content).to include("sl-change")
    expect(rendered_content).to include("updateBrandSwatchSelection")
  end

  it "includes add to palette functionality in JavaScript" do
    render_inline(described_class.new)
    expect(rendered_content).to include("console.log(&#39;Adding to palette:&#39;")
    expect(rendered_content).to include("this.textContent = &#39;Added!&#39;")
    expect(rendered_content).to include("setTimeout")
  end

  it "generates unique ID when not provided" do
    render_inline(described_class.new)
    expect(rendered_content).to match(/id="brand_picker_[a-f0-9]{8}"/)
  end

  it "builds swatches string from neutral and accent colors" do
    render_inline(described_class.new)
    # Should include semicolon-separated list
    expect(rendered_content).to include("#1a202c; #2d3748")
  end

  it "includes dark mode classes" do
    render_inline(described_class.new)
    expect(rendered_content).to include("dark:text-neutral-400")
    expect(rendered_content).to include("dark:bg-neutral-800/50")
    expect(rendered_content).to include("dark:border-neutral-700")
    expect(rendered_content).to include("dark:bg-neutral-900")
  end

  it "wraps content in proper spacing container" do
    render_inline(described_class.new)
    expect(rendered_content).to include("space-y-6")
    expect(rendered_content).to include("space-y-4")
  end
end
