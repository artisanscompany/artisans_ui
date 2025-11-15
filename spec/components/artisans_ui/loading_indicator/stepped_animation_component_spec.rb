# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::LoadingIndicator::SteppedAnimationComponent, type: :component do
  it "renders the SVG spinner" do
    render_inline(described_class.new)

    expect(rendered_content).to include('<svg')
    expect(rendered_content).to include('xmlns="http://www.w3.org/2000/svg"')
  end

  it "includes animation classes" do
    render_inline(described_class.new)

    expect(rendered_content).to include('animate-spin')
    expect(rendered_content).to include('rounded-full')
  end

  it "includes stepped animation timing function" do
    render_inline(described_class.new)

    expect(rendered_content).to include('[animation-timing-function:steps(8)]')
    expect(rendered_content).to include('[animation-duration:0.8s]')
  end

  it "includes default size" do
    render_inline(described_class.new)

    expect(rendered_content).to include('size-8')
  end

  it "accepts custom size" do
    render_inline(described_class.new(size: "size-12"))

    expect(rendered_content).to include('size-12')
  end

  it "accepts custom html_options" do
    render_inline(described_class.new(id: "custom-loader", data: { test: "value" }))

    expect(rendered_content).to include('id="custom-loader"')
    expect(rendered_content).to include('data-test="value"')
  end

  it "includes the correct SVG structure with 8 lines" do
    render_inline(described_class.new)

    expect(rendered_content).to include('<g')
    expect(rendered_content).to include('stroke="currentColor"')
    expect(rendered_content).to include('<line')
    # Count should have 8 line elements
    expect(rendered_content.scan(/<line/).length).to eq(8)
  end

  it "includes varying opacities on the lines" do
    render_inline(described_class.new)

    expect(rendered_content).to include('opacity=".13"')
    expect(rendered_content).to include('opacity=".25"')
    expect(rendered_content).to include('opacity=".88"')
  end
end
