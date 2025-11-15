# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Testimonial::WithBackgroundImageComponent, type: :component do
  it "renders hero-style testimonial with background image" do
    render_inline(described_class.new(
      quote: "I'm absolutely floored by the level of care and attention.",
      author_name: "John Doe",
      author_title: "Director of Engineering, InnovateLabs",
      author_image: "https://example.com/john.jpg",
      background_image: "https://example.com/background.jpg"
    ))

    expect(page).to have_text("I'm absolutely floored by the level of care and attention.")
    expect(page).to have_text("John Doe")
    expect(page).to have_text("Director of Engineering, InnovateLabs")
    expect(page).to have_css("img[src='https://example.com/background.jpg']")
    expect(page).to have_css("img[alt='John Doe']")
  end
end
