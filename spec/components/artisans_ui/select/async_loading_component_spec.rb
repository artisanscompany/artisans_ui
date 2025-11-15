# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Select::AsyncLoadingComponent, type: :component do
  let(:url) { "/api/items" }

  it "renders the select element" do
    render_inline(described_class.new(url: url))

    expect(rendered_content).to include("select")
    expect(rendered_content).to include('data-controller="artisans-ui--select"')
  end

  it "includes URL data attribute" do
    render_inline(described_class.new(url: url))

    expect(rendered_content).to include('data-artisans-ui--select-url-value="/api/items"')
  end

  it "renders placeholder option" do
    render_inline(described_class.new(url: url, placeholder: "Select an item..."))

    expect(rendered_content).to include("Select an item...")
    expect(rendered_content).to include("disabled")
    expect(rendered_content).to include("selected")
  end

  it "uses default placeholder" do
    render_inline(described_class.new(url: url))

    expect(rendered_content).to include("Select...")
  end

  it "applies correct styling classes" do
    render_inline(described_class.new(url: url))

    expect(rendered_content).to include("rounded-lg border border-neutral-300")
    expect(rendered_content).to include("focus:border-primary-500")
  end

  it "accepts custom html_options" do
    render_inline(described_class.new(url: url, id: "custom-select", data: { test: "value" }))

    expect(rendered_content).to include('id="custom-select"')
    expect(rendered_content).to include('data-test="value"')
  end

  it "renders with container wrapper" do
    render_inline(described_class.new(url: url))

    expect(rendered_content).to include("relative w-full max-w-xs")
  end
end
