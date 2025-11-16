# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Form::SelectComponent, type: :component do
  it "renders a select element" do
    render_inline(described_class.new) { "<option>Test</option>".html_safe }
    expect(rendered_content).to include('<select')
    expect(rendered_content).to include('</select>')
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
    render_inline(described_class.new(name: :country, required: true))
    expect(rendered_content).to include('name="country"')
    expect(rendered_content).to include("required")
  end

  it "accepts multiple attribute" do
    render_inline(described_class.new(multiple: true))
    expect(rendered_content).to include("multiple")
  end

  it "renders content block with options" do
    render_inline(described_class.new(name: :status)) do
      '<option value="active">Active</option>'.html_safe
    end
    expect(rendered_content).to include('<option value="active">Active</option>')
  end

  it "accepts data attributes for Stimulus" do
    render_inline(described_class.new(
      data: { controller: "select", select_url_value: "/api/users" }
    ))
    expect(rendered_content).to include('data-controller="select"')
    expect(rendered_content).to include('data-select-url-value="/api/users"')
  end
end
