# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Form::TextInputComponent, type: :component do
  it "renders a text input" do
    render_inline(described_class.new)
    expect(rendered_content).to include('type="text"')
    expect(rendered_content).to include('<input')
  end

  it "includes default styling" do
    render_inline(described_class.new)
    expect(rendered_content).to include("border-neutral-300")
    expect(rendered_content).to include("rounded-lg")
    expect(rendered_content).to include("focus:ring-neutral-900")
  end

  it "accepts HTML options" do
    render_inline(described_class.new(name: :username, placeholder: "Enter name", id: "user"))
    expect(rendered_content).to include('name="username"')
    expect(rendered_content).to include('placeholder="Enter name"')
    expect(rendered_content).to include('id="user"')
  end

  it "supports dark mode" do
    render_inline(described_class.new)
    expect(rendered_content).to include("dark:bg-neutral-900")
    expect(rendered_content).to include("dark:text-white")
  end

  it "accepts custom classes" do
    render_inline(described_class.new(class: "!focus:ring-blue-500"))
    expect(rendered_content).to include("!focus:ring-blue-500")
  end
end
