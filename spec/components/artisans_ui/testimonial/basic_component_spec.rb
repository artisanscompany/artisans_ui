# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Testimonial::BasicComponent, type: :component do
  it "renders testimonial with quote and author" do
    render_inline(described_class.new(
      quote: "This product has completely transformed our workflow.",
      author_name: "Sarah Johnson",
      author_title: "Product Manager at TechCorp"
    ))

    expect(page).to have_text("This product has completely transformed our workflow.")
    expect(page).to have_text("Sarah Johnson")
    expect(page).to have_text("Product Manager at TechCorp")
  end

  it "renders with author image when provided" do
    render_inline(described_class.new(
      quote: "Amazing product!",
      author_name: "John Doe",
      author_title: "CEO",
      author_image: "https://example.com/avatar.jpg"
    ))

    expect(page).to have_css("img[src='https://example.com/avatar.jpg']")
  end
end
