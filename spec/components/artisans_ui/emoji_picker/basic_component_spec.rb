# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::EmojiPicker::BasicComponent, type: :component do
  it "renders the emoji picker controller" do
    render_inline(described_class.new(name: "emoji"))

    expect(rendered_content).to include('data-controller="artisans-ui--emoji-picker"')
  end

  it "renders the toggle button" do
    render_inline(described_class.new(name: "emoji"))

    expect(rendered_content).to include('data-action="click-&gt;artisans-ui--emoji-picker#toggle"')
    expect(rendered_content).to include('data-artisans-ui--emoji-picker-target="button"')
  end

  it "renders hidden input with correct name" do
    render_inline(described_class.new(name: "reaction"))

    expect(rendered_content).to include('name="reaction"')
    expect(rendered_content).to include('data-artisans-ui--emoji-picker-target="input"')
  end

  it "renders picker container" do
    render_inline(described_class.new(name: "emoji"))

    expect(rendered_content).to include('data-artisans-ui--emoji-picker-target="pickerContainer"')
  end

  it "shows default emoji icon when no value" do
    render_inline(described_class.new(name: "emoji"))

    expect(rendered_content).to include('<svg')
  end

  it "shows selected emoji when value provided" do
    render_inline(described_class.new(name: "emoji", value: "😀"))

    expect(rendered_content).to include("😀")
  end

  it "accepts custom html_options" do
    render_inline(described_class.new(name: "emoji", id: "custom-picker", data: { test: "value" }))

    expect(rendered_content).to include('id="custom-picker"')
    expect(rendered_content).to include('data-test="value"')
  end
end
