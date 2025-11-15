# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Select::CustomRenderingComponent, type: :component do
  let(:options) do
    [
      {
        label: "Option 1",
        value: "1",
        subtitle: "First option description",
        image: "https://placehold.co/32x32/blue/white",
        badge: "New",
        meta: "Extra info 1"
      },
      {
        label: "Option 2",
        value: "2",
        subtitle: "Second option description",
        image: "https://placehold.co/32x32/red/white",
        badge: "Popular",
        meta: "Extra info 2"
      }
    ]
  end

  it "renders the select element" do
    render_inline(described_class.new(options: options))

    expect(rendered_content).to include("select")
    expect(rendered_content).to include('data-controller="artisans-ui--select"')
  end

  it "includes custom rendering data attribute" do
    render_inline(described_class.new(options: options))

    expect(rendered_content).to include('data-artisans-ui--select-custom-rendering-value="true"')
  end

  it "renders all options with labels and values" do
    render_inline(described_class.new(options: options))

    options.each do |opt|
      expect(rendered_content).to include(opt[:label])
      expect(rendered_content).to include(opt[:value])
    end
  end

  it "includes subtitle data attributes" do
    render_inline(described_class.new(options: options))

    options.each do |opt|
      expect(rendered_content).to include("data-subtitle=\"#{opt[:subtitle]}\"")
    end
  end

  it "includes image data attributes" do
    render_inline(described_class.new(options: options))

    options.each do |opt|
      expect(rendered_content).to include("data-image=\"#{opt[:image]}\"")
    end
  end

  it "includes badge data attributes" do
    render_inline(described_class.new(options: options))

    options.each do |opt|
      expect(rendered_content).to include("data-badge=\"#{opt[:badge]}\"")
    end
  end

  it "includes meta data attributes" do
    render_inline(described_class.new(options: options))

    options.each do |opt|
      expect(rendered_content).to include("data-meta=\"#{opt[:meta]}\"")
    end
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
