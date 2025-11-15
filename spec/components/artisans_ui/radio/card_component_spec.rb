# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Radio::CardComponent, type: :component do
  it "renders card-style radio group" do
    render_inline(described_class.new)

    expect(rendered_content).to include('<fieldset')
    expect(rendered_content).to include('class="flex flex-col gap-4"')
    expect(rendered_content).to include('<legend')
    expect(rendered_content).to include('Choose a pricing plan')
  end

  it "renders all three pricing options" do
    render_inline(described_class.new)

    expect(rendered_content).to include('value="starter"')
    expect(rendered_content).to include('value="professional"')
    expect(rendered_content).to include('value="business"')
  end

  it "renders plan titles" do
    render_inline(described_class.new)

    expect(rendered_content).to include('Starter')
    expect(rendered_content).to include('Professional')
    expect(rendered_content).to include('Business')
  end

  it "renders pricing information" do
    render_inline(described_class.new)

    expect(rendered_content).to include('$10/month')
    expect(rendered_content).to include('$30/month')
    expect(rendered_content).to include('$100/month')
  end

  it "renders plan descriptions" do
    render_inline(described_class.new)

    expect(rendered_content).to include('Perfect for individuals')
    expect(rendered_content).to include('Best for small teams')
    expect(rendered_content).to include('For growing companies')
  end

  it "has Professional plan checked by default" do
    render_inline(described_class.new)

    expect(rendered_content).to include('id="pricing_professional"')
    expect(rendered_content).to include('checked')
  end

  it "uses card styling with rounded-xl" do
    render_inline(described_class.new)

    expect(rendered_content).to include('rounded-xl')
  end

  it "uses has-[:checked]:ring-2 for checked state" do
    render_inline(described_class.new)

    expect(rendered_content).to include('has-[:checked]:ring-2')
    expect(rendered_content).to include('has-[:checked]:ring-neutral-400')
  end

  it "uses absolute positioning for radio input" do
    render_inline(described_class.new)

    expect(rendered_content).to include('absolute left-4')
  end

  it "uses ml-8 for content offset" do
    render_inline(described_class.new)

    expect(rendered_content).to include('ml-8')
  end

  it "uses proper name attribute for all radios" do
    render_inline(described_class.new)

    expect(rendered_content).to include('name="pricing"')
  end

  it "applies border styling to cards" do
    render_inline(described_class.new)

    expect(rendered_content).to include('border-neutral-200')
    expect(rendered_content).to include('dark:border-neutral-700')
  end
end
