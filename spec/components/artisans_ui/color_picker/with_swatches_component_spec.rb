# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::ColorPicker::WithSwatchesComponent, type: :component do
  let(:default_swatches) do
    {
      "Violet 100" => "#ede9fe",
      "Violet 500" => "#8b5cf6",
      "Violet 900" => "#4c1d95"
    }
  end

  it "renders HTML5 color input with datalist" do
    render_inline(described_class.new(label: "Theme Color", name: "theme_color"))
    expect(rendered_content).to include('type="color"')
    expect(rendered_content).to include("<datalist")
    expect(rendered_content).to include("list=")
  end

  it "renders with label" do
    render_inline(described_class.new(label: "Brand Color", name: "brand_color"))
    expect(rendered_content).to include("Brand Color")
    expect(rendered_content).to include("text-neutral-700")
    expect(rendered_content).to include("dark:text-neutral-300")
  end

  it "renders with default value" do
    render_inline(described_class.new(label: "Color", name: "color"))
    expect(rendered_content).to include('value="#8b5cf6"')
  end

  it "renders with custom value" do
    render_inline(described_class.new(label: "Color", name: "color", value: "#4c1d95"))
    expect(rendered_content).to include('value="#4c1d95"')
  end

  it "renders datalist with default swatches" do
    render_inline(described_class.new(label: "Color", name: "color"))
    expect(rendered_content).to include("Violet 100")
    expect(rendered_content).to include("#ede9fe")
    expect(rendered_content).to include("Violet 900")
    expect(rendered_content).to include("#4c1d95")
  end

  it "renders datalist with custom swatches" do
    render_inline(described_class.new(
      label: "Color",
      name: "color",
      swatches: { "Red" => "#ff0000", "Blue" => "#0000ff" }
    ))
    expect(rendered_content).to include("Red")
    expect(rendered_content).to include("#ff0000")
    expect(rendered_content).to include("Blue")
    expect(rendered_content).to include("#0000ff")
  end

  it "renders description text" do
    render_inline(described_class.new(label: "Color", name: "color"))
    expect(rendered_content).to include("Pick from predefined colors or choose custom")
    expect(rendered_content).to include("text-neutral-600")
    expect(rendered_content).to include("dark:text-neutral-400")
  end

  it "renders current value display" do
    render_inline(described_class.new(label: "Color", name: "color", value: "#8b5cf6"))
    expect(rendered_content).to include("#8b5cf6")
    expect(rendered_content).to include("font-mono")
  end

  it "renders quick select section" do
    render_inline(described_class.new(label: "Color", name: "color"))
    expect(rendered_content).to include("Quick select:")
    expect(rendered_content).to include("text-neutral-700")
  end

  it "renders swatch buttons for all colors" do
    render_inline(described_class.new(
      label: "Color",
      name: "color",
      swatches: default_swatches
    ))
    default_swatches.each_value do |color|
      expect(rendered_content).to include("background-color: #{color}")
      expect(rendered_content).to include('data-color=')
    end
  end

  it "includes hover and focus styles on swatches" do
    render_inline(described_class.new(label: "Color", name: "color"))
    expect(rendered_content).to include("hover:scale-110")
    expect(rendered_content).to include("focus-visible:outline-2")
  end

  it "includes JavaScript for interactivity" do
    render_inline(described_class.new(label: "Color", name: "color", id: "test-picker"))
    expect(rendered_content).to include("document.addEventListener(&#39;turbo:load&#39;")
    expect(rendered_content).to include("getElementById(&#39;test-picker&#39;)")
    expect(rendered_content).to include("addEventListener(&#39;change&#39;")
  end

  it "includes custom CSS for color input" do
    render_inline(described_class.new(label: "Color", name: "color"))
    expect(rendered_content).to include("-webkit-appearance: none")
    expect(rendered_content).to include("::-webkit-color-swatch")
  end

  it "generates unique IDs for input and datalist" do
    render_inline(described_class.new(label: "Color", name: "color"))
    expect(rendered_content).to match(/id="color_picker_swatches_[a-f0-9]{8}"/)
    expect(rendered_content).to match(/list="color_picker_swatches_[a-f0-9]{8}-colors"/)
  end

  it "includes dark mode classes" do
    render_inline(described_class.new(label: "Color", name: "color"))
    expect(rendered_content).to include("dark:text-neutral-300")
    expect(rendered_content).to include("dark:text-neutral-400")
    expect(rendered_content).to include("dark:outline-white/20")
  end
end
