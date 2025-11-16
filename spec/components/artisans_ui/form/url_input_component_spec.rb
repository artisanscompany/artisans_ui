# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Form::UrlInputComponent, type: :component do
  it "renders a url input" do
    render_inline(described_class.new)
    expect(rendered_content).to include('type="url"')
    expect(rendered_content).to include('<input')
  end

  it "includes default styling" do
    render_inline(described_class.new)
    expect(rendered_content).to include("border-neutral-300")
    expect(rendered_content).to include("rounded-lg")
  end

  it "supports dark mode" do
    render_inline(described_class.new)
    expect(rendered_content).to include("dark:bg-neutral-900")
    expect(rendered_content).to include("dark:text-white")
  end

  it "accepts HTML options" do
    render_inline(described_class.new(name: :website, placeholder: "https://example.com"))
    expect(rendered_content).to include('name="website"')
    expect(rendered_content).to include('placeholder="https://example.com"')
  end

  it "accepts pattern attribute" do
    render_inline(described_class.new(pattern: "https://.*"))
    expect(rendered_content).to include('pattern="https://.*"')
  end
end
