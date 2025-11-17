# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Layout::FlashComponent, type: :component do
  describe "rendering" do
    context "with notice" do
      subject(:component) { described_class.new(notice: "Success message") }

      it "renders the notice flash message" do
        render_inline(component)

        expect(rendered_content).to include("Success message")
        expect(rendered_content).to include("bg-green-50")
        expect(rendered_content).to include("border-green-400")
        expect(rendered_content).to include("text-green-700")
      end

      it "includes success icon SVG" do
        render_inline(component)

        expect(rendered_content).to include("text-green-400")
        expect(rendered_content).to include('<svg')
      end

      it "includes flash_messages id" do
        render_inline(component)

        expect(rendered_content).to include('id="flash_messages"')
      end
    end

    context "with alert" do
      subject(:component) { described_class.new(alert: "Error message") }

      it "renders the alert flash message" do
        render_inline(component)

        expect(rendered_content).to include("Error message")
        expect(rendered_content).to include("bg-red-50")
        expect(rendered_content).to include("border-red-400")
        expect(rendered_content).to include("text-red-700")
      end

      it "includes error icon SVG" do
        render_inline(component)

        expect(rendered_content).to include("text-red-400")
        expect(rendered_content).to include('<svg')
      end
    end

    context "with both notice and alert" do
      subject(:component) { described_class.new(notice: "Success", alert: "Error") }

      it "renders both messages" do
        render_inline(component)

        expect(rendered_content).to include("Success")
        expect(rendered_content).to include("Error")
        expect(rendered_content).to include("bg-green-50")
        expect(rendered_content).to include("bg-red-50")
      end
    end

    context "without any messages" do
      subject(:component) { described_class.new }

      it "does not render anything" do
        render_inline(component)

        expect(rendered_content).to be_blank
      end
    end

    context "with custom HTML options" do
      subject(:component) { described_class.new(notice: "Test", class: "custom-class", data: { turbo: "false" }) }

      it "applies custom attributes" do
        render_inline(component)

        expect(rendered_content).to include('class="custom-class"')
        expect(rendered_content).to include('data-turbo="false"')
      end
    end
  end

  describe "#render?" do
    it "returns true when notice is present" do
      component = described_class.new(notice: "Test")
      expect(component.render?).to be true
    end

    it "returns true when alert is present" do
      component = described_class.new(alert: "Test")
      expect(component.render?).to be true
    end

    it "returns true when both are present" do
      component = described_class.new(notice: "Success", alert: "Error")
      expect(component.render?).to be true
    end

    it "returns false when neither is present" do
      component = described_class.new
      expect(component.render?).to be false
    end
  end
end
