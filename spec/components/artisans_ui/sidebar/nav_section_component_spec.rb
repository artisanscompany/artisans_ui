# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Sidebar::NavSectionComponent, type: :component do
  describe "rendering" do
    it "renders without heading as simple divider" do
      render_inline(described_class.new)

      expect(rendered_content).to include("border-t")
      expect(rendered_content).to include("border-neutral-200")
      expect(rendered_content).to include("dark:border-neutral-800")
      expect(rendered_content).to include("my-2")
    end

    it "renders with heading" do
      render_inline(described_class.new(heading: "Settings"))

      expect(rendered_content).to include("Settings")
    end
  end

  describe "heading variant" do
    it "applies proper heading styles" do
      render_inline(described_class.new(heading: "Main Menu"))

      expect(rendered_content).to include("text-xs")
      expect(rendered_content).to include("font-semibold")
      expect(rendered_content).to include("uppercase")
      expect(rendered_content).to include("tracking-wider")
    end

    it "applies heading color classes" do
      render_inline(described_class.new(heading: "Settings"))

      expect(rendered_content).to include("text-neutral-500")
      expect(rendered_content).to include("dark:text-neutral-400")
    end

    it "includes padding around heading" do
      render_inline(described_class.new(heading: "Admin"))

      expect(rendered_content).to include("px-2")
      expect(rendered_content).to include("pt-4")
      expect(rendered_content).to include("pb-2")
    end

    it "includes divider above heading" do
      render_inline(described_class.new(heading: "Tools"))

      expect(rendered_content).to include("border-t")
      expect(rendered_content).to include("border-neutral-200")
    end
  end

  describe "HTML options" do
    it "accepts custom id" do
      render_inline(described_class.new(id: "section-main"))

      expect(rendered_content).to include('id="section-main"')
    end

    it "accepts custom data attributes" do
      render_inline(described_class.new(data: { section: "main" }))

      expect(rendered_content).to include('data-section="main"')
    end

    it "accepts custom class" do
      render_inline(described_class.new(class: "custom-section"))

      expect(rendered_content).to include("custom-section")
    end
  end

  describe "dark mode" do
    it "includes dark mode border color" do
      render_inline(described_class.new)

      expect(rendered_content).to include("dark:border-neutral-800")
    end

    it "includes dark mode text color for heading" do
      render_inline(described_class.new(heading: "Menu"))

      expect(rendered_content).to include("dark:text-neutral-400")
    end
  end

  describe "edge cases" do
    it "handles empty heading string" do
      render_inline(described_class.new(heading: ""))

      # Should render as simple divider when heading is empty
      expect(rendered_content).to include("border-t")
      expect(rendered_content).not_to include("<h3")
    end

    it "handles nil heading" do
      render_inline(described_class.new(heading: nil))

      expect(rendered_content).to include("border-t")
      expect(rendered_content).not_to include("<h3")
    end
  end
end
