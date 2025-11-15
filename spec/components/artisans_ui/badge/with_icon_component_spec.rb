# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Badge::WithIconComponent, type: :component do
  describe "#call" do
    it "renders a badge with check icon on the left by default" do
      component = described_class.new(text: "Active")
      render_inline(component)

      expect(page).to have_css("span.inline-flex.items-center.gap-1\\.5.rounded-md.px-2.py-1.text-xs.font-medium")
      expect(page).to have_css("svg")
      expect(page).to have_text("Active")
    end

    it "renders a success badge with check icon" do
      component = described_class.new(text: "Verified", variant: :success, icon_type: :check)
      render_inline(component)

      expect(page).to have_css("span.bg-green-100.text-green-700", text: "Verified")
      expect(page).to have_css("svg")
    end

    it "renders a badge with star icon" do
      component = described_class.new(text: "Featured", variant: :primary, icon_type: :star)
      render_inline(component)

      expect(page).to have_css("span", text: "Featured")
      expect(page).to have_css("svg[fill='currentColor']")
    end

    it "renders a badge with alert icon" do
      component = described_class.new(text: "Alert", variant: :error, icon_type: :alert)
      render_inline(component)

      expect(page).to have_css("span.bg-red-100.text-red-700", text: "Alert")
      expect(page).to have_css("svg")
    end

    it "renders a badge with info icon" do
      component = described_class.new(text: "Info", variant: :info, icon_type: :info)
      render_inline(component)

      expect(page).to have_css("span.bg-cyan-100.text-cyan-700", text: "Info")
      expect(page).to have_css("svg")
    end

    it "renders icon on the right when specified" do
      component = described_class.new(
        text: "New",
        variant: :primary,
        icon_position: :right
      )
      render_inline(component)

      # Check that text appears before icon in the HTML
      html = rendered_content
      text_index = html.index("New")
      svg_index = html.index("<svg")
      expect(text_index).to be < svg_index
    end

    it "renders icon on the left when specified" do
      component = described_class.new(
        text: "Active",
        variant: :success,
        icon_position: :left
      )
      render_inline(component)

      # Check that icon appears before text in the HTML
      html = rendered_content
      text_index = html.index("Active")
      svg_index = html.index("<svg")
      expect(svg_index).to be < text_index
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

    it "raises an error for invalid icon_position" do
      expect {
        described_class.new(text: "Test", icon_position: :invalid)
      }.to raise_error(ArgumentError, "Invalid icon_position: invalid. Must be :left or :right")
    end

    it "raises an error for invalid icon_type" do
      expect {
        described_class.new(text: "Test", icon_type: :invalid)
      }.to raise_error(ArgumentError, "Invalid icon_type: invalid")
    end

    it "supports dark mode classes" do
      component = described_class.new(text: "Dark Mode", variant: :neutral)
      render_inline(component)

      expect(page).to have_css("span.dark\\:bg-neutral-700.dark\\:text-neutral-300")
    end
  end
end
