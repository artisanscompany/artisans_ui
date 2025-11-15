# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Banner::CountdownComponent, type: :component do
  it "renders a countdown banner with title" do
    render_inline(described_class.new(
      title: "Black Friday Sale!",
      countdown_end_time: "2025-11-28T23:59:59",
      cookie_name: "sale_banner"
    ))

    expect(rendered_content).to include("Black Friday Sale!")
    expect(rendered_content).to include("fixed top-0")
    expect(rendered_content).to include("data-controller=\"artisans-ui--banner\"")
  end

  it "renders with description when provided" do
    render_inline(described_class.new(
      title: "Sale!",
      description: "Get 50% off everything!",
      countdown_end_time: "2025-11-28T23:59:59",
      cookie_name: "sale_banner"
    ))

    expect(rendered_content).to include("Sale!")
    expect(rendered_content).to include("Get 50% off everything!")
  end

  it "renders countdown timer structure with all units" do
    render_inline(described_class.new(
      title: "Sale!",
      countdown_end_time: "2025-11-28T23:59:59",
      cookie_name: "sale_banner"
    ))

    expect(rendered_content).to include("Days")
    expect(rendered_content).to include("Hrs")
    expect(rendered_content).to include("Min")
    expect(rendered_content).to include("Sec")
    expect(rendered_content).to include('data-artisans-ui--banner-target="days"')
    expect(rendered_content).to include('data-artisans-ui--banner-target="hours"')
    expect(rendered_content).to include('data-artisans-ui--banner-target="minutes"')
    expect(rendered_content).to include('data-artisans-ui--banner-target="seconds"')
  end

  it "sets countdown end time data attribute" do
    render_inline(described_class.new(
      title: "Sale!",
      countdown_end_time: "2025-11-28T23:59:59",
      cookie_name: "sale_banner"
    ))

    expect(rendered_content).to include('data-artisans-ui--banner-countdown-end-time-value="2025-11-28T23:59:59"')
  end

  it "enables auto-hide by default" do
    render_inline(described_class.new(
      title: "Sale!",
      countdown_end_time: "2025-11-28T23:59:59",
      cookie_name: "sale_banner"
    ))

    expect(rendered_content).to include('data-artisans-ui--banner-auto-hide-value="true"')
  end

  it "can disable auto-hide" do
    render_inline(described_class.new(
      title: "Sale!",
      countdown_end_time: "2025-11-28T23:59:59",
      auto_hide: false,
      cookie_name: "sale_banner"
    ))

    expect(rendered_content).to include('data-artisans-ui--banner-auto-hide-value="false"')
  end

  it "renders CTA button when button_text and button_url provided" do
    render_inline(described_class.new(
      title: "Sale!",
      countdown_end_time: "2025-11-28T23:59:59",
      button_text: "Shop Now",
      button_url: "/shop",
      cookie_name: "sale_banner"
    ))

    expect(rendered_content).to include("Shop Now")
    expect(rendered_content).to include('href="/shop"')
  end

  it "includes close button with action" do
    render_inline(described_class.new(
      title: "Sale!",
      countdown_end_time: "2025-11-28T23:59:59",
      cookie_name: "sale_banner"
    ))

    expect(rendered_content).to include("click-&gt;artisans-ui--banner#hide")
    expect(rendered_content).to include('aria-label="Close banner"')
  end

  it "defaults to 7 days cookie persistence" do
    render_inline(described_class.new(
      title: "Sale!",
      countdown_end_time: "2025-11-28T23:59:59",
      cookie_name: "sale_banner"
    ))

    expect(rendered_content).to include('data-artisans-ui--banner-cookie-days-value="7"')
  end

  it "uses gradient background" do
    render_inline(described_class.new(
      title: "Sale!",
      countdown_end_time: "2025-11-28T23:59:59",
      cookie_name: "sale_banner"
    ))

    expect(rendered_content).to include("bg-gradient-to-r from-purple-600 to-pink-600")
  end

  it "includes animation classes" do
    render_inline(described_class.new(
      title: "Sale!",
      countdown_end_time: "2025-11-28T23:59:59",
      cookie_name: "sale_banner"
    ))

    expect(rendered_content).to include("transition-all")
    expect(rendered_content).to include("opacity-0")
    expect(rendered_content).to include("-translate-y-full")
  end

  it "uses responsive layout classes" do
    render_inline(described_class.new(
      title: "Sale!",
      countdown_end_time: "2025-11-28T23:59:59",
      cookie_name: "sale_banner"
    ))

    expect(rendered_content).to include("flex-col sm:flex-row")
    expect(rendered_content).to include("text-center sm:text-left")
  end

  it "includes Stimulus controller data attributes" do
    render_inline(described_class.new(
      title: "Sale!",
      countdown_end_time: "2025-11-28T23:59:59",
      cookie_name: "sale_banner"
    ))

    expect(rendered_content).to include('data-controller="artisans-ui--banner"')
    expect(rendered_content).to include('data-artisans-ui--banner-cookie-name-value')
    expect(rendered_content).to include('data-artisans-ui--banner-countdown-end-time-value')
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(
      title: "Sale!",
      countdown_end_time: "2025-11-28T23:59:59",
      cookie_name: "sale_banner",
      id: "custom-countdown",
      data: { test: "value" }
    ))

    expect(rendered_content).to include('id="custom-countdown"')
    expect(rendered_content).to include('data-test="value"')
  end
end
