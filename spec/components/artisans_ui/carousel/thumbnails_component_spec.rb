# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Carousel::ThumbnailsComponent, type: :component do
  let(:slides) do
    [
      { image_url: "https://placehold.co/800x600/blue/white?text=Slide+1", alt: "Slide 1" },
      { image_url: "https://placehold.co/800x600/red/white?text=Slide+2", alt: "Slide 2" },
      { image_url: "https://placehold.co/800x600/green/white?text=Slide+3", alt: "Slide 3" }
    ]
  end

  it "renders the main container" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include("mx-auto max-w-screen-md space-y-4")
  end

  it "renders the main carousel with default id" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include('id="main-carousel"')
  end

  it "renders the thumbnail carousel with default id" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include('id="thumbnail-carousel"')
  end

  it "includes main carousel controller data attributes" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include('id="main-carousel"')
    expect(rendered_content).to include('data-controller="artisans-ui--carousel"')
    expect(rendered_content).to include('data-artisans-ui--carousel-loop-value="true"')
    expect(rendered_content).to include('data-artisans-ui--carousel-dots-value="false"')
    expect(rendered_content).to include('data-artisans-ui--carousel-buttons-value="true"')
  end

  it "includes thumbnail carousel controller with main carousel reference" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include('id="thumbnail-carousel"')
    expect(rendered_content).to include('data-artisans-ui--carousel-main-carousel-value="main-carousel"')
  end

  it "renders all main slides" do
    render_inline(described_class.new(slides: slides))

    slides.each do |slide|
      expect(rendered_content).to include(slide[:image_url])
      expect(rendered_content).to include(slide[:alt])
    end
  end

  it "renders all thumbnail buttons" do
    render_inline(described_class.new(slides: slides))

    slides.each_with_index do |slide, index|
      expect(rendered_content).to include("data-index=\"#{index}\"")
      expect(rendered_content).to include(slide[:image_url])
    end
  end

  it "renders main carousel navigation buttons" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include('data-artisans-ui--carousel-target="prevButton"')
    expect(rendered_content).to include('data-artisans-ui--carousel-target="nextButton"')
  end

  it "includes thumbnail click actions" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include('data-action=')
    expect(rendered_content).to include("artisans-ui--carousel#onThumbnailClick")
  end

  it "applies correct styling classes to main carousel" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include("relative overflow-hidden rounded-3xl")
  end

  it "applies correct styling to thumbnail buttons" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include('data-artisans-ui--carousel-target="thumbnailButton"')
  end

  it "renders with custom carousel ids" do
    render_inline(described_class.new(
      slides: slides,
      main_carousel_id: "custom-main",
      thumbnail_carousel_id: "custom-thumbnails"
    ))

    expect(rendered_content).to include('id="custom-main"')
    expect(rendered_content).to include('id="custom-thumbnails"')
  end

  it "links thumbnail carousel to custom main carousel id" do
    render_inline(described_class.new(
      slides: slides,
      main_carousel_id: "custom-main",
      thumbnail_carousel_id: "custom-thumbnails"
    ))

    expect(rendered_content).to include('data-artisans-ui--carousel-main-carousel-value="custom-main"')
  end

  it "accepts custom html_options" do
    render_inline(described_class.new(slides: slides, id: "thumbnails-wrapper", data: { test: "value" }))

    expect(rendered_content).to include('id="thumbnails-wrapper"')
    expect(rendered_content).to include('data-test="value"')
  end
end
