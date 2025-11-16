# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Form::EmailInputComponent, type: :component do
  it "renders an email input" do
    render_inline(described_class.new)
    expect(rendered_content).to include('type="email"')
    expect(rendered_content).to include('<input')
  end

  it "includes default styling" do
    render_inline(described_class.new)
    expect(rendered_content).to include("border-neutral-200")
    expect(rendered_content).to include("rounded-lg")
  end

  it "accepts HTML options" do
    render_inline(described_class.new(name: :email, required: true))
    expect(rendered_content).to include('name="email"')
    expect(rendered_content).to include("required")
  end

  it "supports dark mode" do
    render_inline(described_class.new)
    expect(rendered_content).to include("dark:bg-neutral-900")
  end
end
