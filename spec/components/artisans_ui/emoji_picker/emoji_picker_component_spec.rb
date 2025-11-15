# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ArtisansUi::EmojiPicker Components", type: :component do
  describe "ArtisansUi::EmojiPicker::BasicComponent" do
    subject(:component) { ArtisansUi::EmojiPicker::BasicComponent.new }

    it "renders component" do
      render_inline(component)
      expect(rendered_content).to be_present
    end

    it "has emoji-picker controller" do
      render_inline(component)
      expect(rendered_content).to include('data-controller="emoji-picker"')
    end

    it "renders emoji button" do
      render_inline(component)
      expect(rendered_content).to include("emoji-picker#toggle")
      expect(rendered_content).to include('data-emoji-picker-target="button"')
    end

    it "renders hidden input" do
      render_inline(component)
      expect(rendered_content).to include('type="text"')
      expect(rendered_content).to include('class="hidden"')
      expect(rendered_content).to include('data-emoji-picker-target="input"')
    end

    it "renders picker container" do
      render_inline(component)
      expect(rendered_content).to include('data-emoji-picker-target="pickerContainer"')
      expect(rendered_content).to include("hidden absolute z-50")
    end

    it "has emoji icon SVG" do
      render_inline(component)
      expect(rendered_content).to include("<svg")
      expect(rendered_content).to include("viewBox=\"0 0 18 18\"")
    end

    it "accepts custom name parameter" do
      component = ArtisansUi::EmojiPicker::BasicComponent.new(name: "reaction")
      render_inline(component)
      expect(rendered_content).to include('name="reaction"')
    end

    it "has hover states" do
      render_inline(component)
      expect(rendered_content).to include("hover:bg-neutral-100")
      expect(rendered_content).to include("dark:hover:bg-neutral-800")
    end

    it "has disabled states" do
      render_inline(component)
      expect(rendered_content).to include("disabled:pointer-events-none")
      expect(rendered_content).to include("disabled:opacity-50")
    end
  end

  describe "ArtisansUi::EmojiPicker::AutoSubmitComponent" do
    subject(:component) { ArtisansUi::EmojiPicker::AutoSubmitComponent.new }

    it "renders component" do
      render_inline(component)
      expect(rendered_content).to be_present
    end

    it "renders both forms" do
      render_inline(component)
      expect(rendered_content).to include("Auto-submit enabled")
      expect(rendered_content).to include("Auto-submit disabled")
    end

    it "has auto-submit enabled form" do
      render_inline(component)
      expect(rendered_content).to include('data-emoji-picker-auto-submit-value="true"')
    end

    it "has auto-submit disabled form" do
      render_inline(component)
      expect(rendered_content).to include('data-emoji-picker-auto-submit-value="false"')
    end

    it "renders emoji-picker controller on both forms" do
      render_inline(component)
      expect(rendered_content.scan(/data-controller="emoji-picker"/).count).to eq(2)
    end

    it "renders labels" do
      render_inline(component)
      expect(rendered_content).to include("Reaction (auto-submits)")
      expect(rendered_content).to include("Reaction (manual submit)")
    end

    it "renders text inputs" do
      render_inline(component)
      expect(rendered_content).to include("Choose an emoji...")
      expect(rendered_content).to include('class="form-control"')
    end

    it "renders submit button in manual form" do
      render_inline(component)
      expect(rendered_content).to include('type="submit"')
      expect(rendered_content).to include("Send")
    end

    it "has form containers with styling" do
      render_inline(component)
      expect(rendered_content).to include("border border-neutral-200")
      expect(rendered_content).to include("dark:border-neutral-700")
      expect(rendered_content).to include("bg-neutral-50 dark:bg-neutral-800")
    end

    it "has picker containers" do
      render_inline(component)
      expect(rendered_content.scan(/data-emoji-picker-target="pickerContainer"/).count).to eq(2)
    end

    it "renders emoji buttons" do
      render_inline(component)
      expect(rendered_content.scan(/emoji-picker#toggle/).count).to eq(2)
    end

    it "has dark mode classes" do
      render_inline(component)
      expect(rendered_content).to include("dark:text-neutral-300")
      expect(rendered_content).to include("dark:bg-neutral-800")
    end
  end

  describe "ArtisansUi::EmojiPicker::InsertModeComponent" do
    subject(:component) { ArtisansUi::EmojiPicker::InsertModeComponent.new }

    it "renders component" do
      render_inline(component)
      expect(rendered_content).to be_present
    end

    it "has emoji-picker controller" do
      render_inline(component)
      expect(rendered_content).to include('data-controller="emoji-picker"')
    end

    it "has insert mode enabled" do
      render_inline(component)
      expect(rendered_content).to include('data-emoji-picker-insert-mode-value="true"')
    end

    it "has target selector" do
      render_inline(component)
      expect(rendered_content).to include('data-emoji-picker-target-selector-value="#chat-message"')
    end

    it "renders textarea" do
      render_inline(component)
      expect(rendered_content).to include("<textarea")
      expect(rendered_content).to include('id="chat-message"')
      expect(rendered_content).to include("Type your message here...")
    end

    it "has textarea styling" do
      render_inline(component)
      expect(rendered_content).to include('class="form-control w-full mb-3 min-h-24 max-h-48"')
    end

    it "renders emoji button" do
      render_inline(component)
      expect(rendered_content).to include("emoji-picker#toggle")
      expect(rendered_content).to include('data-emoji-picker-target="button"')
    end

    it "renders send button" do
      render_inline(component)
      expect(rendered_content).to include('type="button"')
      expect(rendered_content).to include("Send")
    end

    it "renders picker container" do
      render_inline(component)
      expect(rendered_content).to include('data-emoji-picker-target="pickerContainer"')
    end

    it "has picker container with full width" do
      render_inline(component)
      expect(rendered_content).to include("*:w-full")
    end

    it "renders hidden input" do
      render_inline(component)
      expect(rendered_content).to include('name="emoji"')
      expect(rendered_content).to include("!hidden")
    end

    it "has card container styling" do
      render_inline(component)
      expect(rendered_content).to include("bg-white dark:bg-neutral-800")
      expect(rendered_content).to include("rounded-xl shadow-sm")
      expect(rendered_content).to include("border border-neutral-200 dark:border-neutral-700")
    end

    it "has emoji icon SVG with stroke" do
      render_inline(component)
      expect(rendered_content).to include("stroke=\"currentColor\"")
      expect(rendered_content).to include("fill=\"none\"")
    end

    it "accepts custom target selector" do
      component = ArtisansUi::EmojiPicker::InsertModeComponent.new(target_selector: "#custom-field")
      render_inline(component)
      expect(rendered_content).to include('data-emoji-picker-target-selector-value="#custom-field"')
      expect(rendered_content).to include('id="custom-field"')
    end

    it "has dark mode classes" do
      render_inline(component)
      expect(rendered_content).to include("dark:text-neutral-300")
      expect(rendered_content).to include("dark:hover:bg-neutral-700")
    end

    it "has button hover states" do
      render_inline(component)
      expect(rendered_content).to include("hover:bg-neutral-100")
      expect(rendered_content).to include("hover:bg-neutral-700")
    end
  end
end
