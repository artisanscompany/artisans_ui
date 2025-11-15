# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Checkbox::BasicComponent, type: :component do
  it "renders a basic checkbox with label" do
    render_inline(described_class.new(
      label: "I agree to the terms",
      name: "options",
      value: "option1"
    ))

    expect(rendered_content).to include("I agree to the terms")
    expect(rendered_content).to include('type="checkbox"')
    expect(rendered_content).to include('name="options"')
    expect(rendered_content).to include('value="option1"')
  end

  it "renders with flex container and gap" do
    render_inline(described_class.new(
      label: "Test",
      name: "test"
    ))

    expect(rendered_content).to include("flex items-center gap-2")
  end

  it "renders checked checkbox" do
    render_inline(described_class.new(
      label: "Subscribe",
      name: "options",
      checked: true
    ))

    expect(rendered_content).to include("checked")
    expect(rendered_content).to include("Subscribe")
  end

  it "renders disabled checkbox with appropriate label styling" do
    render_inline(described_class.new(
      label: "Disabled option",
      name: "options",
      disabled: true
    ))

    expect(rendered_content).to include("disabled")
    expect(rendered_content).to include("text-neutral-400")
    expect(rendered_content).to include("cursor-not-allowed")
    expect(rendered_content).to include("opacity-50")
  end

  it "associates label with input via for/id attributes" do
    render_inline(described_class.new(
      label: "Test Label",
      name: "test",
      id: "custom-id"
    ))

    expect(rendered_content).to include('id="custom-id"')
    expect(rendered_content).to include('for="custom-id"')
  end

  it "auto-generates ID when not provided" do
    render_inline(described_class.new(
      label: "Auto ID",
      name: "test"
    ))

    expect(rendered_content).to match(/id="checkbox_[a-f0-9]+"/)
    expect(rendered_content).to match(/for="checkbox_[a-f0-9]+"/)
  end

  it "includes dark mode classes for label" do
    render_inline(described_class.new(
      label: "Dark Mode",
      name: "test"
    ))

    expect(rendered_content).to include("dark:text-neutral-300")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(
      label: "Custom",
      name: "test",
      class: "extra-class",
      data: { action: "click->controller#action" }
    ))

    expect(rendered_content).to include("extra-class")
    expect(rendered_content).to include('data-action="click-&gt;controller#action"')
  end

  it "renders without value attribute if not provided" do
    render_inline(described_class.new(
      label: "No Value",
      name: "test"
    ))

    expect(rendered_content).to include("No Value")
    expect(rendered_content).to include('name="test"')
    # Should not have value attribute when nil
    expect(rendered_content).not_to include('value=""')
  end
end
