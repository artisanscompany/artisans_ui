# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Typography::HeadingComponent, type: :component do
  it "renders an h1 by default" do
    render_inline(described_class.new) { "Heading Text" }

    expect(rendered_content).to include("<h1")
    expect(rendered_content).to include("Heading Text")
  end

  it "renders specified heading level" do
    render_inline(described_class.new(level: :h3)) { "Level 3" }

    expect(rendered_content).to include("<h3")
    expect(rendered_content).to include("Level 3")
  end

  it "renders display variant" do
    render_inline(described_class.new(variant: :display)) { "Display" }

    expect(rendered_content).to include("text-4xl")
    expect(rendered_content).to include("font-bold")
    expect(rendered_content).to include("dark:text-white")
  end

  it "renders title variant" do
    render_inline(described_class.new(variant: :title)) { "Title" }

    expect(rendered_content).to include("text-2xl")
    expect(rendered_content).to include("font-semibold")
  end

  it "renders subtitle variant" do
    render_inline(described_class.new(variant: :subtitle)) { "Subtitle" }

    expect(rendered_content).to include("text-xl")
    expect(rendered_content).to include("font-medium")
  end

  it "renders section variant" do
    render_inline(described_class.new(variant: :section)) { "Section" }

    expect(rendered_content).to include("text-lg")
    expect(rendered_content).to include("font-semibold")
  end

  it "renders with nil variant (no variant classes)" do
    render_inline(described_class.new(variant: nil, class: "text-5xl custom")) { "Custom" }

    expect(rendered_content).to include("Custom")
    expect(rendered_content).to include("text-5xl")
    expect(rendered_content).to include("custom")
    expect(rendered_content).not_to include("text-2xl")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(
      level: :h2,
      id: "custom-heading",
      data: { controller: "heading" },
      class: "extra-class"
    )) { "Custom" }

    expect(rendered_content).to include('id="custom-heading"')
    expect(rendered_content).to include('data-controller="heading"')
    expect(rendered_content).to include("extra-class")
  end

  it "supports dark mode classes" do
    render_inline(described_class.new) { "Dark Mode" }

    expect(rendered_content).to include("dark:text-white")
  end

  it "raises error for invalid level" do
    expect {
      described_class.new(level: :h7)
    }.to raise_error(ArgumentError, "Invalid level: h7")
  end

  it "raises error for invalid variant" do
    expect {
      described_class.new(variant: :invalid)
    }.to raise_error(ArgumentError, "Invalid variant: invalid")
  end

  it "renders all heading levels" do
    [:h1, :h2, :h3, :h4, :h5, :h6].each do |level|
      render_inline(described_class.new(level: level)) { "Heading" }
      expect(rendered_content).to include("<#{level}")
      expect(rendered_content).to include("Heading")
    end
  end
end
