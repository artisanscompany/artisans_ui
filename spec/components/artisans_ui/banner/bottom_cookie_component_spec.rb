# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Banner::BottomCookieComponent, type: :component do
  it "renders a bottom cookie consent banner with title" do
    render_inline(described_class.new(
      title: "We use cookies",
      cookie_name: "cookie_consent"
    ))

    expect(rendered_content).to include("We use cookies")
    expect(rendered_content).to include("fixed bottom-0")
    expect(rendered_content).to include("data-controller=\"artisans-ui--banner\"")
  end

  it "renders with description when provided" do
    render_inline(described_class.new(
      title: "We use cookies",
      description: "We use cookies to ensure you get the best experience.",
      cookie_name: "cookie_consent"
    ))

    expect(rendered_content).to include("We use cookies")
    expect(rendered_content).to include("We use cookies to ensure you get the best experience.")
  end

  it "renders accept and decline buttons with default text" do
    render_inline(described_class.new(
      title: "We use cookies",
      cookie_name: "cookie_consent"
    ))

    expect(rendered_content).to include("Accept")
    expect(rendered_content).to include("Decline")
  end

  it "renders custom button text when provided" do
    render_inline(described_class.new(
      title: "Cookies",
      accept_text: "I Agree",
      decline_text: "No Thanks",
      cookie_name: "cookie_consent"
    ))

    expect(rendered_content).to include("I Agree")
    expect(rendered_content).to include("No Thanks")
  end

  it "sets cookie configuration with custom cookie_days" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "custom_consent",
      cookie_days: 90
    ))

    expect(rendered_content).to include('data-artisans-ui--banner-cookie-name-value="custom_consent"')
    expect(rendered_content).to include('data-artisans-ui--banner-cookie-days-value="90"')
  end

  it "defaults to 30 days cookie persistence" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "test_consent"
    ))

    expect(rendered_content).to include('data-artisans-ui--banner-cookie-days-value="30"')
  end

  it "includes Stimulus controller data attributes" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "test_consent"
    ))

    expect(rendered_content).to include('data-controller="artisans-ui--banner"')
    expect(rendered_content).to include('data-artisans-ui--banner-cookie-name-value')
    expect(rendered_content).to include('data-artisans-ui--banner-cookie-days-value')
  end

  it "both buttons trigger hide action" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "test_consent"
    ))

    expect(rendered_content.scan(/click-&gt;artisans-ui--banner#hide/).count).to be >= 2
  end

  it "supports dark mode classes" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "test_consent"
    ))

    expect(rendered_content).to include("dark:bg-neutral-900")
    expect(rendered_content).to include("dark:text-white")
  end

  it "includes animation classes" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "test_consent"
    ))

    expect(rendered_content).to include("transition-all")
    expect(rendered_content).to include("opacity-0")
    expect(rendered_content).to include("translate-y-full")
  end

  it "uses responsive layout classes" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "test_consent"
    ))

    expect(rendered_content).to include("flex-col sm:flex-row")
    expect(rendered_content).to include("items-start sm:items-center")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "test_consent",
      id: "custom-cookie-banner",
      data: { test: "value" }
    ))

    expect(rendered_content).to include('id="custom-cookie-banner"')
    expect(rendered_content).to include('data-test="value"')
  end
end
