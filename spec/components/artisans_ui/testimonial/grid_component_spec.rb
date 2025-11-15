# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Testimonial::GridComponent, type: :component do
  it "renders multiple testimonials in grid layout" do
    render_inline(described_class.new) do |component|
      component.with_testimonial(
        quote: "Game-changing tool!",
        author_name: "Alex Thompson",
        author_title: "CEO, StartupXYZ",
        author_image: "https://example.com/alex.jpg"
      )
      component.with_testimonial(
        quote: "Incredible support!",
        author_name: "Lisa Wang",
        author_title: "Marketing Director",
        author_image: "https://example.com/lisa.jpg"
      )
    end

    expect(page).to have_text("Game-changing tool!")
    expect(page).to have_text("Alex Thompson")
    expect(page).to have_text("Incredible support!")
    expect(page).to have_text("Lisa Wang")
    expect(page).to have_css("img[alt='Alex Thompson']")
    expect(page).to have_css("img[alt='Lisa Wang']")
  end
end
