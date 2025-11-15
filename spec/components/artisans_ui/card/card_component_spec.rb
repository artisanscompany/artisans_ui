# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ArtisansUi::Card Components", type: :component do
  describe ArtisansUi::Card::BasicComponent do
    it "renders basic card structure" do
      render_inline(described_class.new) do
        "Test content"
      end

      expect(rendered_content).to include("bg-white dark:bg-neutral-800")
      expect(rendered_content).to include("rounded-xl")
      expect(rendered_content).to include("shadow-xs")
      expect(rendered_content).to include("Test content")
    end

    it "applies padding to content area" do
      render_inline(described_class.new) { "Content" }

      expect(rendered_content).to include("px-4 py-5 sm:p-6")
    end

    it "includes border styling" do
      render_inline(described_class.new) { "Content" }

      expect(rendered_content).to include("border border-black/10 dark:border-white/10")
    end

    it "supports custom HTML attributes" do
      render_inline(described_class.new(id: "custom-card")) { "Content" }

      expect(rendered_content).to include('id="custom-card"')
    end

    it "has overflow hidden" do
      render_inline(described_class.new) { "Content" }

      expect(rendered_content).to include("overflow-hidden")
    end
  end

  describe ArtisansUi::Card::WithHeaderComponent do
    it "renders header and body sections" do
      render_inline(described_class.new) do |card|
        card.with_header { "Header content" }
        card.with_body { "Body content" }
      end

      expect(rendered_content).to include("Header content")
      expect(rendered_content).to include("Body content")
    end

    it "applies divider between sections" do
      render_inline(described_class.new) do |card|
        card.with_header { "Header" }
        card.with_body { "Body" }
      end

      expect(rendered_content).to include("divide-y divide-black/10 dark:divide-white/10")
    end

    it "applies correct padding to header" do
      render_inline(described_class.new) do |card|
        card.with_header { "Header" }
      end

      expect(rendered_content).to include("px-4 py-5 sm:px-6")
    end

    it "applies correct padding to body" do
      render_inline(described_class.new) do |card|
        card.with_body { "Body" }
      end

      expect(rendered_content).to include("px-4 py-5 sm:p-6")
    end

    it "renders without body" do
      render_inline(described_class.new) do |card|
        card.with_header { "Header only" }
      end

      expect(rendered_content).to include("Header only")
    end
  end

  describe ArtisansUi::Card::WithFooterComponent do
    it "renders body and footer sections" do
      render_inline(described_class.new) do |card|
        card.with_body { "Body content" }
        card.with_footer { "Footer content" }
      end

      expect(rendered_content).to include("Body content")
      expect(rendered_content).to include("Footer content")
    end

    it "applies background to footer" do
      render_inline(described_class.new) do |card|
        card.with_footer { "Footer" }
      end

      expect(rendered_content).to include("bg-neutral-50 dark:bg-neutral-900/50")
    end

    it "applies border-top to footer" do
      render_inline(described_class.new) do |card|
        card.with_footer { "Footer" }
      end

      expect(rendered_content).to include("border-t border-black/10 dark:border-white/10")
    end

    it "renders without footer" do
      render_inline(described_class.new) do |card|
        card.with_body { "Body only" }
      end

      expect(rendered_content).to include("Body only")
    end
  end

  describe ArtisansUi::Card::CompleteComponent do
    it "renders all three sections" do
      render_inline(described_class.new) do |card|
        card.with_header { "Header" }
        card.with_body { "Body" }
        card.with_footer { "Footer" }
      end

      expect(rendered_content).to include("Header")
      expect(rendered_content).to include("Body")
      expect(rendered_content).to include("Footer")
    end

    it "applies background to header" do
      render_inline(described_class.new) do |card|
        card.with_header { "Header" }
      end

      expect(rendered_content).to include("bg-neutral-50 dark:bg-neutral-900/50")
    end

    it "applies border-bottom to header" do
      render_inline(described_class.new) do |card|
        card.with_header { "Header" }
      end

      expect(rendered_content).to include("border-b border-black/10 dark:border-white/10")
    end

    it "applies background to footer" do
      render_inline(described_class.new) do |card|
        card.with_footer { "Footer" }
      end

      expect(rendered_content).to include("bg-neutral-50 dark:bg-neutral-900/50")
    end

    it "renders body without background" do
      render_inline(described_class.new) do |card|
        card.with_body { "Body" }
      end

      expect(rendered_content).to include("px-4 py-5 sm:p-6")
      expect(rendered_content).not_to include("bg-neutral-50")
    end
  end

  describe ArtisansUi::Card::EdgeToEdgeComponent do
    it "renders responsive border classes" do
      render_inline(described_class.new) do |card|
        card.with_body { "Content" }
      end

      expect(rendered_content).to include("border-y sm:border")
    end

    it "applies responsive rounded corners" do
      render_inline(described_class.new) do |card|
        card.with_body { "Content" }
      end

      expect(rendered_content).to include("sm:rounded-xl")
    end

    it "renders body and footer sections" do
      render_inline(described_class.new) do |card|
        card.with_body { "Body" }
        card.with_footer { "Footer" }
      end

      expect(rendered_content).to include("Body")
      expect(rendered_content).to include("Footer")
    end
  end

  describe ArtisansUi::Card::WellComponent do
    it "renders with well styling" do
      render_inline(described_class.new) { "Well content" }

      expect(rendered_content).to include("bg-neutral-50 dark:bg-neutral-900/50")
      expect(rendered_content).to include("Well content")
    end

    it "has rounded corners" do
      render_inline(described_class.new) { "Content" }

      expect(rendered_content).to include("rounded-xl")
    end

    it "applies padding" do
      render_inline(described_class.new) { "Content" }

      expect(rendered_content).to include("px-6 py-5")
    end

    it "has border" do
      render_inline(described_class.new) { "Content" }

      expect(rendered_content).to include("border border-black/10 dark:border-white/10")
    end

    it "does not include shadow" do
      render_inline(described_class.new) { "Content" }

      expect(rendered_content).not_to include("shadow")
    end
  end

  describe ArtisansUi::Card::WithImageComponent do
    let(:params) do
      {
        image_url: "https://example.com/image.jpg",
        image_alt: "Test image",
        title: "Test Title",
        description: "Test description"
      }
    end

    it "renders image section" do
      render_inline(described_class.new(**params))

      expect(rendered_content).to include("https://example.com/image.jpg")
      expect(rendered_content).to include("Test image")
    end

    it "renders title and description" do
      render_inline(described_class.new(**params))

      expect(rendered_content).to include("Test Title")
      expect(rendered_content).to include("Test description")
    end

    it "renders badge when provided" do
      render_inline(described_class.new(**params.merge(badge_text: "Article", badge_color: "blue")))

      expect(rendered_content).to include("Article")
      expect(rendered_content).to include("bg-blue-100")
    end

    it "renders meta text when provided" do
      render_inline(described_class.new(**params.merge(meta_text: "5 min read")))

      expect(rendered_content).to include("5 min read")
    end

    it "renders author section when provided" do
      render_inline(described_class.new(**params.merge(
        author_name: "John Doe",
        author_image: "https://example.com/author.jpg",
        author_date: "Sep 16, 2025"
      )))

      expect(rendered_content).to include("John Doe")
      expect(rendered_content).to include("Sep 16, 2025")
      expect(rendered_content).to include("https://example.com/author.jpg")
    end

    it "renders share button in footer" do
      render_inline(described_class.new(**params.merge(author_name: "Author")))

      expect(rendered_content).to include('<svg')
      expect(rendered_content).to include('viewBox="0 0 20 20"')
    end
  end

  describe ArtisansUi::Card::StatsComponent do
    let(:params) do
      {
        label: "Total Revenue",
        value: "$71,897"
      }
    end

    it "renders label and value" do
      render_inline(described_class.new(**params))

      expect(rendered_content).to include("Total Revenue")
      expect(rendered_content).to include("$71,897")
    end

    it "applies correct styling to label" do
      render_inline(described_class.new(**params))

      expect(rendered_content).to include("text-sm font-medium text-neutral-500 dark:text-neutral-400")
    end

    it "applies correct styling to value" do
      render_inline(described_class.new(**params))

      expect(rendered_content).to include("text-3xl font-semibold text-neutral-900 dark:text-white")
    end

    it "renders upward trend" do
      render_inline(described_class.new(**params.merge(
        trend: "up",
        trend_value: "12.5%",
        trend_label: "from last month"
      )))

      expect(rendered_content).to include("12.5%")
      expect(rendered_content).to include("from last month")
      expect(rendered_content).to include("text-green-600 dark:text-green-400")
    end

    it "renders downward trend" do
      render_inline(described_class.new(**params.merge(
        trend: "down",
        trend_value: "5.2%"
      )))

      expect(rendered_content).to include("5.2%")
      expect(rendered_content).to include("text-red-600 dark:text-red-400")
    end

    it "renders progress bar" do
      render_inline(described_class.new(**params.merge(
        trend: "up",
        progress_label: "Progress to goal",
        progress_value: 72
      )))

      expect(rendered_content).to include("Progress to goal")
      expect(rendered_content).to include("72%")
      expect(rendered_content).to include('style="width:72%"')
    end
  end
end
