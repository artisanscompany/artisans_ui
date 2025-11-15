# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Badge::NotificationComponent, type: :component do
  it "renders a notification badge with count" do
    render_inline(described_class.new(count: 3))

    expect(rendered_content).to include("3")
    expect(rendered_content).to include("inline-flex")
    expect(rendered_content).to include("items-center")
    expect(rendered_content).to include("justify-center")
    expect(rendered_content).to include("rounded-full")
    expect(rendered_content).to include("bg-red-500")
    expect(rendered_content).to include("text-white")
  end

  it "renders a high count notification badge" do
    render_inline(described_class.new(count: 99))

    expect(rendered_content).to include("99")
  end

  it "displays max+ when count exceeds max value" do
    render_inline(described_class.new(count: 150, max: 99))

    expect(rendered_content).to include("99+")
  end

  it "displays exact count when below max value" do
    render_inline(described_class.new(count: 50, max: 99))

    expect(rendered_content).to include("50")
  end

  it "renders primary variant" do
    render_inline(described_class.new(count: 5, variant: :primary))

    expect(rendered_content).to include("5")
    expect(rendered_content).to include("bg-blue-500")
    expect(rendered_content).to include("text-white")
  end

  it "renders success variant" do
    render_inline(described_class.new(count: 10, variant: :success))

    expect(rendered_content).to include("10")
    expect(rendered_content).to include("bg-green-500")
    expect(rendered_content).to include("text-white")
  end

  it "renders warning variant" do
    render_inline(described_class.new(count: 7, variant: :warning))

    expect(rendered_content).to include("7")
    expect(rendered_content).to include("bg-yellow-500")
    expect(rendered_content).to include("text-white")
  end

  it "renders neutral variant" do
    render_inline(described_class.new(count: 2, variant: :neutral))

    expect(rendered_content).to include("2")
    expect(rendered_content).to include("bg-neutral-500")
    expect(rendered_content).to include("text-white")
  end

  it "hides badge when count is zero and show_zero is false" do
    render_inline(described_class.new(count: 0, show_zero: false))

    expect(rendered_content).to be_empty
  end

  it "shows badge when count is zero and show_zero is true" do
    render_inline(described_class.new(count: 0, show_zero: true))

    expect(rendered_content).to include("0")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(
      count: 5,
      id: "custom-notification",
      data: { test: "value" }
    ))

    expect(rendered_content).to include("5")
    expect(rendered_content).to include('id="custom-notification"')
    expect(rendered_content).to include('data-test="value"')
  end

  it "raises an error for invalid variant" do
    expect {
      described_class.new(count: 1, variant: :invalid)
    }.to raise_error(ArgumentError, "Invalid variant: invalid")
  end

  it "handles string count values" do
    render_inline(described_class.new(count: "42"))

    expect(rendered_content).to include("42")
  end

  it "has minimum width for single digit counts" do
    render_inline(described_class.new(count: 1))

    expect(rendered_content).to include("1")
    expect(rendered_content).to include("min-w-[1.25rem]")
  end
end
