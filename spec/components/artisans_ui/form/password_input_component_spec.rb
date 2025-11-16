# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Form::PasswordInputComponent, type: :component do
  it "renders a password input" do
    render_inline(described_class.new)
    expect(rendered_content).to include('type="password"')
    expect(rendered_content).to include('<input')
  end

  it "includes default styling" do
    render_inline(described_class.new)
    expect(rendered_content).to include("border-neutral-200")
    expect(rendered_content).to include("rounded-lg")
  end

  it "supports dark mode" do
    render_inline(described_class.new)
    expect(rendered_content).to include("dark:bg-neutral-900")
    expect(rendered_content).to include("dark:text-white")
  end

  it "accepts HTML options" do
    render_inline(described_class.new(name: :password, required: true))
    expect(rendered_content).to include('name="password"')
    expect(rendered_content).to include("required")
  end

  it "accepts autocomplete attribute" do
    render_inline(described_class.new(autocomplete: "new-password"))
    expect(rendered_content).to include('autocomplete="new-password"')
  end

  it "accepts minlength attribute" do
    render_inline(described_class.new(minlength: 8))
    expect(rendered_content).to include('minlength="8"')
  end
end
