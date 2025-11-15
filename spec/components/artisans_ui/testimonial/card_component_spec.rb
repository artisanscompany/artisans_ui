# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Testimonial::CardComponent, type: :component do
  it "renders testimonial card with avatar first" do
    render_inline(described_class.new(
      quote: "The attention to detail in this product is remarkable.",
      author_name: "Emily Chen",
      author_title: "Senior Designer at CreativeCo",
      author_image: "https://example.com/avatar.jpg"
    ))

    expect(page).to have_text("The attention to detail in this product is remarkable.")
    expect(page).to have_text("Emily Chen")
    expect(page).to have_text("Senior Designer at CreativeCo")
    expect(page).to have_css("img[src='https://example.com/avatar.jpg']")
  end
end
