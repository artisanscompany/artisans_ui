# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Skeleton::TableComponent, type: :component do
  it "renders table skeleton with animate-pulse" do
    render_inline(described_class.new)

    expect(rendered_content).to include("animate-pulse")
    expect(rendered_content).to include("w-full")
  end

  it "renders header row with background" do
    render_inline(described_class.new)

    expect(rendered_content).to include("bg-neutral-50")
    expect(rendered_content).to include("dark:bg-neutral-800")
    expect(rendered_content).to include("rounded-t-lg")
  end

  it "renders four columns in header" do
    render_inline(described_class.new)

    expect(rendered_content).to include("flex space-x-4")
    expect(rendered_content).to include("w-1/4")
  end

  it "renders divided rows" do
    render_inline(described_class.new)

    expect(rendered_content).to include("divide-y")
    expect(rendered_content).to include("divide-neutral-200")
    expect(rendered_content).to include("dark:divide-neutral-700")
  end

  it "renders five data rows" do
    render_inline(described_class.new)

    # Count occurrences of row structure - should have 5 data rows plus 1 header
    row_count = rendered_content.scan(/flex space-x-4/).length
    expect(row_count).to eq(6) # 1 header + 5 data rows
  end

  it "renders skeleton bars with correct styling" do
    render_inline(described_class.new)

    expect(rendered_content).to include("h-4")
    expect(rendered_content).to include("bg-neutral-200")
    expect(rendered_content).to include("dark:bg-neutral-700")
    expect(rendered_content).to include("rounded")
  end

  it "accepts custom html options" do
    render_inline(described_class.new(id: "table-skeleton"))

    expect(rendered_content).to include('id="table-skeleton"')
  end
end
