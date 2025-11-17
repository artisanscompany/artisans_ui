# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::List::WithIconComponent, type: :component do
  it "renders list item with document icon" do
    render_inline(described_class.new(title: "My Resume.pdf", icon: :document))

    expect(page).to have_css(".flex.items-center.gap-3")
    expect(page).to have_text("My Resume.pdf")
    expect(page).to have_css("svg")
  end

  it "renders with url as link" do
    render_inline(described_class.new(title: "Resume", icon: :document, url: "/resumes/1"))

    expect(page).to have_link(href: "/resumes/1")
  end

  it "renders with folder icon" do
    render_inline(described_class.new(title: "Projects", icon: :folder))

    expect(page).to have_css(".bg-yellow-100")
    expect(page).to have_text("Projects")
  end

  it "renders with mail icon" do
    render_inline(described_class.new(title: "Cover Letter", icon: :mail))

    expect(page).to have_text("Cover Letter")
  end

  it "renders with briefcase icon" do
    render_inline(described_class.new(title: "Portfolio", icon: :briefcase))

    expect(page).to have_text("Portfolio")
  end

  it "renders with content block" do
    render_inline(described_class.new(title: "Document", icon: :document)) do
      "<span>Extra content</span>".html_safe
    end

    expect(page).to have_text("Document")
    expect(page).to have_text("Extra content")
  end

  it "raises error for invalid icon" do
    expect {
      described_class.new(title: "Test", icon: :invalid)
    }.to raise_error(ArgumentError, /Invalid icon/)
  end

  it "applies dark mode classes" do
    render_inline(described_class.new(title: "Test", icon: :document))

    expect(page).to have_css(".dark\\:bg-neutral-800")
    expect(page).to have_css(".dark\\:text-white")
  end
end
