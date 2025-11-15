# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::EmojiPicker::InsertModeComponent, type: :component do
  it "renders the emoji picker controller" do
    render_inline(described_class.new(target_field_id: "#message"))

    expect(rendered_content).to include('data-controller="artisans-ui--emoji-picker"')
  end

  it "renders with insert mode enabled" do
    render_inline(described_class.new(target_field_id: "#message"))

    expect(rendered_content).to include('data-artisans-ui--emoji-picker-insert-mode-value="true"')
  end

  it "renders with target selector" do
    render_inline(described_class.new(target_field_id: "#chat-input"))

    expect(rendered_content).to include('data-artisans-ui--emoji-picker-target-selector-value="#chat-input"')
  end

  it "renders the toggle button" do
    render_inline(described_class.new(target_field_id: "#message"))

    expect(rendered_content).to include('data-action="click-&gt;artisans-ui--emoji-picker#toggle"')
    expect(rendered_content).to include('data-artisans-ui--emoji-picker-target="button"')
  end

  it "renders picker container" do
    render_inline(described_class.new(target_field_id: "#message"))

    expect(rendered_content).to include('data-artisans-ui--emoji-picker-target="pickerContainer"')
  end

  it "shows emoji face icon for insert mode" do
    render_inline(described_class.new(target_field_id: "#message"))

    expect(rendered_content).to include('<svg')
  end

  it "does not render hidden input when name is not provided" do
    render_inline(described_class.new(target_field_id: "#message"))

    expect(rendered_content).not_to include('type="text"')
  end

  it "renders hidden input when name is provided" do
    render_inline(described_class.new(target_field_id: "#message", name: "emoji"))

    expect(rendered_content).to include('name="emoji"')
    expect(rendered_content).to include('data-artisans-ui--emoji-picker-target="input"')
  end

  it "accepts custom html_options" do
    render_inline(described_class.new(target_field_id: "#message", id: "custom-picker", data: { test: "value" }))

    expect(rendered_content).to include('id="custom-picker"')
    expect(rendered_content).to include('data-test="value"')
  end
end
