# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::ColorPicker::FormatVariationsComponent, type: :component do
  it "renders description text" do
    render_inline(described_class.new)
    expect(rendered_content).to include("Choose the output format that best suits your needs")
    expect(rendered_content).to include("text-neutral-500")
    expect(rendered_content).to include("dark:text-neutral-400")
  end

  it "renders grid layout for formats" do
    render_inline(described_class.new)
    expect(rendered_content).to include("grid grid-cols-1 md:grid-cols-2 gap-6")
  end

  it "renders HEX format picker" do
    render_inline(described_class.new)
    expect(rendered_content).to include('label="HEX Format"')
    expect(rendered_content).to include('format="hex"')
    expect(rendered_content).to include("#4a90e2")
  end

  it "renders RGB format picker" do
    render_inline(described_class.new)
    expect(rendered_content).to include('label="RGB Format"')
    expect(rendered_content).to include('format="rgb"')
    expect(rendered_content).to include("rgb(80, 227, 194)")
  end

  it "renders HSL format picker" do
    render_inline(described_class.new)
    expect(rendered_content).to include('label="HSL Format"')
    expect(rendered_content).to include('format="hsl"')
    expect(rendered_content).to include("hsl(290, 87%, 47%)")
  end

  it "renders HSV format picker" do
    render_inline(described_class.new)
    expect(rendered_content).to include('label="HSV Format"')
    expect(rendered_content).to include('format="hsv"')
    expect(rendered_content).to include("hsv(55, 89%, 97%)")
  end

  it "renders output displays for all formats" do
    render_inline(described_class.new)
    expect(rendered_content).to include("Output:")
    expect(rendered_content.scan(/Output:/).count).to eq(4)
  end

  it "renders with custom initial values" do
    render_inline(described_class.new(
      hex_value: "#ff0000",
      rgb_value: "rgb(0, 255, 0)",
      hsl_value: "hsl(240, 100%, 50%)",
      hsv_value: "hsv(60, 100%, 100%)"
    ))
    expect(rendered_content).to include("#ff0000")
    expect(rendered_content).to include("rgb(0, 255, 0)")
    expect(rendered_content).to include("hsl(240, 100%, 50%)")
    expect(rendered_content).to include("hsv(60, 100%, 100%)")
  end

  it "sets size to small for all pickers" do
    render_inline(described_class.new)
    expect(rendered_content.scan(/size="small"/).count).to eq(4)
  end

  it "generates unique IDs for all pickers and outputs" do
    render_inline(described_class.new)
    expect(rendered_content).to match(/id="format_variations_[a-f0-9]{8}-hex-picker"/)
    expect(rendered_content).to match(/id="format_variations_[a-f0-9]{8}-hex-output"/)
    expect(rendered_content).to match(/id="format_variations_[a-f0-9]{8}-rgb-picker"/)
    expect(rendered_content).to match(/id="format_variations_[a-f0-9]{8}-rgb-output"/)
  end

  it "includes JavaScript for all format updates" do
    render_inline(described_class.new)
    expect(rendered_content).to include("document.addEventListener(&#39;turbo:load&#39;")
    expect(rendered_content).to include("[&#39;hex&#39;, &#39;rgb&#39;, &#39;hsl&#39;, &#39;hsv&#39;].forEach")
    expect(rendered_content).to include("sl-change")
    expect(rendered_content).to include("output.textContent = e.target.value")
  end

  it "includes proper styling for output displays" do
    render_inline(described_class.new)
    expect(rendered_content).to include("font-mono")
    expect(rendered_content).to include("bg-neutral-100")
    expect(rendered_content).to include("dark:bg-neutral-800")
    expect(rendered_content).to include("text-neutral-700")
    expect(rendered_content).to include("dark:text-neutral-300")
  end

  it "wraps each picker in centered container" do
    render_inline(described_class.new)
    expect(rendered_content).to include("flex flex-col items-center")
  end

  it "includes dark mode classes" do
    render_inline(described_class.new)
    expect(rendered_content).to include("dark:text-neutral-400")
    expect(rendered_content).to include("dark:bg-neutral-800")
    expect(rendered_content).to include("dark:text-neutral-300")
  end
end
