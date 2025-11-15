# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Skeleton::BasicComponent, type: :component do
  it "renders basic skeleton with animate-pulse" do
    render_inline(described_class.new)

    expect(rendered_content).to include("animate-pulse")
    expect(rendered_content).to include("max-w-md")
    expect(rendered_content).to include("bg-neutral-200")
    expect(rendered_content).to include("dark:bg-neutral-700")
    expect(rendered_content).to include("w-full")
    expect(rendered_content).to include("w-1/2")
  end

  it "renders two skeleton lines with correct heights" do
    render_inline(described_class.new)

    expect(rendered_content).to include("h-4")
    expect(rendered_content).to include("rounded")
    expect(rendered_content).to include("mb-2")
  end

  it "accepts custom html options" do
    render_inline(described_class.new(id: "custom-skeleton", data: { testid: "skeleton" }))

    expect(rendered_content).to include('id="custom-skeleton"')
    expect(rendered_content).to include('data-testid="skeleton"')
  end
end
