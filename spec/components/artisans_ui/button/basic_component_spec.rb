# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Button::BasicComponent, type: :component do
  it "renders a neutral button by default" do
    render_inline(described_class.new) { "Neutral Button" }

    expect(rendered_content).to include("Neutral Button")
    expect(rendered_content).to include("bg-neutral-800")
    expect(rendered_content).to include("text-white")
    expect(rendered_content).to include('type="button"')
  end

  it "renders a colored (blue) button" do
    render_inline(described_class.new(variant: :colored)) { "Colored Button" }

    expect(rendered_content).to include("Colored Button")
    expect(rendered_content).to include("bg-blue-600")
    expect(rendered_content).to include("text-white")
  end

  it "renders a secondary (white) button" do
    render_inline(described_class.new(variant: :secondary)) { "Secondary Button" }

    expect(rendered_content).to include("Secondary Button")
    expect(rendered_content).to include("bg-white/90")
    expect(rendered_content).to include("text-neutral-800")
  end

  it "renders a danger (red) button" do
    render_inline(described_class.new(variant: :danger)) { "Delete Button" }

    expect(rendered_content).to include("Delete Button")
    expect(rendered_content).to include("bg-red-600")
    expect(rendered_content).to include("text-white")
  end

  it "renders a regular sized button by default" do
    render_inline(described_class.new) { "Regular" }

    expect(rendered_content).to include("px-3.5")
    expect(rendered_content).to include("py-2")
    expect(rendered_content).to include("text-sm")
  end

  it "renders a small sized button" do
    render_inline(described_class.new(size: :small)) { "Small" }

    expect(rendered_content).to include("px-3")
    expect(rendered_content).to include("py-2")
    expect(rendered_content).to include("text-xs")
  end

  it "renders a disabled button" do
    render_inline(described_class.new(disabled: true)) { "Disabled" }

    expect(rendered_content).to include("Disabled")
    expect(rendered_content).to include("disabled")
    expect(rendered_content).to include("disabled:cursor-not-allowed")
    expect(rendered_content).to include("disabled:opacity-50")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(
      id: "custom-button",
      data: { action: "click->controller#action" },
      class: "extra-class"
    )) { "Custom" }

    expect(rendered_content).to include("Custom")
    expect(rendered_content).to include('id="custom-button"')
    expect(rendered_content).to include('data-action="click-&gt;controller#action"')
    expect(rendered_content).to include("extra-class")
  end

  it "includes base classes for all buttons" do
    render_inline(described_class.new) { "Button" }

    expect(rendered_content).to include("flex")
    expect(rendered_content).to include("items-center")
    expect(rendered_content).to include("justify-center")
    expect(rendered_content).to include("rounded-lg")
    expect(rendered_content).to include("border")
    expect(rendered_content).to include("shadow-sm")
  end

  it "includes dark mode classes" do
    render_inline(described_class.new(variant: :neutral)) { "Dark Mode" }

    expect(rendered_content).to include("dark:bg-white")
    expect(rendered_content).to include("dark:text-neutral-800")
  end

  it "includes transition classes" do
    render_inline(described_class.new) { "Transition" }

    expect(rendered_content).to include("transition-all")
    expect(rendered_content).to include("duration-100")
    expect(rendered_content).to include("ease-in-out")
  end

  it "includes focus-visible classes" do
    render_inline(described_class.new) { "Focus" }

    expect(rendered_content).to include("focus-visible:outline-2")
    expect(rendered_content).to include("focus-visible:outline-offset-2")
  end

  it "raises an error for invalid variant" do
    expect {
      described_class.new(variant: :invalid)
    }.to raise_error(ArgumentError, "Invalid variant: invalid")
  end

  it "raises an error for invalid size" do
    expect {
      described_class.new(size: :invalid)
    }.to raise_error(ArgumentError, "Invalid size: invalid")
  end
end
