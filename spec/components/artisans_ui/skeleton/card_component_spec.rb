# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Skeleton::CardComponent, type: :component do
  it "renders card skeleton with animate-pulse" do
    render_inline(described_class.new)

    expect(rendered_content).to include("animate-pulse")
    expect(rendered_content).to include("border")
    expect(rendered_content).to include("border-neutral-200")
    expect(rendered_content).to include("dark:border-neutral-700")
    expect(rendered_content).to include("rounded-xl")
    expect(rendered_content).to include("shadow-xs")
    expect(rendered_content).to include("max-w-md")
  end

  it "renders image placeholder with correct height" do
    render_inline(described_class.new)

    expect(rendered_content).to include("h-48")
    expect(rendered_content).to include("rounded-lg")
  end

  it "renders title skeleton" do
    render_inline(described_class.new)

    expect(rendered_content).to include("h-6")
    expect(rendered_content).to include("w-3/4")
  end

  it "renders three content lines" do
    render_inline(described_class.new)

    expect(rendered_content).to include("space-y-2")
    expect(rendered_content).to include("h-4")
    expect(rendered_content).to include("w-5/6")
    expect(rendered_content).to include("w-4/6")
  end

  it "renders footer with two items" do
    render_inline(described_class.new)

    expect(rendered_content).to include("flex items-center space-x-4")
    expect(rendered_content).to include("w-20")
  end

  it "accepts custom html options" do
    render_inline(described_class.new(id: "card-skeleton"))

    expect(rendered_content).to include('id="card-skeleton"')
  end
end
