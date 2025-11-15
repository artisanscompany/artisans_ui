# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Marquee::MultiRowComponent, type: :component do
  let(:rows_data) do
    [
      {
        direction: "left",
        content: [
          { name: "Brand 1", icon: "<svg></svg>" },
          { name: "Brand 2", icon: "<svg></svg>" }
        ]
      },
      {
        direction: "right",
        content: [
          { name: "Brand 3", icon: "<svg></svg>" },
          { name: "Brand 4", icon: "<svg></svg>" }
        ]
      }
    ]
  end

  it "renders with title" do
    render_inline(described_class.new(title: "Trusted by leading brands", rows: []))
    expect(rendered_content).to include("Trusted by leading brands")
  end

  it "renders with subtitle" do
    render_inline(described_class.new(
      title: "Title",
      subtitle: "Subtitle text",
      rows: []
    ))
    expect(rendered_content).to include("Subtitle text")
  end

  it "renders multiple rows" do
    render_inline(described_class.new(title: "Title", rows: rows_data))
    expect(rendered_content).to include('data-controller="marquee"')
    # Should have 2 marquee controllers (one per row)
    expect(rendered_content.scan(/data-controller="marquee"/).count).to eq(2)
  end

  it "renders rows with correct directions" do
    render_inline(described_class.new(title: "Title", rows: rows_data))
    expect(rendered_content).to include('data-marquee-direction-value="left"')
    expect(rendered_content).to include('data-marquee-direction-value="right"')
  end

  it "renders brand cards" do
    render_inline(described_class.new(title: "Title", rows: rows_data))
    expect(rendered_content).to include("Brand 1")
    expect(rendered_content).to include("Brand 2")
    expect(rendered_content).to include("Brand 3")
    expect(rendered_content).to include("Brand 4")
  end

  it "renders brand card styling" do
    render_inline(described_class.new(title: "Title", rows: rows_data))
    expect(rendered_content).to include("rounded-xl")
    expect(rendered_content).to include("border-black/5")
    expect(rendered_content).to include("bg-neutral-50")
  end

  it "has dark mode classes for brand cards" do
    render_inline(described_class.new(title: "Title", rows: rows_data))
    expect(rendered_content).to include("dark:border-white/10")
    expect(rendered_content).to include("dark:bg-neutral-800")
  end

  it "renders with default speed" do
    render_inline(described_class.new(title: "Title", rows: rows_data))
    expect(rendered_content).to include('data-marquee-speed-value="30"')
  end

  it "renders with custom speed" do
    render_inline(described_class.new(title: "Title", rows: rows_data, speed: 25))
    expect(rendered_content).to include('data-marquee-speed-value="25"')
  end

  it "renders with hover speed" do
    render_inline(described_class.new(title: "Title", rows: rows_data, hover_speed: 0))
    expect(rendered_content).to include('data-marquee-hover-speed-value="0"')
  end

  it "has gradient overlays" do
    render_inline(described_class.new(title: "Title", rows: rows_data))
    expect(rendered_content).to include("bg-gradient-to-r")
    expect(rendered_content).to include("bg-gradient-to-l")
  end

  it "has pause/resume actions on rows" do
    render_inline(described_class.new(title: "Title", rows: rows_data))
    expect(rendered_content).to include("mouseenter")
    expect(rendered_content).to include("mouseleave")
    expect(rendered_content).to include("marquee#pauseAnimation")
    expect(rendered_content).to include("marquee#resumeAnimation")
  end

  it "has header section styling" do
    render_inline(described_class.new(title: "Title", subtitle: "Subtitle", rows: []))
    expect(rendered_content).to include("text-center")
    expect(rendered_content).to include("max-w-2xl")
  end

  it "has container padding" do
    render_inline(described_class.new(title: "Title", rows: []))
    expect(rendered_content).to include("py-16")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(title: "Title", rows: [], class: "custom-class"))
    expect(rendered_content).to include("custom-class")
  end
end
