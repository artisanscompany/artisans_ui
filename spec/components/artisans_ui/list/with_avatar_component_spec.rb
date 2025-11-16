# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::List::WithAvatarComponent, type: :component do
  let(:title) { "Senior Developer" }

  describe "rendering" do
    it "renders with minimal params" do
      render_inline(described_class.new(title: title))

      expect(page).to have_css("h3", text: title)
      expect(page).to have_css(".border-b")
    end

    it "renders with avatar URL" do
      render_inline(described_class.new(
        title: title,
        avatar_url: "https://example.com/logo.png",
        avatar_alt: "Company Logo"
      ))

      expect(page).to have_css("img[src='https://example.com/logo.png'][alt='Company Logo']")
    end

    it "renders with avatar fallback" do
      render_inline(described_class.new(
        title: title,
        avatar_fallback: "A",
        avatar_alt: "Acme Corp"
      ))

      expect(page).to have_css(".bg-neutral-100", text: "A")
    end

    it "renders with subtitle" do
      render_inline(described_class.new(
        title: title,
        subtitle: "Acme Corp"
      ))

      expect(page).to have_css("span", text: "Acme Corp")
    end

    it "renders as link when url provided" do
      render_inline(described_class.new(
        title: title,
        url: "/jobs/123"
      ))

      expect(page).to have_css("a.group[href='/jobs/123']")
    end

    it "renders content block" do
      render_inline(described_class.new(title: title)) do
        "<span class='location'>San Francisco</span>".html_safe
      end

      expect(page).to have_css(".location", text: "San Francisco")
    end

    it "renders corner badge when show_badge is true" do
      render_inline(described_class.new(
        title: title,
        show_badge: true,
        badge_text: "NEW"
      ))

      expect(page).to have_css(".bg-yellow-500", text: "NEW")
    end
  end

  describe "variants" do
    it "renders default variant" do
      render_inline(described_class.new(title: title, variant: :default))

      expect(page).to have_css(".bg-white.border-neutral-200")
    end

    it "renders highlighted variant" do
      render_inline(described_class.new(title: title, variant: :highlighted))

      expect(page).to have_css(".bg-gradient-to-br.from-yellow-50")
    end

    it "raises error for invalid variant" do
      expect {
        described_class.new(title: title, variant: :invalid)
      }.to raise_error(ArgumentError, /Invalid variant/)
    end
  end

  describe "layout" do
    it "uses horizontal flex layout" do
      render_inline(described_class.new(title: title))

      expect(page).to have_css(".flex.items-center")
    end

    it "includes hover state" do
      render_inline(described_class.new(title: title))

      expect(page).to have_css(".hover\\:bg-neutral-50")
    end

    it "uses border-b for row separator" do
      render_inline(described_class.new(title: title))

      expect(page).to have_css(".border-b")
    end
  end
end
