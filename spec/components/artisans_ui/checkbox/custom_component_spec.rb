# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Checkbox::CustomComponent, type: :component do
  it "renders custom checkbox with label" do
    render_inline(described_class.new(
      label: "I agree to the terms",
      name: "agreement",
      value: "terms"
    ))

    expect(rendered_content).to include("I agree to the terms")
    expect(rendered_content).to include('type="checkbox"')
    expect(rendered_content).to include('name="agreement"')
    expect(rendered_content).to include('value="terms"')
  end

  it "renders checkbox with peer hidden classes" do
    render_inline(described_class.new(
      label: "Test",
      name: "test"
    ))

    expect(rendered_content).to include('class="peer hidden"')
  end

  it "renders icon span with transition classes" do
    render_inline(described_class.new(
      label: "Test",
      name: "test"
    ))

    expect(rendered_content).to include("transition-all duration-200")
    expect(rendered_content).to include("size-0")
    expect(rendered_content).to include("rounded-full")
  end

  it "includes peer-checked classes for animation" do
    render_inline(described_class.new(
      label: "Test",
      name: "test"
    ))

    expect(rendered_content).to include("peer-checked:me-1.5")
    expect(rendered_content).to include("peer-checked:size-4")
    expect(rendered_content).to include("peer-checked:text-white")
  end

  it "renders SVG checkmark icon" do
    render_inline(described_class.new(
      label: "Test",
      name: "test"
    ))

    expect(rendered_content).to include("<svg")
    expect(rendered_content).to include('xmlns="http://www.w3.org/2000/svg"')
    expect(rendered_content).to include('viewBox="0 0 12 12"')
    expect(rendered_content).to include("size-2.5 shrink-0")
  end

  it "renders SVG path element" do
    render_inline(described_class.new(
      label: "Test",
      name: "test"
    ))

    expect(rendered_content).to include("<path")
    expect(rendered_content).to include("m1.75,6c1.047,1.048,1.803,2.153,2.461,3.579,1.524-3.076,3.659-5.397,6.039-7.158")
  end

  it "renders checked state" do
    render_inline(described_class.new(
      label: "Subscribe",
      name: "subscription",
      checked: true
    ))

    expect(rendered_content).to include("checked")
    expect(rendered_content).to include("Subscribe")
  end

  it "associates label with input via for/id attributes" do
    render_inline(described_class.new(
      label: "Test Label",
      name: "test",
      id: "custom-checkbox-id"
    ))

    expect(rendered_content).to include('id="custom-checkbox-id"')
    expect(rendered_content).to include('for="custom-checkbox-id"')
  end

  it "auto-generates ID when not provided" do
    render_inline(described_class.new(
      label: "Auto ID",
      name: "test"
    ))

    expect(rendered_content).to match(/id="checkbox_[a-f0-9]+"/)
    expect(rendered_content).to match(/for="checkbox_[a-f0-9]+"/)
  end

  it "includes dark mode classes for label wrapper" do
    render_inline(described_class.new(
      label: "Dark Mode",
      name: "test"
    ))

    expect(rendered_content).to include("dark:bg-neutral-700/50")
    expect(rendered_content).to include("dark:text-neutral-200")
    expect(rendered_content).to include("dark:ring-neutral-700")
    expect(rendered_content).to include("dark:has-[:checked]:bg-neutral-600/60")
    expect(rendered_content).to include("dark:has-[:checked]:text-white")
  end

  it "includes dark mode classes for animated icon" do
    render_inline(described_class.new(
      label: "Icon Dark Mode",
      name: "test"
    ))

    expect(rendered_content).to include("dark:bg-neutral-50")
    expect(rendered_content).to include("dark:peer-checked:text-neutral-800")
  end

  it "renders label text in span with block class" do
    render_inline(described_class.new(
      label: "Block Label",
      name: "test"
    ))

    expect(rendered_content).to include('<span class="block">Block Label</span>')
  end
end
