# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Layout::MainContentComponent, type: :component do
  describe "rendering" do
    context "with default options" do
      subject(:component) { described_class.new }

      it "renders with default padding" do
        render_inline(component) { "Test content" }

        expect(rendered_content).to include("p-4 sm:p-6 lg:p-8")
      end

      it "renders with default max-width" do
        render_inline(component) { "Test content" }

        expect(rendered_content).to include("max-w-7xl")
      end

      it "renders with mx-auto centering" do
        render_inline(component) { "Test content" }

        expect(rendered_content).to include("mx-auto")
      end

      it "renders content inside nested divs" do
        render_inline(component) { "Test content" }

        expect(rendered_content).to include("Test content")
      end

      it "uses div as wrapper tag by default" do
        render_inline(component) { "Test content" }

        expect(rendered_content).to include('<div class="p-4 sm:p-6 lg:p-8"')
        expect(rendered_content).to match(/<\/div>/)
      end
    end

    context "with custom max_width" do
      subject(:component) { described_class.new(max_width: "max-w-4xl") }

      it "applies custom max-width" do
        render_inline(component) { "Test content" }

        expect(rendered_content).to include("max-w-4xl")
        expect(rendered_content).not_to include("max-w-7xl")
      end
    end

    context "with custom padding" do
      subject(:component) { described_class.new(padding: "p-8") }

      it "applies custom padding" do
        render_inline(component) { "Test content" }

        expect(rendered_content).to include("p-8")
        expect(rendered_content).not_to include("p-4 sm:p-6 lg:p-8")
      end
    end

    context "with custom wrapper_tag" do
      subject(:component) { described_class.new(wrapper_tag: :main) }

      it "uses custom tag as wrapper" do
        render_inline(component) { "Test content" }

        expect(rendered_content).to include('<main class="p-4 sm:p-6 lg:p-8"')
        expect(rendered_content).to match(/<\/main>/)
      end
    end

    context "with custom HTML options" do
      subject(:component) { described_class.new(class: "custom-class", data: { controller: "content" }) }

      it "applies custom class alongside padding" do
        render_inline(component) { "Test content" }

        expect(rendered_content).to include('class="p-4 sm:p-6 lg:p-8 custom-class"')
      end

      it "applies data attributes" do
        render_inline(component) { "Test content" }

        expect(rendered_content).to include('data-controller="content"')
      end
    end

    context "with all custom options" do
      subject(:component) do
        described_class.new(
          max_width: "max-w-5xl",
          padding: "p-6 sm:p-8",
          wrapper_tag: :section,
          class: "bg-white",
          id: "main-content"
        )
      end

      it "applies all customizations correctly" do
        render_inline(component) { "Custom content" }

        expect(rendered_content).to include("max-w-5xl")
        expect(rendered_content).to include("p-6 sm:p-8 bg-white")
        expect(rendered_content).to include('id="main-content"')
        expect(rendered_content).to match(/<section/)
        expect(rendered_content).to include("Custom content")
      end
    end
  end

  describe "#outer_classes" do
    it "combines padding and custom classes" do
      component = described_class.new(padding: "p-4", class: "bg-white")
      expect(component.outer_classes).to eq("p-4 bg-white")
    end

    it "returns only padding when no custom class" do
      component = described_class.new(padding: "p-8")
      expect(component.outer_classes).to eq("p-8")
    end
  end

  describe "#inner_classes" do
    it "returns max-width with mx-auto" do
      component = described_class.new(max_width: "max-w-4xl")
      expect(component.inner_classes).to eq("max-w-4xl mx-auto")
    end
  end
end
