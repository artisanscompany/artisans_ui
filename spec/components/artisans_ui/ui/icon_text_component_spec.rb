# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Ui::IconTextComponent, type: :component do
  describe "rendering" do
    it "renders a span element" do
      component = described_class.new(text: "Vienna, Austria")
      rendered = render_inline(component)

      expect(rendered.css("span").first.name).to eq("span")
    end

    it "renders text content" do
      component = described_class.new(text: "Full-time position")
      rendered = render_inline(component)

      expect(rendered.text).to include("Full-time position")
    end

    it "renders icon when provided" do
      component = described_class.new(text: "Vienna, Austria", icon: "map-marker-alt")
      rendered = render_inline(component)

      expect(rendered.css("i.fas.fa-map-marker-alt")).to be_present
    end

    it "does not render icon when not provided" do
      component = described_class.new(text: "Full-time position")
      rendered = render_inline(component)

      expect(rendered.css("i")).to be_empty
    end
  end

  describe "variants" do
    it "applies default variant classes" do
      component = described_class.new(text: "Test", variant: :default)
      rendered = render_inline(component)

      expect(rendered.css("span").first[:class]).to include("text-neutral-600")
      expect(rendered.css("span").first[:class]).to include("dark:text-neutral-400")
    end

    it "applies emphasis variant classes" do
      component = described_class.new(text: "Test", variant: :emphasis)
      rendered = render_inline(component)

      expect(rendered.css("span").first[:class]).to include("text-neutral-900")
      expect(rendered.css("span").first[:class]).to include("dark:text-white")
      expect(rendered.css("span").first[:class]).to include("font-medium")
    end

    it "applies success variant classes" do
      component = described_class.new(text: "Test", variant: :success)
      rendered = render_inline(component)

      expect(rendered.css("span").first[:class]).to include("text-green-600")
      expect(rendered.css("span").first[:class]).to include("dark:text-green-400")
    end

    it "applies warning variant classes" do
      component = described_class.new(text: "Test", variant: :warning)
      rendered = render_inline(component)

      expect(rendered.css("span").first[:class]).to include("text-yellow-600")
      expect(rendered.css("span").first[:class]).to include("dark:text-yellow-400")
    end

    it "applies error variant classes" do
      component = described_class.new(text: "Test", variant: :error)
      rendered = render_inline(component)

      expect(rendered.css("span").first[:class]).to include("text-red-600")
      expect(rendered.css("span").first[:class]).to include("dark:text-red-400")
    end

    it "applies info variant classes" do
      component = described_class.new(text: "Test", variant: :info)
      rendered = render_inline(component)

      expect(rendered.css("span").first[:class]).to include("text-blue-600")
      expect(rendered.css("span").first[:class]).to include("dark:text-blue-400")
    end
  end

  describe "base classes" do
    it "includes inline-flex and items-center classes" do
      component = described_class.new(text: "Test")
      rendered = render_inline(component)

      expect(rendered.css("span").first[:class]).to include("inline-flex")
      expect(rendered.css("span").first[:class]).to include("items-center")
      expect(rendered.css("span").first[:class]).to include("gap-2")
    end
  end

  describe "custom classes" do
    it "accepts custom class parameter" do
      component = described_class.new(text: "Test", class: "custom-class")
      rendered = render_inline(component)

      expect(rendered.css("span").first[:class]).to include("custom-class")
    end

    it "combines variant and custom classes" do
      component = described_class.new(text: "Test", variant: :emphasis, class: "ml-4")
      rendered = render_inline(component)

      expect(rendered.css("span").first[:class]).to include("text-neutral-900")
      expect(rendered.css("span").first[:class]).to include("ml-4")
    end
  end

  describe "icon customization" do
    it "accepts custom icon_class parameter" do
      component = described_class.new(text: "Test", icon: "check", icon_class: "text-xl")
      rendered = render_inline(component)

      expect(rendered.css("i").first[:class]).to include("text-xl")
      expect(rendered.css("i").first[:class]).to include("fas")
      expect(rendered.css("i").first[:class]).to include("fa-check")
    end
  end

  describe "HTML attributes" do
    it "accepts additional HTML attributes" do
      component = described_class.new(text: "Test", id: "custom-id", data: { controller: "tooltip" })
      rendered = render_inline(component)

      expect(rendered.css("span#custom-id")).to be_present
      expect(rendered.css("span").first["data-controller"]).to eq("tooltip")
    end
  end

  describe "parameter validation" do
    it "raises error for invalid variant" do
      expect {
        described_class.new(text: "Test", variant: :invalid)
      }.to raise_error(ArgumentError, /Invalid variant/)
    end

    it "raises error when text is blank" do
      expect {
        described_class.new(text: "")
      }.to raise_error(ArgumentError, /text parameter is required/)
    end

    it "raises error when text is nil" do
      expect {
        described_class.new(text: nil)
      }.to raise_error(ArgumentError, /text parameter is required/)
    end

    it "does not raise error for valid variant" do
      expect {
        described_class.new(text: "Test", variant: :success)
      }.not_to raise_error
    end
  end

  describe "accessibility" do
    it "wraps text in span for proper structure" do
      component = described_class.new(text: "Vienna, Austria", icon: "map-marker-alt")
      rendered = render_inline(component)

      # Outer span contains both icon and text span
      expect(rendered.css("span > span").text).to eq("Vienna, Austria")
    end
  end
end
