# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Form::FileInputComponent, type: :component do
  it "renders a file input" do
    render_inline(described_class.new)
    expect(rendered_content).to include('type="file"')
    expect(rendered_content).to include('<input')
  end

  it "includes default styling" do
    render_inline(described_class.new)
    expect(rendered_content).to include("border-neutral-200")
    expect(rendered_content).to include("rounded-lg")
  end

  it "includes file button styling" do
    render_inline(described_class.new)
    expect(rendered_content).to include("file:bg-neutral-100")
    expect(rendered_content).to include("file:rounded-lg")
  end

  it "supports dark mode" do
    render_inline(described_class.new)
    expect(rendered_content).to include("dark:bg-neutral-900")
    expect(rendered_content).to include("dark:file:bg-neutral-800")
  end

  it "accepts HTML options" do
    render_inline(described_class.new(name: :avatar, required: true))
    expect(rendered_content).to include('name="avatar"')
    expect(rendered_content).to include("required")
  end

  it "accepts accept attribute" do
    render_inline(described_class.new(accept: "image/*"))
    expect(rendered_content).to include('accept="image/*"')
  end

  it "accepts multiple attribute" do
    render_inline(described_class.new(multiple: true))
    expect(rendered_content).to include("multiple")
  end
end
