# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Select::WithInfiniteScrollComponent, type: :component do
  let(:options) do
    (1..100).map do |i|
      { label: "Option #{i}", value: i.to_s }
    end
  end

  it "renders the select element" do
    render_inline(described_class.new(options: options))

    expect(rendered_content).to include("select")
    expect(rendered_content).to include('data-controller="artisans-ui--select"')
  end

  it "includes virtual scroll data attribute when enabled" do
    render_inline(described_class.new(options: options, virtual_scroll: true))

    expect(rendered_content).to include('data-artisans-ui--select-virtual-scroll-value="true"')
  end

  it "includes virtual scroll data attribute when disabled" do
    render_inline(described_class.new(options: options, virtual_scroll: false))

    expect(rendered_content).to include('data-artisans-ui--select-virtual-scroll-value="false"')
  end

  it "renders all options" do
    render_inline(described_class.new(options: options.take(5)))

    options.take(5).each do |opt|
      expect(rendered_content).to include(opt[:label])
      expect(rendered_content).to include(opt[:value])
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

  it "defaults to virtual_scroll true" do
    render_inline(described_class.new(options: options))

    expect(rendered_content).to include('data-artisans-ui--select-virtual-scroll-value="true"')
  end
end
