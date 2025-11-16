# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Typography::HeroComponent, type: :component do
  it "renders heading and subheading" do
    render_inline(described_class.new(
      heading: "Main Title",
      subheading: "Description text"
    ))

    expect(rendered_content).to include("<h1")
    expect(rendered_content).to include("Main Title")
    expect(rendered_content).to include("<p")
    expect(rendered_content).to include("Description text")
  end

  it "uses specified heading level" do
    render_inline(described_class.new(
      heading: "Title",
      subheading: "Subtitle",
      heading_level: :h2
    ))

    expect(rendered_content).to include("<h2")
    expect(rendered_content).to include("Title")
  end

  it "applies heading variant" do
    render_inline(described_class.new(
      heading: "Display",
      subheading: "Sub",
      heading_variant: :display
    ))

    expect(rendered_content).to include("text-4xl")
  end

  it "applies subheading variant" do
    render_inline(described_class.new(
      heading: "Title",
      subheading: "Large Sub",
      subheading_variant: :large
    ))

    expect(rendered_content).to include("text-lg")
  end

  it "renders with content block" do
    render_inline(described_class.new(
      heading: "Title",
      subheading: "Subtitle"
    )) do
      "Additional content"
    end

    expect(rendered_content).to include("Additional content")
  end

  it "adds proper spacing between elements" do
    render_inline(described_class.new(
      heading: "Title",
      subheading: "Subtitle"
    ))

    expect(rendered_content).to include("mb-3")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(
      heading: "Title",
      subheading: "Subtitle",
      class: "custom-hero"
    ))

    expect(rendered_content).to include("custom-hero")
  end
end
