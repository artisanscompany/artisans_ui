# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Banner::TopAnnouncementComponent, type: :component do
  it "renders a top announcement banner with title" do
    render_inline(described_class.new(
      title: "New Feature Launch!",
      cookie_name: "test_announcement"
    ))

    expect(rendered_content).to include("New Feature Launch!")
    expect(rendered_content).to include("fixed top-0")
    expect(rendered_content).to include("data-controller=\"artisans-ui--banner\"")
  end

  it "renders with description when provided" do
    render_inline(described_class.new(
      title: "Announcement",
      description: "Check out our latest features",
      cookie_name: "test_announcement"
    ))

    expect(rendered_content).to include("Announcement")
    expect(rendered_content).to include("Check out our latest features")
  end

  it "renders with button when button_text and button_url provided" do
    render_inline(described_class.new(
      title: "Announcement",
      button_text: "Learn more",
      button_url: "/features",
      cookie_name: "test_announcement"
    ))

    expect(rendered_content).to include("Learn more")
    expect(rendered_content).to include('href="/features"')
  end

  it "sets cookie configuration with cookieDays: -1 for no persistence" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "custom_banner"
    ))

    expect(rendered_content).to include('data-artisans-ui--banner-cookie-name-value="custom_banner"')
    expect(rendered_content).to include('data-artisans-ui--banner-cookie-days-value="-1"')
  end

  it "includes Stimulus controller data attributes" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "test_banner"
    ))

    expect(rendered_content).to include('data-controller="artisans-ui--banner"')
    expect(rendered_content).to include('data-artisans-ui--banner-cookie-name-value')
    expect(rendered_content).to include('data-artisans-ui--banner-cookie-days-value')
  end

  it "includes close button with action" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "test_banner"
    ))

    expect(rendered_content).to include("click-&gt;artisans-ui--banner#hide")
    expect(rendered_content).to include('aria-label="Close banner"')
  end

  it "supports dark mode classes" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "test_banner"
    ))

    expect(rendered_content).to include("dark:bg-neutral-900")
    expect(rendered_content).to include("dark:text-white")
  end

  it "includes animation classes" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "test_banner"
    ))

    expect(rendered_content).to include("transition-all")
    expect(rendered_content).to include("opacity-0")
    expect(rendered_content).to include("-translate-y-full")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(
      title: "Test",
      cookie_name: "test_banner",
      id: "custom-banner",
      data: { test: "value" }
    ))

    expect(rendered_content).to include('id="custom-banner"')
    expect(rendered_content).to include('data-test="value"')
  end
end
