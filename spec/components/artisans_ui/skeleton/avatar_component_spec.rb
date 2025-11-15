# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Skeleton::AvatarComponent, type: :component do
  it "renders avatar skeleton with animate-pulse" do
    render_inline(described_class.new)

    expect(rendered_content).to include("animate-pulse")
    expect(rendered_content).to include("flex items-center")
    expect(rendered_content).to include("space-x-4")
    expect(rendered_content).to include("max-w-md")
  end

  it "renders circular avatar placeholder" do
    render_inline(described_class.new)

    expect(rendered_content).to include("rounded-full")
    expect(rendered_content).to include("h-10 w-10")
    expect(rendered_content).to include("bg-neutral-200")
    expect(rendered_content).to include("dark:bg-neutral-700")
  end

  it "renders two text lines with different heights" do
    render_inline(described_class.new)

    expect(rendered_content).to include("flex-1")
    expect(rendered_content).to include("space-y-2")
    expect(rendered_content).to include("h-4")
    expect(rendered_content).to include("h-3")
    expect(rendered_content).to include("w-3/4")
    expect(rendered_content).to include("w-1/2")
  end

  it "accepts custom html options" do
    render_inline(described_class.new(class: "custom-class"))

    expect(rendered_content).to include("custom-class")
  end
end
