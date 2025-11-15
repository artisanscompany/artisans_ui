# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::LoadingIndicator::CircularSpinnerComponent, type: :component do
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

  it "includes default size" do
    render_inline(described_class.new)

    expect(rendered_content).to include('size-8')
  end

  it "includes default color" do
    render_inline(described_class.new)

    expect(rendered_content).to include('text-neutral-800')
    expect(rendered_content).to include('dark:text-neutral-200')
  end

  it "accepts custom size" do
    render_inline(described_class.new(size: "size-12"))

    expect(rendered_content).to include('size-12')
  end

  it "accepts custom color" do
    render_inline(described_class.new(color: "text-blue-600"))

    expect(rendered_content).to include('text-blue-600')
  end

  it "accepts custom html_options" do
    render_inline(described_class.new(id: "custom-spinner", data: { test: "value" }))

    expect(rendered_content).to include('id="custom-spinner"')
    expect(rendered_content).to include('data-test="value"')
  end

  it "includes the correct SVG structure with paths" do
    render_inline(described_class.new)

    expect(rendered_content).to include('<g')
    expect(rendered_content).to include('fill="currentColor"')
    expect(rendered_content).to include('<path')
    expect(rendered_content).to include('opacity=".4"')
  end
end
