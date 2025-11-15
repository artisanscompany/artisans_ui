# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Badge::NotificationComponent, type: :component do
  describe "#call" do
    it "renders a notification badge with count" do
      component = described_class.new(count: 3)
      render_inline(component)

      expect(page).to have_css("span.inline-flex.items-center.justify-center.rounded-full", text: "3")
      expect(page).to have_css("span.bg-red-500.text-white")
    end

    it "renders a high count notification badge" do
      component = described_class.new(count: 99)
      render_inline(component)

      expect(page).to have_css("span", text: "99")
    end

    it "displays max+ when count exceeds max value" do
      component = described_class.new(count: 150, max: 99)
      render_inline(component)

      expect(page).to have_css("span", text: "99+")
    end

    it "displays exact count when below max value" do
      component = described_class.new(count: 50, max: 99)
      render_inline(component)

      expect(page).to have_css("span", text: "50")
    end

    it "renders primary variant" do
      component = described_class.new(count: 5, variant: :primary)
      render_inline(component)

      expect(page).to have_css("span.bg-blue-500.text-white", text: "5")
    end

    it "renders success variant" do
      component = described_class.new(count: 10, variant: :success)
      render_inline(component)

      expect(page).to have_css("span.bg-green-500.text-white", text: "10")
    end

    it "renders warning variant" do
      component = described_class.new(count: 7, variant: :warning)
      render_inline(component)

      expect(page).to have_css("span.bg-yellow-500.text-white", text: "7")
    end

    it "renders neutral variant" do
      component = described_class.new(count: 2, variant: :neutral)
      render_inline(component)

      expect(page).to have_css("span.bg-neutral-500.text-white", text: "2")
    end

    it "hides badge when count is zero and show_zero is false" do
      component = described_class.new(count: 0, show_zero: false)
      render_inline(component)

      expect(page).not_to have_css("span")
      expect(rendered_content).to be_empty
    end

    it "shows badge when count is zero and show_zero is true" do
      component = described_class.new(count: 0, show_zero: true)
      render_inline(component)

      expect(page).to have_css("span", text: "0")
    end

    it "accepts custom HTML options" do
      component = described_class.new(
        count: 5,
        id: "custom-notification",
        data: { test: "value" }
      )
      render_inline(component)

      expect(page).to have_css("span#custom-notification[data-test='value']", text: "5")
    end

    it "raises an error for invalid variant" do
      expect {
        described_class.new(count: 1, variant: :invalid)
      }.to raise_error(ArgumentError, "Invalid variant: invalid")
    end

    it "handles string count values" do
      component = described_class.new(count: "42")
      render_inline(component)

      expect(page).to have_css("span", text: "42")
    end

    it "has minimum width for single digit counts" do
      component = described_class.new(count: 1)
      render_inline(component)

      expect(page).to have_css("span.min-w-\\[1\\.25rem\\]", text: "1")
    end
  end
end
