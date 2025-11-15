# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ArtisansUi::Clipboard Components", type: :component do
  describe "BasicComponent" do
    it "renders a button with clipboard controller" do
      render_inline(ArtisansUi::Clipboard::BasicComponent.new(text: "Hello")) { "Copy" }
      expect(rendered_content).to include('data-controller="clipboard"')
    end

    it "sets the clipboard text attribute" do
      render_inline(ArtisansUi::Clipboard::BasicComponent.new(text: "Test text")) { "Copy" }
      expect(rendered_content).to include('data-clipboard-text="Test text"')
    end

    it "renders button content" do
      render_inline(ArtisansUi::Clipboard::BasicComponent.new(text: "Test")) { "Copy Text" }
      expect(rendered_content).to include("Copy Text")
    end

    it "applies dark mode classes" do
      render_inline(ArtisansUi::Clipboard::BasicComponent.new(text: "Test")) { "Copy" }
      expect(rendered_content).to include("dark:bg-white")
    end

    it "applies custom HTML attributes" do
      render_inline(ArtisansUi::Clipboard::BasicComponent.new(text: "Test", id: "custom-btn")) { "Copy" }
      expect(rendered_content).to include('id="custom-btn"')
    end
  end

  describe "WithIconStatesComponent" do
    it "renders copy and copied content targets" do
      render_inline(ArtisansUi::Clipboard::WithIconStatesComponent.new(text: "URL"))
      expect(rendered_content).to include('data-clipboard-target="copyContent"')
      expect(rendered_content).to include('data-clipboard-target="copiedContent"')
    end

    it "renders copy icon" do
      render_inline(ArtisansUi::Clipboard::WithIconStatesComponent.new(text: "URL"))
      expect(rendered_content.scan(/<svg/).length).to eq(2)
    end

    it "hides copied content by default" do
      render_inline(ArtisansUi::Clipboard::WithIconStatesComponent.new(text: "URL"))
      expect(rendered_content).to include('data-clipboard-target="copiedContent"')
      expect(rendered_content).to include('class="hidden')
    end

    it "sets custom success message" do
      render_inline(ArtisansUi::Clipboard::WithIconStatesComponent.new(
        text: "URL",
        success_message: "Custom message!"
      ))
      expect(rendered_content).to include('data-clipboard-success-message-value="Custom message!"')
    end

    it "renders Copy URL text" do
      render_inline(ArtisansUi::Clipboard::WithIconStatesComponent.new(text: "URL"))
      expect(rendered_content).to include("Copy URL")
    end

    it "renders Copied text in hidden state" do
      render_inline(ArtisansUi::Clipboard::WithIconStatesComponent.new(text: "URL"))
      expect(rendered_content).to include("Copied!")
    end
  end

  describe "WithInputComponent" do
    it "renders an input field and button" do
      render_inline(ArtisansUi::Clipboard::WithInputComponent.new(text: "https://example.com"))
      expect(rendered_content).to have_css('input[type="text"]')
      expect(rendered_content).to have_css('button[data-controller="clipboard"]')
    end

    it "sets input value to text" do
      render_inline(ArtisansUi::Clipboard::WithInputComponent.new(text: "https://example.com"))
      expect(rendered_content).to have_css('input[value="https://example.com"]')
    end

    it "makes input readonly" do
      render_inline(ArtisansUi::Clipboard::WithInputComponent.new(text: "Test"))
      expect(rendered_content).to have_css('input[readonly]')
    end

    it "sets custom input ID" do
      render_inline(ArtisansUi::Clipboard::WithInputComponent.new(
        text: "Test",
        input_id: "custom-input"
      ))
      expect(rendered_content).to have_css('input#custom-input')
    end

    it "renders copy and copied icons in button" do
      render_inline(ArtisansUi::Clipboard::WithInputComponent.new(text: "Test"))
      expect(rendered_content).to have_css('[data-clipboard-target="copyContent"]')
      expect(rendered_content).to have_css('[data-clipboard-target="copiedContent"]')
    end

    it "applies flex layout to container" do
      render_inline(ArtisansUi::Clipboard::WithInputComponent.new(text: "Test"))
      expect(rendered_content).to have_css('div.flex.max-w-md')
    end
  end

  describe "CodeBlockComponent" do
    it "renders code block with pre and code tags" do
      render_inline(ArtisansUi::Clipboard::CodeBlockComponent.new(code: "npm install"))
      expect(rendered_content).to have_css('pre code')
    end

    it "displays code content" do
      render_inline(ArtisansUi::Clipboard::CodeBlockComponent.new(code: "npm install"))
      expect(rendered_content).to have_content("npm install")
    end

    it "positions button absolutely" do
      render_inline(ArtisansUi::Clipboard::CodeBlockComponent.new(code: "test"))
      expect(rendered_content).to have_css('button.absolute.top-2.right-4')
    end

    it "enables tooltip by default" do
      render_inline(ArtisansUi::Clipboard::CodeBlockComponent.new(code: "test"))
      expect(rendered_content).to have_css('button[data-clipboard-show-tooltip-value="true"]')
    end

    it "renders Copy and Copied states" do
      render_inline(ArtisansUi::Clipboard::CodeBlockComponent.new(code: "test"))
      expect(rendered_content).to have_content("Copy")
      expect(rendered_content).to have_content("Copied!")
    end

    it "applies code block styling" do
      render_inline(ArtisansUi::Clipboard::CodeBlockComponent.new(code: "test"))
      expect(rendered_content).to have_css('pre.bg-neutral-900.text-neutral-100')
    end
  end

  describe "IconOnlyComponent" do
    it "renders icon-only button" do
      render_inline(ArtisansUi::Clipboard::IconOnlyComponent.new(text: "Secret"))
      expect(rendered_content).to have_css('button[data-controller="clipboard"]')
      expect(rendered_content).not_to have_content("Copy")
    end

    it "enables tooltip by default" do
      render_inline(ArtisansUi::Clipboard::IconOnlyComponent.new(text: "Secret"))
      expect(rendered_content).to have_css('button[data-clipboard-show-tooltip-value="true"]')
    end

    it "renders only icons, no text" do
      render_inline(ArtisansUi::Clipboard::IconOnlyComponent.new(text: "Secret"))
      expect(rendered_content).to have_css('svg', count: 2)
      expect(rendered_content).not_to have_text(/^Copy$/)
    end

    it "applies appropriate sizing" do
      render_inline(ArtisansUi::Clipboard::IconOnlyComponent.new(text: "Secret"))
      expect(rendered_content).to have_css('button.p-2\.5')
    end

    it "shows check icon in copied state" do
      render_inline(ArtisansUi::Clipboard::IconOnlyComponent.new(text: "Secret"))
      expect(rendered_content).to have_css('svg.text-green-600.dark\:text-green-400')
    end
  end

  describe "WithoutTooltipComponent" do
    it "disables tooltip" do
      render_inline(ArtisansUi::Clipboard::WithoutTooltipComponent.new(text: "Description"))
      expect(rendered_content).to have_css('button[data-clipboard-show-tooltip-value="false"]')
    end

    it "renders Copy Description text" do
      render_inline(ArtisansUi::Clipboard::WithoutTooltipComponent.new(text: "Description"))
      expect(rendered_content).to have_content("Copy Description")
    end

    it "renders Copied text" do
      render_inline(ArtisansUi::Clipboard::WithoutTooltipComponent.new(text: "Description"))
      expect(rendered_content).to have_content("Copied!")
    end

    it "includes copy and copied targets" do
      render_inline(ArtisansUi::Clipboard::WithoutTooltipComponent.new(text: "Description"))
      expect(rendered_content).to have_css('[data-clipboard-target="copyContent"]')
      expect(rendered_content).to have_css('[data-clipboard-target="copiedContent"]')
    end

    it "applies border styling" do
      render_inline(ArtisansUi::Clipboard::WithoutTooltipComponent.new(text: "Description"))
      expect(rendered_content).to have_css('button.border.border-neutral-200')
    end
  end

  describe "TooltipPositionsComponent" do
    it "sets default top placement" do
      render_inline(ArtisansUi::Clipboard::TooltipPositionsComponent.new(text: "Test")) { "top" }
      expect(rendered_content).to have_css('button[data-clipboard-tooltip-placement-value="top"]')
    end

    it "accepts custom placement" do
      render_inline(ArtisansUi::Clipboard::TooltipPositionsComponent.new(
        text: "Test",
        placement: "bottom-start"
      )) { "bottom-start" }
      expect(rendered_content).to have_css('button[data-clipboard-tooltip-placement-value="bottom-start"]')
    end

    it "renders button content" do
      render_inline(ArtisansUi::Clipboard::TooltipPositionsComponent.new(text: "Test")) { "top" }
      expect(rendered_content).to have_content("top")
    end

    it "includes copy and copied states" do
      render_inline(ArtisansUi::Clipboard::TooltipPositionsComponent.new(text: "Test")) { "test" }
      expect(rendered_content).to have_css('[data-clipboard-target="copyContent"]')
      expect(rendered_content).to have_css('[data-clipboard-target="copiedContent"]')
    end

    %w[top top-start top-end bottom bottom-start bottom-end left left-start left-end right right-start right-end].each do |placement|
      it "supports #{placement} placement" do
        render_inline(ArtisansUi::Clipboard::TooltipPositionsComponent.new(
          text: "Test",
          placement: placement
        )) { placement }
        expect(rendered_content).to have_css("button[data-clipboard-tooltip-placement-value='#{placement}']")
      end
    end
  end
end
