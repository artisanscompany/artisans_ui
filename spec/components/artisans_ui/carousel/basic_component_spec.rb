# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Carousel::BasicComponent, type: :component do
  let(:slides) do
    [
      { image_url: "https://placehold.co/800x600/blue/white?text=Slide+1", alt: "Slide 1" },
      { image_url: "https://placehold.co/800x600/red/white?text=Slide+2", alt: "Slide 2" },
      { image_url: "https://placehold.co/800x600/green/white?text=Slide+3", alt: "Slide 3" }
    ]
  end

  it "renders the carousel container" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include("mx-auto max-w-screen-md")
  end

  it "includes carousel controller data attributes" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include('data-controller="artisans-ui--carousel"')
    expect(rendered_content).to include('data-artisans-ui--carousel-dots-value="true"')
    expect(rendered_content).to include('data-artisans-ui--carousel-buttons-value="true"')
  end

  it "renders the viewport and container" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include('data-artisans-ui--carousel-target="viewport"')
    expect(rendered_content).to include('data-artisans-ui--carousel-target="container"')
  end

  it "renders all slides" do
    render_inline(described_class.new(slides: slides))

    slides.each do |slide|
      expect(rendered_content).to include(slide[:image_url])
      expect(rendered_content).to include(slide[:alt])
    end
  end

  it "renders navigation buttons" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include('data-artisans-ui--carousel-target="prevButton"')
    expect(rendered_content).to include('data-artisans-ui--carousel-target="nextButton"')
  end

  it "includes button click actions" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include("data-action=")
    expect(rendered_content).to include("artisans-ui--carousel#scrollPrev")
    expect(rendered_content).to include("artisans-ui--carousel#scrollNext")
  end

  it "renders dots container" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include('data-artisans-ui--carousel-target="dotsContainer"')
  end

  it "applies correct styling classes" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include("relative overflow-hidden rounded-3xl")
    expect(rendered_content).to include("flex touch-pan-y touch-pinch-zoom")
  end

  it "accepts custom html_options" do
    render_inline(described_class.new(slides: slides, id: "custom-carousel", data: { test: "value" }))

    expect(rendered_content).to include('id="custom-carousel"')
    expect(rendered_content).to include('data-test="value"')
  end
end
