# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Form::SearchInputComponent, type: :component do
  it "renders a search input with icon by default" do
    render_inline(described_class.new(name: :q))
    expect(rendered_content).to include('type="search"')
    expect(rendered_content).to include('<svg')
  end

  it "renders without icon when icon: false" do
    render_inline(described_class.new(icon: false, name: :q))
    expect(rendered_content).to include('type="search"')
    expect(rendered_content).not_to include('<svg')
  end

  it "includes icon padding when icon is shown" do
    render_inline(described_class.new(name: :q))
    expect(rendered_content).to include("pl-11")
  end

  it "includes regular padding when no icon" do
    render_inline(described_class.new(icon: false, name: :q))
    expect(rendered_content).to include("px-4")
  end

  it "accepts custom classes" do
    render_inline(described_class.new(name: :q, class: "!focus:ring-blue-500"))
    expect(rendered_content).to include("!focus:ring-blue-500")
  end

  it "supports dark mode" do
    render_inline(described_class.new(name: :q))
    expect(rendered_content).to include("dark:bg-neutral-900")
  end
end
