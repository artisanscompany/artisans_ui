# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::ColorPicker::BasicComponent, type: :component do
  it "renders a basic HTML5 color input by default" do
    render_inline(described_class.new(name: "color"))
    expect(rendered_content).to include('type="color"')
    expect(rendered_content).to include('name="color"')
    expect(rendered_content).to include('value="#3b82f6"')
  end

  it "renders with custom value" do
    render_inline(described_class.new(name: "theme_color", value: "#8b5cf6"))
    expect(rendered_content).to include('value="#8b5cf6"')
  end

  it "renders with label when provided" do
    render_inline(described_class.new(name: "color", label: "Choose a color"))
    expect(rendered_content).to include("Choose a color")
    expect(rendered_content).to include("<label")
    expect(rendered_content).to include("text-neutral-700")
  end

  it "renders without label when not provided" do
    render_inline(described_class.new(name: "color"))
    expect(rendered_content).not_to include("<label")
  end

  it "renders with custom ID" do
    render_inline(described_class.new(name: "color", id: "custom-picker"))
    expect(rendered_content).to include('id="custom-picker"')
  end

  it "generates auto ID when not provided" do
    render_inline(described_class.new(name: "color"))
    expect(rendered_content).to match(/id="color_picker_[a-f0-9]{8}"/)
  end

  it "includes proper Tailwind styling classes" do
    render_inline(described_class.new(name: "color"))
    expect(rendered_content).to include("size-10")
    expect(rendered_content).to include("rounded-lg")
    expect(rendered_content).to include("cursor-pointer")
    expect(rendered_content).to include("hover:scale-105")
    expect(rendered_content).to include("transition-transform")
  end

  it "includes dark mode classes" do
    render_inline(described_class.new(name: "color"))
    expect(rendered_content).to include("dark:outline-white/20")
    expect(rendered_content).to include("dark:focus-visible:outline-neutral-200")
  end

  it "includes custom CSS for color input styling" do
    render_inline(described_class.new(name: "color"))
    expect(rendered_content).to include("-webkit-appearance: none")
    expect(rendered_content).to include("-moz-appearance: none")
    expect(rendered_content).to include("appearance: none")
    expect(rendered_content).to include("::-webkit-color-swatch")
  end

  it "renders with custom HTML options" do
    render_inline(described_class.new(name: "color", disabled: true))
    expect(rendered_content).to include("disabled")
  end

  it "wraps input in flex container" do
    render_inline(described_class.new(name: "color"))
    expect(rendered_content).to include("flex flex-col items-center gap-2")
  end
end
