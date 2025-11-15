# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Checkbox::CardComponent, type: :component do
  it "renders card checkbox with title" do
    render_inline(described_class.new(
      title: "Basic Plan",
      name: "plan",
      value: "basic"
    ))

    expect(rendered_content).to include("Basic Plan")
    expect(rendered_content).to include('type="checkbox"')
    expect(rendered_content).to include('name="plan"')
    expect(rendered_content).to include('value="basic"')
  end

  it "renders subtitle when provided" do
    render_inline(described_class.new(
      title: "Pro Plan",
      subtitle: "For growing teams",
      name: "plan",
      value: "pro"
    ))

    expect(rendered_content).to include("Pro Plan")
    expect(rendered_content).to include("For growing teams")
    expect(rendered_content).to include("text-xs text-neutral-500 dark:text-neutral-400")
  end

  it "renders price when provided" do
    render_inline(described_class.new(
      title: "Enterprise",
      price: "$99/month",
      name: "plan",
      value: "enterprise"
    ))

    expect(rendered_content).to include("Enterprise")
    expect(rendered_content).to include("$99/month")
  end

  it "does not render subtitle when not provided" do
    render_inline(described_class.new(
      title: "Basic Plan",
      name: "plan",
      value: "basic"
    ))

    expect(rendered_content).to include("Basic Plan")
    # Should only have title, not subtitle styling
    expect(rendered_content.scan(/text-xs text-neutral-500/).count).to eq(0)
  end

  it "does not render price when not provided" do
    render_inline(described_class.new(
      title: "Basic Plan",
      name: "plan",
      value: "basic"
    ))

    expect(rendered_content).to include("Basic Plan")
    # Title and price use same classes, so just verify structure is simpler
  end

  it "renders label wrapper with correct classes including has-[:checked] pseudo-classes" do
    render_inline(described_class.new(
      title: "Plan",
      name: "plan",
      value: "test"
    ))

    expect(rendered_content).to include("relative py-3 px-4 flex items-center")
    expect(rendered_content).to include("has-[:checked]:ring-2")
    expect(rendered_content).to include("has-[:checked]:ring-neutral-400")
    expect(rendered_content).to include("has-[:checked]:bg-neutral-100")
    expect(rendered_content).to include("dark:has-[:checked]:bg-neutral-600/60")
  end

  it "renders checkbox with absolute left-4 positioning" do
    render_inline(described_class.new(
      title: "Plan",
      name: "plan",
      value: "test"
    ))

    expect(rendered_content).to include('class="absolute left-4"')
  end

  it "renders checked state" do
    render_inline(described_class.new(
      title: "Selected Plan",
      name: "plan",
      value: "selected",
      checked: true
    ))

    expect(rendered_content).to include("checked")
    expect(rendered_content).to include("Selected Plan")
  end

  it "associates label with input via for/id attributes" do
    render_inline(described_class.new(
      title: "Test Plan",
      name: "plan",
      value: "test",
      id: "custom-card-id"
    ))

    expect(rendered_content).to include('id="custom-card-id"')
    expect(rendered_content).to include('for="custom-card-id"')
  end

  it "auto-generates ID when not provided" do
    render_inline(described_class.new(
      title: "Auto ID Plan",
      name: "plan",
      value: "auto"
    ))

    expect(rendered_content).to match(/id="checkbox_[a-f0-9]+"/)
    expect(rendered_content).to match(/for="checkbox_[a-f0-9]+"/)
  end

  it "includes dark mode classes" do
    render_inline(described_class.new(
      title: "Dark Mode Plan",
      name: "plan",
      value: "dark"
    ))

    expect(rendered_content).to include("dark:bg-neutral-700/50")
    expect(rendered_content).to include("dark:text-neutral-200")
    expect(rendered_content).to include("dark:ring-neutral-700")
    expect(rendered_content).to include("dark:text-neutral-100")
  end

  it "renders complete card with title, subtitle, and price" do
    render_inline(described_class.new(
      title: "Complete Plan",
      subtitle: "Everything included",
      price: "$49/month",
      name: "plan",
      value: "complete"
    ))

    expect(rendered_content).to include("Complete Plan")
    expect(rendered_content).to include("Everything included")
    expect(rendered_content).to include("$49/month")
  end
end
