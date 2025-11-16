# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Badge::RoundedPillComponent, type: :component do
  it "renders a basic neutral pill badge" do
    render_inline(described_class.new(text: "Pill"))

    expect(rendered_content).to include("Pill")
    expect(rendered_content).to include("inline-flex")
    expect(rendered_content).to include("items-center")
    expect(rendered_content).to include("rounded-full")
    expect(rendered_content).to include("bg-neutral-100")
    expect(rendered_content).to include("text-neutral-700")
  end

  it "renders a success pill badge" do
    render_inline(described_class.new(text: "Active", variant: :success))

    expect(rendered_content).to include("Active")
    expect(rendered_content).to include("rounded-full")
    expect(rendered_content).to include("bg-green-100")
    expect(rendered_content).to include("text-green-700")
  end

  it "renders a primary pill badge" do
    render_inline(described_class.new(text: "New", variant: :primary))

    expect(rendered_content).to include("New")
    expect(rendered_content).to include("rounded-full")
    expect(rendered_content).to include("bg-blue-100")
    expect(rendered_content).to include("text-blue-700")
  end

  it "renders an error pill badge" do
    render_inline(described_class.new(text: "Error", variant: :error))

    expect(rendered_content).to include("Error")
    expect(rendered_content).to include("rounded-full")
    expect(rendered_content).to include("bg-red-100")
    expect(rendered_content).to include("text-red-700")
  end

  it "renders a warning pill badge" do
    render_inline(described_class.new(text: "Warning", variant: :warning))

    expect(rendered_content).to include("Warning")
    expect(rendered_content).to include("rounded-full")
    expect(rendered_content).to include("bg-yellow-100")
    expect(rendered_content).to include("text-yellow-700")
  end

  it "renders an info pill badge" do
    render_inline(described_class.new(text: "Info", variant: :info))

    expect(rendered_content).to include("Info")
    expect(rendered_content).to include("rounded-full")
    expect(rendered_content).to include("bg-cyan-100")
    expect(rendered_content).to include("text-cyan-700")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(
      text: "Custom",
      id: "custom-pill",
      data: { test: "value" }
    ))

    expect(rendered_content).to include("Custom")
    expect(rendered_content).to include('id="custom-pill"')
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
  end

  it "renders a sky pill badge" do
    render_inline(described_class.new(text: "Office", variant: :sky))

    expect(rendered_content).to include("Office")
    expect(rendered_content).to include("rounded-full")
    expect(rendered_content).to include("bg-sky-100")
    expect(rendered_content).to include("text-sky-800")
  end

  it "renders a violet pill badge" do
    render_inline(described_class.new(text: "Flexible", variant: :violet))

    expect(rendered_content).to include("Flexible")
    expect(rendered_content).to include("rounded-full")
    expect(rendered_content).to include("bg-violet-100")
    expect(rendered_content).to include("text-violet-800")
  end

  it "renders an orange pill badge" do
    render_inline(described_class.new(text: "7 days left", variant: :orange))

    expect(rendered_content).to include("7 days left")
    expect(rendered_content).to include("rounded-full")
    expect(rendered_content).to include("bg-orange-100")
    expect(rendered_content).to include("text-orange-700")
  end
end
