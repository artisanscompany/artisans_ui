# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Badge::WithIconComponent, type: :component do
  it "renders a badge with check icon on the left by default" do
    render_inline(described_class.new(text: "Active"))

    expect(rendered_content).to include("Active")
    expect(rendered_content).to include("inline-flex")
    expect(rendered_content).to include("items-center")
    expect(rendered_content).to include("gap-1.5")
    expect(rendered_content).to include("rounded-md")
    expect(rendered_content).to include("<svg")
  end

  it "renders a success badge with check icon" do
    render_inline(described_class.new(text: "Verified", variant: :success, icon_type: :check))

    expect(rendered_content).to include("Verified")
    expect(rendered_content).to include("bg-green-100")
    expect(rendered_content).to include("text-green-700")
    expect(rendered_content).to include("<svg")
  end

  it "renders a badge with star icon" do
    render_inline(described_class.new(text: "Featured", variant: :primary, icon_type: :star))

    expect(rendered_content).to include("Featured")
    expect(rendered_content).to include("<svg")
    expect(rendered_content).to include("fill=\"currentColor\"")
  end

  it "renders a badge with alert icon" do
    render_inline(described_class.new(text: "Alert", variant: :error, icon_type: :alert))

    expect(rendered_content).to include("Alert")
    expect(rendered_content).to include("bg-red-100")
    expect(rendered_content).to include("text-red-700")
    expect(rendered_content).to include("<svg")
  end

  it "renders a badge with info icon" do
    render_inline(described_class.new(text: "Info", variant: :info, icon_type: :info))

    expect(rendered_content).to include("Info")
    expect(rendered_content).to include("bg-cyan-100")
    expect(rendered_content).to include("text-cyan-700")
    expect(rendered_content).to include("<svg")
  end

  it "renders icon on the right when specified" do
    render_inline(described_class.new(
      text: "New",
      variant: :primary,
      icon_position: :right
    ))

    # Check that text appears before icon in the HTML
    text_index = rendered_content.index("New")
    svg_index = rendered_content.index("<svg")
    expect(text_index).to be < svg_index
  end

  it "renders icon on the left when specified" do
    render_inline(described_class.new(
      text: "Active",
      variant: :success,
      icon_position: :left
    ))

    # Check that icon appears before text in the HTML
    text_index = rendered_content.index("Active")
    svg_index = rendered_content.index("<svg")
    expect(svg_index).to be < text_index
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(
      text: "Custom",
      id: "custom-badge",
      data: { test: "value" }
    ))

    expect(rendered_content).to include("Custom")
    expect(rendered_content).to include('id="custom-badge"')
    expect(rendered_content).to include('data-test="value"')
  end

  it "raises an error for invalid variant" do
    expect {
      described_class.new(text: "Test", variant: :invalid)
    }.to raise_error(ArgumentError, "Invalid variant: invalid")
  end

  it "raises an error for invalid icon_position" do
    expect {
      described_class.new(text: "Test", icon_position: :invalid)
    }.to raise_error(ArgumentError, "Invalid icon_position: invalid. Must be :left or :right")
  end

  it "raises an error for invalid icon_type" do
    expect {
      described_class.new(text: "Test", icon_type: :invalid)
    }.to raise_error(ArgumentError, "Invalid icon_type: invalid")
  end

  it "supports dark mode classes" do
    render_inline(described_class.new(text: "Dark Mode", variant: :neutral))

    expect(rendered_content).to include("dark:bg-neutral-700")
    expect(rendered_content).to include("dark:text-neutral-300")
  end
end
