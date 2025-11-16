# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Form::ErrorInputComponent, type: :component do
  it "renders a text input by default" do
    render_inline(described_class.new)
    expect(rendered_content).to include('type="text"')
    expect(rendered_content).to include('<input')
  end

  it "renders specified input type" do
    render_inline(described_class.new(type: :email))
    expect(rendered_content).to include('type="email"')
    expect(rendered_content).to include('<input')
  end

  it "includes error styling" do
    render_inline(described_class.new)
    expect(rendered_content).to include("border-red-300")
    expect(rendered_content).to include("focus:ring-red-600")
  end

  it "supports dark mode error colors" do
    render_inline(described_class.new)
    expect(rendered_content).to include("dark:border-red-700")
    expect(rendered_content).to include("dark:focus:ring-red-400")
  end

  it "accepts HTML options" do
    render_inline(described_class.new(name: :email, value: "bad@"))
    expect(rendered_content).to include('name="email"')
    expect(rendered_content).to include('value="bad@"')
  end
end
