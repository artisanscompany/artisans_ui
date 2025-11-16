# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Typography::BodyComponent, type: :component do
  describe "rendering" do
    it "renders a paragraph tag by default" do
      rendered_content = render_inline(described_class.new) { "Body text" }
      expect(rendered_content.to_html).to include("<p")
      expect(rendered_content.to_html).to include("Body text")
    end

    it "applies regular variant classes by default" do
      rendered_content = render_inline(described_class.new) { "Body text" }
      expect(rendered_content.to_html).to include("text-sm sm:text-base")
      expect(rendered_content.to_html).to include("text-neutral-700")
      expect(rendered_content.to_html).to include("dark:text-neutral-300")
    end

    it "applies large variant classes" do
      rendered_content = render_inline(described_class.new(variant: :large)) { "Large body text" }
      expect(rendered_content.to_html).to include("text-base sm:text-lg")
      expect(rendered_content.to_html).to include("text-neutral-700")
    end

    it "applies small variant classes" do
      rendered_content = render_inline(described_class.new(variant: :small)) { "Small text" }
      expect(rendered_content.to_html).to include("text-xs sm:text-sm")
      expect(rendered_content.to_html).to include("text-neutral-600")
      expect(rendered_content.to_html).to include("dark:text-neutral-400")
    end

    it "allows custom classes" do
      rendered_content = render_inline(described_class.new(class: "custom-class")) { "Custom text" }
      expect(rendered_content.to_html).to include("custom-class")
    end

    it "allows variant to be nil for custom styling" do
      rendered_content = render_inline(described_class.new(variant: nil, class: "text-blue-600")) { "Custom text" }
      expect(rendered_content.to_html).to include("text-blue-600")
      expect(rendered_content.to_html).not_to include("text-neutral")
    end

    it "raises error for invalid variant" do
      expect {
        render_inline(described_class.new(variant: :invalid)) { "Text" }
      }.to raise_error(ArgumentError, "Invalid variant: invalid")
    end

    it "accepts additional HTML attributes" do
      rendered_content = render_inline(described_class.new(id: "test-id", data: { controller: "test" })) { "Text" }
      expect(rendered_content.to_html).to include('id="test-id"')
      expect(rendered_content.to_html).to include('data-controller="test"')
    end
  end
end
