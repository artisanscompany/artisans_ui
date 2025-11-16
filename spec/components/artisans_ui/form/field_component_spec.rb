# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Form::FieldComponent, type: :component do
  it "renders label and content" do
    render_inline(described_class.new(label: "Email")) { "Input here" }
    expect(rendered_content).to include("<label")
    expect(rendered_content).to include("Email")
    expect(rendered_content).to include("Input here")
  end

  it "renders without label when label is nil" do
    render_inline(described_class.new) { "Input" }
    expect(rendered_content).not_to include("<label")
    expect(rendered_content).to include("Input")
  end

  it "renders error message" do
    render_inline(described_class.new(error: "Invalid")) { "Input" }
    expect(rendered_content).to include("text-red-600")
    expect(rendered_content).to include("Invalid")
  end

  it "renders label with for attribute" do
    render_inline(described_class.new(label: "Name", label_for: "name-field")) { "Input" }
    expect(rendered_content).to include('for="name-field"')
  end

  it "supports dark mode" do
    render_inline(described_class.new(label: "Field")) { "Input" }
    expect(rendered_content).to include("dark:text-white")
  end

  it "supports dark mode for errors" do
    render_inline(described_class.new(error: "Error")) { "Input" }
    expect(rendered_content).to include("dark:text-red-400")
  end
end
