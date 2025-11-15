# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Button::GroupComponent, type: :component do
  it "renders a button group wrapper" do
    render_inline(described_class.new) do |group|
      group.with_button { "Button 1" }
    end

    expect(rendered_content).to include("Button 1")
  end

  it "renders multiple buttons in the group" do
    render_inline(described_class.new) do |group|
      group.with_button { "First" }
      group.with_button { "Second" }
      group.with_button { "Third" }
    end

    expect(rendered_content).to include("First")
    expect(rendered_content).to include("Second")
    expect(rendered_content).to include("Third")
  end

  it "includes inline-flex classes" do
    render_inline(described_class.new) do |group|
      group.with_button { "Button" }
    end

    expect(rendered_content).to include("inline-flex")
  end

  it "includes negative space classes for overlapping borders" do
    render_inline(described_class.new) do |group|
      group.with_button { "Button" }
    end

    expect(rendered_content).to include("-space-x-px")
  end

  it "includes rounded-lg base class" do
    render_inline(described_class.new) do |group|
      group.with_button { "Button" }
    end

    expect(rendered_content).to include("rounded-lg")
  end

  it "includes shadow-sm class" do
    render_inline(described_class.new) do |group|
      group.with_button { "Button" }
    end

    expect(rendered_content).to include("shadow-sm")
  end

  it "includes first-child rounding classes" do
    render_inline(described_class.new) do |group|
      group.with_button { "Button" }
    end

    expect(rendered_content).to include("first-child")
    expect(rendered_content).to include("rounded-l-lg")
  end

  it "includes last-child rounding classes" do
    render_inline(described_class.new) do |group|
      group.with_button { "Button" }
    end

    expect(rendered_content).to include("last-child")
    expect(rendered_content).to include("rounded-r-lg")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(
      id: "button-group",
      data: { controller: "group" },
      class: "custom-group"
    )) do |group|
      group.with_button { "Button" }
    end

    expect(rendered_content).to include('id="button-group"')
    expect(rendered_content).to include('data-controller="group"')
    expect(rendered_content).to include("custom-group")
  end

  it "can contain different types of button content" do
    render_inline(described_class.new) do |group|
      group.with_button { '<button class="bg-neutral-800">First</button>'.html_safe }
      group.with_button { '<button class="bg-blue-600">Second</button>'.html_safe }
    end

    expect(rendered_content).to include("First")
    expect(rendered_content).to include("Second")
    expect(rendered_content).to include("bg-neutral-800")
    expect(rendered_content).to include("bg-blue-600")
  end
end
