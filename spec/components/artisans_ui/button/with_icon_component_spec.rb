# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Button::WithIconComponent, type: :component do
  let(:icon_svg) do
    '<svg class="size-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" /></svg>'
  end

  it "renders a button with text and icon on left by default" do
    render_inline(described_class.new(text: "Add Item", icon: icon_svg))

    expect(rendered_content).to include("Add Item")
    expect(rendered_content).to include("<svg")
    expect(rendered_content).to include('type="button"')
  end

  it "renders a button with icon on left" do
    render_inline(described_class.new(text: "Add Item", icon: icon_svg, icon_position: :left))

    expect(rendered_content).to include("Add Item")
    expect(rendered_content).to include("<svg")
    # Icon SVG should appear before the text in the HTML
    svg_position = rendered_content.index("<svg")
    text_position = rendered_content.index("Add Item")
    expect(svg_position).to be < text_position
  end

  it "renders a button with icon on right" do
    render_inline(described_class.new(text: "Continue", icon: icon_svg, icon_position: :right))

    expect(rendered_content).to include("Continue")
    expect(rendered_content).to include("<svg")
    # Text should appear before the icon SVG in the HTML
    text_position = rendered_content.index("Continue")
    svg_position = rendered_content.index("<svg")
    expect(text_position).to be < svg_position
  end

  it "renders a neutral button by default" do
    render_inline(described_class.new(text: "Neutral", icon: icon_svg))

    expect(rendered_content).to include("bg-neutral-800")
    expect(rendered_content).to include("text-white")
  end

  it "renders a colored (blue) button" do
    render_inline(described_class.new(text: "Save", icon: icon_svg, variant: :colored))

    expect(rendered_content).to include("bg-blue-600")
    expect(rendered_content).to include("text-white")
  end

  it "renders a secondary button" do
    render_inline(described_class.new(text: "Cancel", icon: icon_svg, variant: :secondary))

    expect(rendered_content).to include("bg-white/90")
    expect(rendered_content).to include("text-neutral-800")
  end

  it "renders a danger button" do
    render_inline(described_class.new(text: "Delete", icon: icon_svg, variant: :danger))

    expect(rendered_content).to include("bg-red-600")
    expect(rendered_content).to include("text-white")
  end

  it "renders a regular sized button by default" do
    render_inline(described_class.new(text: "Regular", icon: icon_svg))

    expect(rendered_content).to include("px-3.5")
    expect(rendered_content).to include("py-2")
    expect(rendered_content).to include("text-sm")
  end

  it "renders a small sized button" do
    render_inline(described_class.new(text: "Small", icon: icon_svg, size: :small))

    expect(rendered_content).to include("px-3")
    expect(rendered_content).to include("py-2")
    expect(rendered_content).to include("text-xs")
  end

  it "renders the SVG icon" do
    render_inline(described_class.new(text: "Button", icon: icon_svg))

    expect(rendered_content).to include("viewBox=\"0 0 24 24\"")
    expect(rendered_content).to include("stroke=\"currentColor\"")
  end

  it "renders the text content" do
    render_inline(described_class.new(text: "Click Me", icon: icon_svg))

    expect(rendered_content).to include("Click Me")
  end

  it "renders a disabled button" do
    render_inline(described_class.new(text: "Disabled", icon: icon_svg, disabled: true))

    expect(rendered_content).to include("Disabled")
    expect(rendered_content).to include("disabled")
    expect(rendered_content).to include("disabled:cursor-not-allowed")
    expect(rendered_content).to include("disabled:opacity-50")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(
      text: "Custom",
      icon: icon_svg,
      id: "with-icon-button",
      data: { action: "click->controller#add" },
      class: "custom-class"
    ))

    expect(rendered_content).to include("Custom")
    expect(rendered_content).to include('id="with-icon-button"')
    expect(rendered_content).to include('data-action="click-&gt;controller#add"')
    expect(rendered_content).to include("custom-class")
  end

  it "includes base classes for all buttons" do
    render_inline(described_class.new(text: "Button", icon: icon_svg))

    expect(rendered_content).to include("flex")
    expect(rendered_content).to include("items-center")
    expect(rendered_content).to include("justify-center")
    expect(rendered_content).to include("gap-1.5")
    expect(rendered_content).to include("rounded-lg")
  end

  it "raises an error for invalid variant" do
    expect {
      described_class.new(text: "Button", icon: icon_svg, variant: :invalid)
    }.to raise_error(ArgumentError, "Invalid variant: invalid")
  end

  it "raises an error for invalid size" do
    expect {
      described_class.new(text: "Button", icon: icon_svg, size: :invalid)
    }.to raise_error(ArgumentError, "Invalid size: invalid")
  end

  it "raises an error for invalid icon_position" do
    expect {
      described_class.new(text: "Button", icon: icon_svg, icon_position: :invalid)
    }.to raise_error(ArgumentError, "Invalid icon_position: invalid")
  end
end
