# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Skeleton::ListComponent, type: :component do
  it "renders list skeleton with animate-pulse" do
    render_inline(described_class.new)

    expect(rendered_content).to include("animate-pulse")
    expect(rendered_content).to include("max-w-md")
    expect(rendered_content).to include("space-y-4")
  end

  it "renders four list items" do
    render_inline(described_class.new)

    # Count list items by counting the avatar circles
    avatar_count = rendered_content.scan(/h-12 w-12/).length
    expect(avatar_count).to eq(4)
  end

  it "renders list items with flex layout" do
    render_inline(described_class.new)

    expect(rendered_content).to include("flex items-center")
    expect(rendered_content).to include("space-x-4")
  end

  it "renders circular avatars" do
    render_inline(described_class.new)

    expect(rendered_content).to include("rounded-full")
    expect(rendered_content).to include("h-12 w-12")
  end

  it "renders content area with two lines" do
    render_inline(described_class.new)

    expect(rendered_content).to include("flex-1 min-w-0")
    expect(rendered_content).to include("space-y-2")
    expect(rendered_content).to include("h-4")
    expect(rendered_content).to include("h-3")
    expect(rendered_content).to include("w-3/4")
    expect(rendered_content).to include("w-1/2")
  end

  it "renders action icons" do
    render_inline(described_class.new)

    expect(rendered_content).to include("h-6 w-6")
  end

  it "includes proper skeleton styling" do
    render_inline(described_class.new)

    expect(rendered_content).to include("bg-neutral-200")
    expect(rendered_content).to include("dark:bg-neutral-700")
    expect(rendered_content).to include("rounded")
  end

  it "accepts custom html options" do
    render_inline(described_class.new(id: "list-skeleton"))

    expect(rendered_content).to include('id="list-skeleton"')
  end
end
