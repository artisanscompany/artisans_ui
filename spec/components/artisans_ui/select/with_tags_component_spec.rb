# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Select::WithTagsComponent, type: :component do
  let(:options) do
    [
      { label: "Option 1", value: "1" },
      { label: "Option 2", value: "2" },
      { label: "Option 3", value: "3" }
    ]
  end

  it "renders the select element" do
    render_inline(described_class.new(options: options))

    expect(rendered_content).to include("select")
    expect(rendered_content).to include('data-controller="artisans-ui--select"')
  end

  it "includes tags position data attribute" do
    render_inline(described_class.new(options: options, tags_position: "below"))

    expect(rendered_content).to include('data-artisans-ui--select-tags-position-value="below"')
  end

  it "renders all options" do
    render_inline(described_class.new(options: options))

    options.each do |opt|
      expect(rendered_content).to include(opt[:label])
      expect(rendered_content).to include(opt[:value])
    end
  end

  it "renders tags container below when position is below" do
    render_inline(described_class.new(options: options, tags_position: "below"))

    expect(rendered_content).to include('data-artisans-ui--select-target="tagsContainer"')
    expect(rendered_content).to include("mt-2 flex flex-wrap gap-2")
  end

  it "renders tags container above when position is above" do
    render_inline(described_class.new(options: options, tags_position: "above"))

    expect(rendered_content).to include('data-artisans-ui--select-target="tagsContainer"')
    expect(rendered_content).to include("mb-2 flex flex-wrap gap-2")
  end

  it "applies correct styling classes" do
    render_inline(described_class.new(options: options))

    expect(rendered_content).to include("rounded-lg border border-neutral-300")
    expect(rendered_content).to include("focus:border-primary-500")
  end

  it "accepts custom html_options" do
    render_inline(described_class.new(options: options, id: "custom-select", data: { test: "value" }))

    expect(rendered_content).to include('id="custom-select"')
    expect(rendered_content).to include('data-test="value"')
  end
end
