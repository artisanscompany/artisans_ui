# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Button::LoadingComponent, type: :component do
  it "renders a normal state button when not loading" do
    render_inline(described_class.new(text: "Submit", loading: false))

    expect(rendered_content).to include("Submit")
    expect(rendered_content).not_to include("Loading...")
    expect(rendered_content).not_to include("animate-spin")
    expect(rendered_content).not_to include('disabled="disabled"')
  end

  it "renders a loading state button" do
    render_inline(described_class.new(text: "Submit", loading: true))

    expect(rendered_content).to include("Loading...")
    expect(rendered_content).to include("animate-spin")
    expect(rendered_content).to include("disabled")
  end

  it "renders the spinner SVG when loading" do
    render_inline(described_class.new(text: "Submit", loading: true))

    expect(rendered_content).to include("<svg")
    expect(rendered_content).to include("animate-spin")
    expect(rendered_content).to include("size-4")
    expect(rendered_content).to include("viewBox=\"0 0 24 24\"")
  end

  it "disables the button when loading" do
    render_inline(described_class.new(text: "Submit", loading: true))

    expect(rendered_content).to include("disabled")
    expect(rendered_content).to include("disabled:cursor-not-allowed")
  end

  it "renders custom loading text" do
    render_inline(described_class.new(text: "Submit", loading: true, loading_text: "Processing..."))

    expect(rendered_content).to include("Processing...")
    expect(rendered_content).not_to include("Submit")
  end

  it "renders a neutral button by default" do
    render_inline(described_class.new(text: "Button", loading: false))

    expect(rendered_content).to include("bg-neutral-800")
    expect(rendered_content).to include("text-white")
  end

  it "renders a colored (blue) button" do
    render_inline(described_class.new(text: "Save", loading: true, variant: :colored))

    expect(rendered_content).to include("bg-blue-600")
    expect(rendered_content).to include("text-white")
  end

  it "renders a secondary button" do
    render_inline(described_class.new(text: "Cancel", loading: false, variant: :secondary))

    expect(rendered_content).to include("bg-white/90")
    expect(rendered_content).to include("text-neutral-800")
  end

  it "renders a danger button" do
    render_inline(described_class.new(text: "Delete", loading: true, variant: :danger))

    expect(rendered_content).to include("bg-red-600")
    expect(rendered_content).to include("text-white")
  end

  it "renders a regular sized button by default" do
    render_inline(described_class.new(text: "Regular", loading: false))

    expect(rendered_content).to include("px-3.5")
    expect(rendered_content).to include("py-2")
    expect(rendered_content).to include("text-sm")
  end

  it "renders a small sized button" do
    render_inline(described_class.new(text: "Small", loading: false, size: :small))

    expect(rendered_content).to include("px-3")
    expect(rendered_content).to include("py-2")
    expect(rendered_content).to include("text-xs")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(
      text: "Custom",
      loading: false,
      id: "loading-button",
      data: { action: "click->controller#submit" },
      class: "custom-class"
    ))

    expect(rendered_content).to include('id="loading-button"')
    expect(rendered_content).to include('data-action="click-&gt;controller#submit"')
    expect(rendered_content).to include("custom-class")
  end

  it "includes base classes for all buttons" do
    render_inline(described_class.new(text: "Button", loading: false))

    expect(rendered_content).to include("flex")
    expect(rendered_content).to include("items-center")
    expect(rendered_content).to include("justify-center")
    expect(rendered_content).to include("gap-1.5")
    expect(rendered_content).to include("rounded-lg")
  end

  it "renders with nil variant (no variant classes)" do
    render_inline(described_class.new(text: "Custom", loading: false, variant: nil, class: "bg-purple-500"))

    expect(rendered_content).to include("Custom")
    expect(rendered_content).to include("bg-purple-500")
    expect(rendered_content).not_to include("bg-neutral-800")
    expect(rendered_content).not_to include("bg-blue-600")
  end

  it "raises an error for invalid variant" do
    expect {
      described_class.new(text: "Button", loading: false, variant: :invalid)
    }.to raise_error(ArgumentError, "Invalid variant: invalid")
  end

  it "raises an error for invalid size" do
    expect {
      described_class.new(text: "Button", loading: false, size: :invalid)
    }.to raise_error(ArgumentError, "Invalid size: invalid")
  end
end
