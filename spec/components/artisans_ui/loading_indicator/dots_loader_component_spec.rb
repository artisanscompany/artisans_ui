# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::LoadingIndicator::DotsLoaderComponent, type: :component do
  it "renders a div container with flex layout" do
    render_inline(described_class.new)

    expect(rendered_content).to include('<div')
    expect(rendered_content).to include('flex')
    expect(rendered_content).to include('space-x-1.5')
  end

  it "includes animation classes on dots" do
    render_inline(described_class.new)

    expect(rendered_content).to include('animate-bounce')
    expect(rendered_content).to include('rounded-full')
  end

  it "includes default size" do
    render_inline(described_class.new)

    expect(rendered_content).to include('size-1.5')
  end

  it "includes default color" do
    render_inline(described_class.new)

    expect(rendered_content).to include('bg-neutral-800')
    expect(rendered_content).to include('dark:bg-neutral-200')
  end

  it "accepts custom size" do
    render_inline(described_class.new(size: "size-2"))

    expect(rendered_content).to include('size-2')
  end

  it "accepts custom color" do
    render_inline(described_class.new(color: "bg-blue-600"))

    expect(rendered_content).to include('bg-blue-600')
  end

  it "accepts custom html_options" do
    render_inline(described_class.new(id: "custom-dots", data: { test: "value" }))

    expect(rendered_content).to include('id="custom-dots"')
    expect(rendered_content).to include('data-test="value"')
  end

  it "renders three dots with staggered animation delays" do
    render_inline(described_class.new)

    expect(rendered_content).to include('animation-delay: 0ms;')
    expect(rendered_content).to include('animation-delay: 150ms;')
    expect(rendered_content).to include('animation-delay: 300ms;')
  end

  it "renders dots with different opacities" do
    render_inline(described_class.new)

    # First dot: full opacity (no /80 or /60)
    # Second dot: 80% opacity
    expect(rendered_content).to include('/80')
    # Third dot: 60% opacity
    expect(rendered_content).to include('/60')
  end
end
