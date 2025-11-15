# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Skeleton::FormComponent, type: :component do
  it "renders form skeleton with animate-pulse" do
    render_inline(described_class.new)

    expect(rendered_content).to include("animate-pulse")
    expect(rendered_content).to include("max-w-md")
    expect(rendered_content).to include("space-y-6")
  end

  it "renders three form groups" do
    render_inline(described_class.new)

    expect(rendered_content).to include("space-y-2")
    # Should have 3 form groups with space-y-2
    form_group_count = rendered_content.scan(/space-y-2/).length
    expect(form_group_count).to eq(3)
  end

  it "renders labels with different widths" do
    render_inline(described_class.new)

    expect(rendered_content).to include("w-20")
    expect(rendered_content).to include("w-24")
    expect(rendered_content).to include("w-32")
  end

  it "renders input fields with correct heights" do
    render_inline(described_class.new)

    expect(rendered_content).to include("h-10")
    expect(rendered_content).to include("h-24")
  end

  it "renders checkbox with label" do
    render_inline(described_class.new)

    expect(rendered_content).to include("flex items-center space-x-2")
    expect(rendered_content).to include("h-4 w-4")
  end

  it "renders two buttons" do
    render_inline(described_class.new)

    expect(rendered_content).to include("flex space-x-4")
    # Count h-10 elements that are buttons (in the last flex container)
    expect(rendered_content).to include("w-24")
  end

  it "includes proper skeleton styling" do
    render_inline(described_class.new)

    expect(rendered_content).to include("bg-neutral-200")
    expect(rendered_content).to include("dark:bg-neutral-700")
    expect(rendered_content).to include("rounded")
  end

  it "accepts custom html options" do
    render_inline(described_class.new(id: "form-skeleton"))

    expect(rendered_content).to include('id="form-skeleton"')
  end
end
