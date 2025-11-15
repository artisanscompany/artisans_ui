# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Badge::ColorVariantComponent, type: :component do
  describe "#call" do
    it "renders a soft red badge by default" do
      component = described_class.new(text: "Red", color: :red)
      render_inline(component)

      expect(page).to have_css("span.inline-flex.items-center.rounded-md.px-2.py-1.text-xs.font-medium", text: "Red")
      expect(page).to have_css("span.bg-red-100.text-red-700")
    end

    it "renders a solid green badge" do
      component = described_class.new(text: "Green", color: :green, style: :solid)
      render_inline(component)

      expect(page).to have_css("span", text: "Green")
      expect(page).to have_css("span.bg-green-500.text-white")
    end

    it "renders a soft blue badge" do
      component = described_class.new(text: "Blue", color: :blue, style: :soft)
      render_inline(component)

      expect(page).to have_css("span", text: "Blue")
      expect(page).to have_css("span.bg-blue-100.text-blue-700")
    end

    it "renders a solid yellow badge" do
      component = described_class.new(text: "Yellow", color: :yellow, style: :solid)
      render_inline(component)

      expect(page).to have_css("span", text: "Yellow")
      expect(page).to have_css("span.bg-yellow-500.text-white")
    end

    it "renders a soft purple badge" do
      component = described_class.new(text: "Purple", color: :purple, style: :soft)
      render_inline(component)

      expect(page).to have_css("span", text: "Purple")
      expect(page).to have_css("span.bg-purple-100.text-purple-700")
    end

    it "renders a solid pink badge" do
      component = described_class.new(text: "Pink", color: :pink, style: :solid)
      render_inline(component)

      expect(page).to have_css("span", text: "Pink")
      expect(page).to have_css("span.bg-pink-500.text-white")
    end

    it "renders a soft indigo badge" do
      component = described_class.new(text: "Indigo", color: :indigo, style: :soft)
      render_inline(component)

      expect(page).to have_css("span", text: "Indigo")
      expect(page).to have_css("span.bg-indigo-100.text-indigo-700")
    end

    it "renders a solid orange badge" do
      component = described_class.new(text: "Orange", color: :orange, style: :solid)
      render_inline(component)

      expect(page).to have_css("span", text: "Orange")
      expect(page).to have_css("span.bg-orange-500.text-white")
    end

    it "accepts custom HTML options" do
      component = described_class.new(
        text: "Custom",
        color: :blue,
        id: "custom-badge",
        data: { test: "value" }
      )
      render_inline(component)

      expect(page).to have_css("span#custom-badge[data-test='value']", text: "Custom")
    end

    it "raises an error for invalid color" do
      expect {
        described_class.new(text: "Test", color: :invalid)
      }.to raise_error(ArgumentError, "Invalid color: invalid")
    end

    it "raises an error for invalid style" do
      expect {
        described_class.new(text: "Test", color: :red, style: :invalid)
      }.to raise_error(ArgumentError, "Invalid style: invalid. Must be :solid or :soft")
    end

    it "supports dark mode classes for soft style" do
      component = described_class.new(text: "Dark Mode", color: :green, style: :soft)
      render_inline(component)

      expect(page).to have_css("span.dark\\:bg-green-900\\/30.dark\\:text-green-300")
    end
  end
end
