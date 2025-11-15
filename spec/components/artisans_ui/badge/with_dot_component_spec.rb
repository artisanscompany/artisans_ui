# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Badge::WithDotComponent, type: :component do
  describe "#call" do
    it "renders a badge with a static dot by default" do
      component = described_class.new(text: "Online")
      render_inline(component)

      expect(page).to have_css("span.inline-flex.items-center.gap-1\\.5.rounded-md.px-2.py-1.text-xs.font-medium", text: "Online")
      expect(page).to have_css("span.size-1\\.5.rounded-full")
    end

    it "renders a success badge with green dot" do
      component = described_class.new(text: "Online", variant: :success)
      render_inline(component)

      expect(page).to have_css("span.bg-green-100.text-green-700", text: "Online")
      expect(page).to have_css("span.bg-green-500")
    end

    it "renders an error badge with red dot" do
      component = described_class.new(text: "Offline", variant: :error)
      render_inline(component)

      expect(page).to have_css("span.bg-red-100.text-red-700", text: "Offline")
      expect(page).to have_css("span.bg-red-500")
    end

    it "renders a warning badge with yellow dot" do
      component = described_class.new(text: "Busy", variant: :warning)
      render_inline(component)

      expect(page).to have_css("span.bg-yellow-100.text-yellow-700", text: "Busy")
      expect(page).to have_css("span.bg-yellow-500")
    end

    it "renders a badge with pulsing dot when pulse is true" do
      component = described_class.new(text: "Live", variant: :error, pulse: true)
      render_inline(component)

      expect(page).to have_css("span.animate-ping")
      expect(page).to have_text("Live")
    end

    it "renders a badge without pulsing dot when pulse is false" do
      component = described_class.new(text: "Online", variant: :success, pulse: false)
      render_inline(component)

      expect(page).not_to have_css("span.animate-ping")
      expect(page).to have_css("span.size-1\\.5.rounded-full")
    end

    it "renders a primary badge with blue dot" do
      component = described_class.new(text: "Active", variant: :primary)
      render_inline(component)

      expect(page).to have_css("span.bg-blue-100.text-blue-700", text: "Active")
      expect(page).to have_css("span.bg-blue-500")
    end

    it "renders an info badge with cyan dot" do
      component = described_class.new(text: "Info", variant: :info)
      render_inline(component)

      expect(page).to have_css("span.bg-cyan-100.text-cyan-700", text: "Info")
      expect(page).to have_css("span.bg-cyan-500")
    end

    it "accepts custom HTML options" do
      component = described_class.new(
        text: "Custom",
        id: "custom-badge",
        data: { test: "value" }
      )
      render_inline(component)

      expect(page).to have_css("span#custom-badge[data-test='value']")
    end

    it "raises an error for invalid variant" do
      expect {
        described_class.new(text: "Test", variant: :invalid)
      }.to raise_error(ArgumentError, "Invalid variant: invalid")
    end

    it "supports dark mode classes" do
      component = described_class.new(text: "Dark Mode", variant: :neutral)
      render_inline(component)

      expect(page).to have_css("span.dark\\:bg-neutral-700.dark\\:text-neutral-300")
      expect(page).to have_css("span.dark\\:bg-neutral-400")
    end
  end
end
