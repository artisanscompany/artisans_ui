# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Badge::BasicComponent, type: :component do
  describe "#call" do
    it "renders a basic neutral badge" do
      component = described_class.new(text: "Badge")
      render_inline(component)

      expect(page).to have_css("span.inline-flex.items-center.rounded-md.px-2.py-1.text-xs.font-medium", text: "Badge")
      expect(page).to have_css("span.bg-neutral-100.text-neutral-700")
    end

    it "renders a success variant badge" do
      component = described_class.new(text: "Active", variant: :success)
      render_inline(component)

      expect(page).to have_css("span", text: "Active")
      expect(page).to have_css("span.bg-green-100.text-green-700")
    end

    it "renders a primary variant badge" do
      component = described_class.new(text: "New", variant: :primary)
      render_inline(component)

      expect(page).to have_css("span", text: "New")
      expect(page).to have_css("span.bg-blue-100.text-blue-700")
    end

    it "renders an error variant badge" do
      component = described_class.new(text: "Error", variant: :error)
      render_inline(component)

      expect(page).to have_css("span", text: "Error")
      expect(page).to have_css("span.bg-red-100.text-red-700")
    end

    it "renders a warning variant badge" do
      component = described_class.new(text: "Warning", variant: :warning)
      render_inline(component)

      expect(page).to have_css("span", text: "Warning")
      expect(page).to have_css("span.bg-yellow-100.text-yellow-700")
    end

    it "renders an info variant badge" do
      component = described_class.new(text: "Info", variant: :info)
      render_inline(component)

      expect(page).to have_css("span", text: "Info")
      expect(page).to have_css("span.bg-cyan-100.text-cyan-700")
    end

    it "accepts custom HTML options" do
      component = described_class.new(
        text: "Custom",
        id: "custom-badge",
        data: { test: "value" }
      )
      render_inline(component)

      expect(page).to have_css("span#custom-badge[data-test='value']", text: "Custom")
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
    end
  end
end
