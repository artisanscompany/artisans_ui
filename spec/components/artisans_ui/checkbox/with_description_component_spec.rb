# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Checkbox::WithDescriptionComponent, type: :component do
  it "renders checkbox with label and description" do
    render_inline(described_class.new(
      label: "Email notifications",
      description: "Receive email updates about your account activity",
      name: "notifications",
      value: "email"
    ))

    expect(rendered_content).to include("Email notifications")
    expect(rendered_content).to include("Receive email updates about your account activity")
    expect(rendered_content).to include('type="checkbox"')
    expect(rendered_content).to include('name="notifications"')
    expect(rendered_content).to include('value="email"')
  end

  it "renders checkbox with mt-1 class for top alignment" do
    render_inline(described_class.new(
      label: "Test Label",
      description: "Test description",
      name: "test"
    ))

    expect(rendered_content).to include('class="mt-1"')
  end

  it "renders with flex items-start gap-3 layout" do
    render_inline(described_class.new(
      label: "Test",
      description: "Description",
      name: "test"
    ))

    expect(rendered_content).to include("flex items-start gap-3")
  end

  it "renders label with correct classes" do
    render_inline(described_class.new(
      label: "Label Text",
      description: "Description text",
      name: "test"
    ))

    expect(rendered_content).to include("block text-sm font-medium text-neutral-700 dark:text-neutral-300")
  end

  it "renders description with correct classes" do
    render_inline(described_class.new(
      label: "Label",
      description: "Description text here",
      name: "test"
    ))

    expect(rendered_content).to include("text-xs text-neutral-500 dark:text-neutral-400 mt-1")
  end

  it "renders checked checkbox" do
    render_inline(described_class.new(
      label: "Marketing emails",
      description: "Get the latest news and updates",
      name: "notifications",
      checked: true
    ))

    expect(rendered_content).to include("checked")
    expect(rendered_content).to include("Marketing emails")
  end

  it "renders disabled checkbox" do
    render_inline(described_class.new(
      label: "SMS notifications",
      description: "Not available in your region",
      name: "notifications",
      disabled: true
    ))

    expect(rendered_content).to include("disabled")
    expect(rendered_content).to include("SMS notifications")
  end

  it "associates label with input via for/id attributes" do
    render_inline(described_class.new(
      label: "Test Label",
      description: "Test description",
      name: "test",
      id: "custom-id"
    ))

    expect(rendered_content).to include('id="custom-id"')
    expect(rendered_content).to include('for="custom-id"')
  end

  it "auto-generates ID when not provided" do
    render_inline(described_class.new(
      label: "Auto ID",
      description: "Auto description",
      name: "test"
    ))

    expect(rendered_content).to match(/id="checkbox_[a-f0-9]+"/)
    expect(rendered_content).to match(/for="checkbox_[a-f0-9]+"/)
  end

  it "includes dark mode classes" do
    render_inline(described_class.new(
      label: "Dark Mode",
      description: "Dark mode description",
      name: "test"
    ))

    expect(rendered_content).to include("dark:text-neutral-300")
    expect(rendered_content).to include("dark:text-neutral-400")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(
      label: "Custom",
      description: "Custom description",
      name: "test",
      class: "extra-class",
      data: { action: "click->controller#action" }
    ))

    expect(rendered_content).to include("extra-class")
    expect(rendered_content).to include('data-action="click-&gt;controller#action"')
  end
end
