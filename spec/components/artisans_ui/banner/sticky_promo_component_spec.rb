# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Banner::StickyPromoComponent, type: :component do
  it "renders a sticky promotional banner with title" do
    render_inline(described_class.new(
      title: "🎉 Special Offer",
      cookie_name: "promo_banner"
    ))

    expect(rendered_content).to include("🎉 Special Offer")
    expect(rendered_content).to include("fixed bottom-4")
    expect(rendered_content).to include("data-controller=\"artisans-ui--banner\"")
  end

  it "renders with description when provided" do
    render_inline(described_class.new(
      title: "Special Offer",
      description: "Get 20% off your first order!",
      cookie_name: "promo_banner"
    ))

    expect(rendered_content).to include("Special Offer")
    expect(rendered_content).to include("Get 20% off your first order!")
  end

  it "renders CTA button when button_text and button_url provided" do
    render_inline(described_class.new(
      title: "Offer",
      button_text: "Claim Offer",
      button_url: "/signup",
      cookie_name: "promo_banner"
    ))

    expect(rendered_content).to include("Claim Offer")
    expect(rendered_content).to include('href="/signup"')
  end

  it "sets session cookie by default (cookieDays: 0)" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "promo_banner"
    ))

    expect(rendered_content).to include('data-artisans-ui--banner-cookie-days-value="0"')
  end

  it "sets custom cookie name" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "custom_promo"
    ))

    expect(rendered_content).to include('data-artisans-ui--banner-cookie-name-value="custom_promo"')
  end

  it "includes close button with action in top-right corner" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "promo_banner"
    ))

    expect(rendered_content).to include("click-&gt;artisans-ui--banner#hide")
    expect(rendered_content).to include('aria-label="Close banner"')
    expect(rendered_content).to include("absolute right-2 top-2")
  end

  it "uses centered positioning at bottom" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "promo_banner"
    ))

    expect(rendered_content).to include("fixed bottom-4")
    expect(rendered_content).to include("left-1/2 -translate-x-1/2")
  end

  it "has max-width constraint" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "promo_banner"
    ))

    expect(rendered_content).to include("max-w-md")
  end

  it "includes rounded corners and shadow" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "promo_banner"
    ))

    expect(rendered_content).to include("rounded-xl")
    expect(rendered_content).to include("shadow-2xl")
  end

  it "supports dark mode classes" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "promo_banner"
    ))

    expect(rendered_content).to include("dark:bg-neutral-900")
    expect(rendered_content).to include("dark:text-white")
  end

  it "includes animation classes" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "promo_banner"
    ))

    expect(rendered_content).to include("transition-all")
    expect(rendered_content).to include("opacity-0")
    expect(rendered_content).to include("translate-y-full")
  end

  it "includes Stimulus controller data attributes" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "promo_banner"
    ))

    expect(rendered_content).to include('data-controller="artisans-ui--banner"')
    expect(rendered_content).to include('data-artisans-ui--banner-cookie-name-value')
    expect(rendered_content).to include('data-artisans-ui--banner-cookie-days-value')
  end

  it "content has right padding to avoid close button overlap" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "promo_banner"
    ))

    expect(rendered_content).to include("pr-6")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "promo_banner",
      id: "custom-promo",
      data: { test: "value" }
    ))

    expect(rendered_content).to include('id="custom-promo"')
    expect(rendered_content).to include('data-test="value"')
  end
end
