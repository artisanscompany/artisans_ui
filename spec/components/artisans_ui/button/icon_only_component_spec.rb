# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Button::IconOnlyComponent, type: :component do
  let(:icon_svg) do
    '<svg class="size-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" /></svg>'
  end

  it "renders a neutral icon-only button by default" do
    render_inline(described_class.new) { icon_svg.html_safe }

    expect(rendered_content).to include("<svg")
    expect(rendered_content).to include("bg-neutral-800")
    expect(rendered_content).to include("text-white")
    expect(rendered_content).to include('type="button"')
  end

  it "renders a colored (blue) icon-only button" do
    render_inline(described_class.new(variant: :colored)) { icon_svg.html_safe }

    expect(rendered_content).to include("<svg")
    expect(rendered_content).to include("bg-blue-600")
    expect(rendered_content).to include("text-white")
  end

  it "renders a secondary icon-only button" do
    render_inline(described_class.new(variant: :secondary)) { icon_svg.html_safe }

    expect(rendered_content).to include("<svg")
    expect(rendered_content).to include("bg-white/90")
    expect(rendered_content).to include("text-neutral-800")
  end

  it "renders a danger icon-only button" do
    render_inline(described_class.new(variant: :danger)) { icon_svg.html_safe }

    expect(rendered_content).to include("<svg")
    expect(rendered_content).to include("bg-red-600")
    expect(rendered_content).to include("text-white")
  end

  it "renders a regular sized button by default" do
    render_inline(described_class.new) { icon_svg.html_safe }

    expect(rendered_content).to include("p-2.5")
  end

  it "renders a small sized button" do
    render_inline(described_class.new(size: :small)) { icon_svg.html_safe }

    expect(rendered_content).to include("p-2")
  end

  it "renders a tiny sized button" do
    render_inline(described_class.new(size: :tiny)) { icon_svg.html_safe }

    expect(rendered_content).to include("p-1.5")
  end

  it "renders the SVG icon content" do
    render_inline(described_class.new) { icon_svg.html_safe }

    expect(rendered_content).to include("viewBox=\"0 0 24 24\"")
    expect(rendered_content).to include("stroke=\"currentColor\"")
  end

  it "renders a disabled button" do
    render_inline(described_class.new(disabled: true)) { icon_svg.html_safe }

    expect(rendered_content).to include("disabled")
    expect(rendered_content).to include("disabled:cursor-not-allowed")
    expect(rendered_content).to include("disabled:opacity-50")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(
      id: "icon-button",
      data: { tooltip: "Add item" },
      class: "custom-class"
    )) { icon_svg.html_safe }

    expect(rendered_content).to include('id="icon-button"')
    expect(rendered_content).to include('data-tooltip="Add item"')
    expect(rendered_content).to include("custom-class")
  end

  it "includes base classes for all buttons" do
    render_inline(described_class.new) { icon_svg.html_safe }

    expect(rendered_content).to include("flex")
    expect(rendered_content).to include("items-center")
    expect(rendered_content).to include("justify-center")
    expect(rendered_content).to include("rounded-lg")
    expect(rendered_content).to include("shadow-sm")
  end

  it "renders with nil variant (no variant classes)" do
    render_inline(described_class.new(variant: nil, class: "bg-purple-500")) do
      '<svg class="size-4"><path/></svg>'.html_safe
    end

    expect(rendered_content).to include("bg-purple-500")
    expect(rendered_content).not_to include("bg-neutral-800")
    expect(rendered_content).not_to include("bg-blue-600")
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
