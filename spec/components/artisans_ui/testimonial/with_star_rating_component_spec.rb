# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Testimonial::WithStarRatingComponent, type: :component do
  it "renders testimonial with 5-star rating" do
    render_inline(described_class.new(
      quote: "Outstanding quality and service!",
      author_name: "Michael Rodriguez",
      author_title: "Verified Customer",
      author_image: "https://example.com/avatar.jpg",
      rating: 5
    ))

    expect(page).to have_text("Outstanding quality and service!")
    expect(page).to have_text("Michael Rodriguez")
    expect(page).to have_css("svg.text-yellow-400", count: 5)
  end

  it "renders testimonial with 4.5-star rating" do
    render_inline(described_class.new(
      quote: "Great product!",
      author_name: "Jane Doe",
      author_title: "Customer",
      author_image: "https://example.com/avatar.jpg",
      rating: 4.5
    ))

    expect(page).to have_css("svg.text-yellow-400", count: 4)
    expect(page).to have_css("defs linearGradient#half-fill")
  end
end
