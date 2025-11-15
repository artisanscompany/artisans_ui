# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Carousel::VariableWidthsComponent, type: :component do
  let(:slides) do
    [
      { image_url: "https://placehold.co/400x600/blue/white?text=Slide+1", alt: "Slide 1", width: "basis-1/3" },
      { image_url: "https://placehold.co/600x600/red/white?text=Slide+2", alt: "Slide 2", width: "basis-1/2" },
      { image_url: "https://placehold.co/500x600/green/white?text=Slide+3", alt: "Slide 3", width: "basis-2/5" }
    ]
  end

  it "renders the carousel container" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include("mx-auto max-w-screen-md")
  end

  it "includes carousel controller data attributes with loop, drag-free, and wheel-gestures enabled" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include('data-controller="artisans-ui--carousel"')
    expect(rendered_content).to include('data-artisans-ui--carousel-loop-value="true"')
    expect(rendered_content).to include('data-artisans-ui--carousel-drag-free-value="true"')
    expect(rendered_content).to include('data-artisans-ui--carousel-wheel-gestures-value="true"')
    expect(rendered_content).to include('data-artisans-ui--carousel-dots-value="false"')
    expect(rendered_content).to include('data-artisans-ui--carousel-buttons-value="true"')
  end

  it "renders the viewport and container" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include('data-artisans-ui--carousel-target="viewport"')
    expect(rendered_content).to include('data-artisans-ui--carousel-target="container"')
  end

  it "renders all slides with variable widths" do
    render_inline(described_class.new(slides: slides))

    slides.each do |slide|
      expect(rendered_content).to include(slide[:image_url])
      expect(rendered_content).to include(slide[:alt])
    end
  end

  it "applies width classes to slides" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include("basis-1/3")
    expect(rendered_content).to include("basis-1/2")
    expect(rendered_content).to include("basis-2/5")
  end

  it "renders navigation buttons" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include('data-artisans-ui--carousel-target="prevButton"')
    expect(rendered_content).to include('data-artisans-ui--carousel-target="nextButton"')
  end

  it "includes button click actions" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include('data-action=')
    expect(rendered_content).to include("artisans-ui--carousel#scrollPrev")
    expect(rendered_content).to include("artisans-ui--carousel#scrollNext")
  end

  it "does not render dots container" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).not_to include('data-artisans-ui--carousel-target="dotsContainer"')
  end

  it "applies correct styling classes" do
    render_inline(described_class.new(slides: slides))

    expect(rendered_content).to include("relative overflow-hidden rounded-3xl")
    expect(rendered_content).to include("flex touch-pan-y touch-pinch-zoom")
  end

  it "accepts custom html_options" do
    render_inline(described_class.new(slides: slides, id: "variable-widths-carousel", data: { test: "value" }))

    expect(rendered_content).to include('id="variable-widths-carousel"')
    expect(rendered_content).to include('data-test="value"')
  end
end
