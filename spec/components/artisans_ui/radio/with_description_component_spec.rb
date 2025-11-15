# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Radio::WithDescriptionComponent, type: :component do
  it "renders radio group with descriptions" do
    render_inline(described_class.new)

    expect(rendered_content).to include('<fieldset')
    expect(rendered_content).to include('class="flex flex-col gap-4"')
    expect(rendered_content).to include('<legend')
    expect(rendered_content).to include('Select a subscription plan')
  end

  it "renders all three plan options" do
    render_inline(described_class.new)

    expect(rendered_content).to include('value="free"')
    expect(rendered_content).to include('value="pro"')
    expect(rendered_content).to include('value="enterprise"')
  end

  it "renders plan labels" do
    render_inline(described_class.new)

    expect(rendered_content).to include('Free')
    expect(rendered_content).to include('Pro')
    expect(rendered_content).to include('Enterprise')
  end

  it "renders plan descriptions" do
    render_inline(described_class.new)

    expect(rendered_content).to include('Perfect for personal projects and testing')
    expect(rendered_content).to include('Great for professionals and small teams')
    expect(rendered_content).to include('Advanced features for large organizations')
  end

  it "has Free plan checked by default" do
    render_inline(described_class.new)

    expect(rendered_content).to include('id="plan_free"')
    expect(rendered_content).to include('checked')
  end

  it "uses mt-1 for radio input alignment" do
    render_inline(described_class.new)

    expect(rendered_content).to include('class="mt-1"')
  end

  it "applies proper styling to descriptions" do
    render_inline(described_class.new)

    expect(rendered_content).to include('text-xs text-neutral-500')
  end

  it "uses proper name attribute for all radios" do
    render_inline(described_class.new)

    expect(rendered_content).to include('name="plan"')
  end

  it "uses gap-4 for spacing" do
    render_inline(described_class.new)

    expect(rendered_content).to include('gap-4')
  end
end
