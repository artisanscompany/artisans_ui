# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Marquee::SlowOnHoverComponent, type: :component do
  it "renders with marquee controller" do
    render_inline(described_class.new) { "Content" }
    expect(rendered_content).to include('data-controller="marquee"')
  end

  it "renders with default speed" do
    render_inline(described_class.new) { "Content" }
    expect(rendered_content).to include('data-marquee-speed-value="15"')
  end

  it "renders with custom speed" do
    render_inline(described_class.new(speed: 20)) { "Content" }
    expect(rendered_content).to include('data-marquee-speed-value="20"')
  end

  it "renders with default hover speed (slow down, not pause)" do
    render_inline(described_class.new) { "Content" }
    expect(rendered_content).to include('data-marquee-hover-speed-value="40"')
  end

  it "renders with custom hover speed" do
    render_inline(described_class.new(hover_speed: 50)) { "Content" }
    expect(rendered_content).to include('data-marquee-hover-speed-value="50"')
  end

  it "renders with default direction" do
    render_inline(described_class.new) { "Content" }
    expect(rendered_content).to include('data-marquee-direction-value="left"')
  end

  it "renders with custom direction" do
    render_inline(described_class.new(direction: "right")) { "Content" }
    expect(rendered_content).to include('data-marquee-direction-value="right"')
  end

  it "includes pause/resume actions (for slowing down)" do
    render_inline(described_class.new) { "Content" }
    expect(rendered_content).to include("mouseenter")
    expect(rendered_content).to include("mouseleave")
    expect(rendered_content).to include("marquee#pauseAnimation")
    expect(rendered_content).to include("marquee#resumeAnimation")
  end

  it "renders track target" do
    render_inline(described_class.new) { "Content" }
    expect(rendered_content).to include('data-marquee-target="track"')
  end

  it "renders list target" do
    render_inline(described_class.new) { "Content" }
    expect(rendered_content).to include('data-marquee-target="list"')
  end

  it "renders content" do
    render_inline(described_class.new) { "Test Content" }
    expect(rendered_content).to include("Test Content")
  end

  it "has gradient overlays" do
    render_inline(described_class.new) { "Content" }
    expect(rendered_content).to include("bg-gradient-to-r")
    expect(rendered_content).to include("bg-gradient-to-l")
  end

  it "has dark mode gradient classes" do
    render_inline(described_class.new) { "Content" }
    expect(rendered_content).to include("dark:from-[#080808]")
  end

  it "has overflow hidden" do
    render_inline(described_class.new) { "Content" }
    expect(rendered_content).to include("overflow-hidden")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(class: "custom-class")) { "Content" }
    expect(rendered_content).to include("custom-class")
  end

  it "has proper flex layout classes" do
    render_inline(described_class.new) { "Content" }
    expect(rendered_content).to include("flex")
    expect(rendered_content).to include("shrink-0")
    expect(rendered_content).to include("flex-nowrap")
  end
end
