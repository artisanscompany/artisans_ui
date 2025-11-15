# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Badge::ColorVariantComponent, type: :component do
  it "renders a soft red badge by default" do
    render_inline(described_class.new(text: "Red", color: :red))

    expect(rendered_content).to include("Red")
    expect(rendered_content).to include("inline-flex")
    expect(rendered_content).to include("items-center")
    expect(rendered_content).to include("rounded-md")
    expect(rendered_content).to include("bg-red-100")
    expect(rendered_content).to include("text-red-700")
  end

  it "renders a solid green badge" do
    render_inline(described_class.new(text: "Green", color: :green, style: :solid))

    expect(rendered_content).to include("Green")
    expect(rendered_content).to include("bg-green-500")
    expect(rendered_content).to include("text-white")
  end

  it "renders a soft blue badge" do
    render_inline(described_class.new(text: "Blue", color: :blue, style: :soft))

    expect(rendered_content).to include("Blue")
    expect(rendered_content).to include("bg-blue-100")
    expect(rendered_content).to include("text-blue-700")
  end

  it "renders a solid yellow badge" do
    render_inline(described_class.new(text: "Yellow", color: :yellow, style: :solid))

    expect(rendered_content).to include("Yellow")
    expect(rendered_content).to include("bg-yellow-500")
    expect(rendered_content).to include("text-white")
  end

  it "renders a soft purple badge" do
    render_inline(described_class.new(text: "Purple", color: :purple, style: :soft))

    expect(rendered_content).to include("Purple")
    expect(rendered_content).to include("bg-purple-100")
    expect(rendered_content).to include("text-purple-700")
  end

  it "renders a solid pink badge" do
    render_inline(described_class.new(text: "Pink", color: :pink, style: :solid))

    expect(rendered_content).to include("Pink")
    expect(rendered_content).to include("bg-pink-500")
    expect(rendered_content).to include("text-white")
  end

  it "renders a soft indigo badge" do
    render_inline(described_class.new(text: "Indigo", color: :indigo, style: :soft))

    expect(rendered_content).to include("Indigo")
    expect(rendered_content).to include("bg-indigo-100")
    expect(rendered_content).to include("text-indigo-700")
  end

  it "renders a solid orange badge" do
    render_inline(described_class.new(text: "Orange", color: :orange, style: :solid))

    expect(rendered_content).to include("Orange")
    expect(rendered_content).to include("bg-orange-500")
    expect(rendered_content).to include("text-white")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(
      text: "Custom",
      color: :blue,
      id: "custom-badge",
      data: { test: "value" }
    ))

    expect(rendered_content).to include("Custom")
    expect(rendered_content).to include('id="custom-badge"')
    expect(rendered_content).to include('data-test="value"')
  end

  it "raises an error for invalid color" do
    expect {
      described_class.new(text: "Test", color: :invalid)
    }.to raise_error(ArgumentError, "Invalid color: invalid")
  end

  it "raises an error for invalid style" do
    expect {
      described_class.new(text: "Test", color: :red, style: :invalid)
    }.to raise_error(ArgumentError, "Invalid style: invalid. Must be :solid or :soft")
  end

  it "supports dark mode classes for soft style" do
    render_inline(described_class.new(text: "Dark Mode", color: :green, style: :soft))

    expect(rendered_content).to include("dark:bg-green-900/30")
    expect(rendered_content).to include("dark:text-green-300")
  end
end
