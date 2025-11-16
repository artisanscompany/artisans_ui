# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Form::TextareaComponent, type: :component do
  it "renders a textarea element" do
    render_inline(described_class.new)
    expect(rendered_content).to include('<textarea')
    expect(rendered_content).to include('</textarea>')
  end

  it "uses default 4 rows" do
    render_inline(described_class.new)
    expect(rendered_content).to include('rows="4"')
  end

  it "accepts custom rows" do
    render_inline(described_class.new(rows: 8))
    expect(rendered_content).to include('rows="8"')
  end

  it "includes default styling" do
    render_inline(described_class.new)
    expect(rendered_content).to include("border-neutral-300")
    expect(rendered_content).to include("rounded-lg")
    expect(rendered_content).to include("resize-vertical")
  end

  it "supports dark mode" do
    render_inline(described_class.new)
    expect(rendered_content).to include("dark:bg-neutral-900")
    expect(rendered_content).to include("dark:text-white")
  end

  it "accepts HTML options" do
    render_inline(described_class.new(name: :message, placeholder: "Enter message"))
    expect(rendered_content).to include('name="message"')
    expect(rendered_content).to include('placeholder="Enter message"')
  end

  it "accepts maxlength attribute" do
    render_inline(described_class.new(maxlength: 500))
    expect(rendered_content).to include('maxlength="500"')
  end

  it "renders content block" do
    render_inline(described_class.new(name: :content)) { "Default text" }
    expect(rendered_content).to include("Default text")
  end
end
