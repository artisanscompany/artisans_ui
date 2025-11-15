# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Badge::WithDotComponent, type: :component do
  it "renders a badge with a static dot by default" do
    render_inline(described_class.new(text: "Online"))

    expect(rendered_content).to include("Online")
    expect(rendered_content).to include("inline-flex")
    expect(rendered_content).to include("items-center")
    expect(rendered_content).to include("gap-1.5")
    expect(rendered_content).to include("rounded-md")
    expect(rendered_content).to include("size-1.5")
    expect(rendered_content).to include("rounded-full")
  end

  it "renders a success badge with green dot" do
    render_inline(described_class.new(text: "Online", variant: :success))

    expect(rendered_content).to include("Online")
    expect(rendered_content).to include("bg-green-100")
    expect(rendered_content).to include("text-green-700")
    expect(rendered_content).to include("bg-green-500")
  end

  it "renders an error badge with red dot" do
    render_inline(described_class.new(text: "Offline", variant: :error))

    expect(rendered_content).to include("Offline")
    expect(rendered_content).to include("bg-red-100")
    expect(rendered_content).to include("text-red-700")
    expect(rendered_content).to include("bg-red-500")
  end

  it "renders a warning badge with yellow dot" do
    render_inline(described_class.new(text: "Busy", variant: :warning))

    expect(rendered_content).to include("Busy")
    expect(rendered_content).to include("bg-yellow-100")
    expect(rendered_content).to include("text-yellow-700")
    expect(rendered_content).to include("bg-yellow-500")
  end

  it "renders a badge with pulsing dot when pulse is true" do
    render_inline(described_class.new(text: "Live", variant: :error, pulse: true))

    expect(rendered_content).to include("Live")
    expect(rendered_content).to include("animate-ping")
  end

  it "renders a badge without pulsing dot when pulse is false" do
    render_inline(described_class.new(text: "Online", variant: :success, pulse: false))

    expect(rendered_content).not_to include("animate-ping")
    expect(rendered_content).to include("size-1.5")
    expect(rendered_content).to include("rounded-full")
  end

  it "renders a primary badge with blue dot" do
    render_inline(described_class.new(text: "Active", variant: :primary))

    expect(rendered_content).to include("Active")
    expect(rendered_content).to include("bg-blue-100")
    expect(rendered_content).to include("text-blue-700")
    expect(rendered_content).to include("bg-blue-500")
  end

  it "renders an info badge with cyan dot" do
    render_inline(described_class.new(text: "Info", variant: :info))

    expect(rendered_content).to include("Info")
    expect(rendered_content).to include("bg-cyan-100")
    expect(rendered_content).to include("text-cyan-700")
    expect(rendered_content).to include("bg-cyan-500")
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

  it "supports dark mode classes" do
    render_inline(described_class.new(text: "Dark Mode", variant: :neutral))

    expect(rendered_content).to include("dark:bg-neutral-700")
    expect(rendered_content).to include("dark:text-neutral-300")
    expect(rendered_content).to include("dark:bg-neutral-400")
  end
end
