# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Ui::ButtonComponent, type: :component do
  it "renders a primary button by default" do
    render_inline(described_class.new) { "Click me" }

    expect(rendered_content).to include("Click me")
    expect(rendered_content).to include("bg-blue-600")
  end

  it "renders a secondary button variant" do
    render_inline(described_class.new(variant: :secondary)) { "Click me" }

    expect(rendered_content).to include("Click me")
    expect(rendered_content).to include("bg-gray-200")
  end

  it "renders a danger button variant" do
    render_inline(described_class.new(variant: :danger)) { "Click me" }

    expect(rendered_content).to include("Click me")
    expect(rendered_content).to include("bg-red-600")
  end

  it "renders an outline button variant" do
    render_inline(described_class.new(variant: :outline)) { "Click me" }

    expect(rendered_content).to include("Click me")
    expect(rendered_content).to include("border border-gray-300")
  end

  it "accepts additional HTML options" do
    render_inline(described_class.new(type: "submit", data: { action: "click" })) { "Submit" }

    expect(rendered_content).to include("Submit")
    expect(rendered_content).to include('type="submit"')
    expect(rendered_content).to include('data-action="click"')
  end
end
