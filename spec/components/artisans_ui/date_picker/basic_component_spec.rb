# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::DatePicker::BasicComponent, type: :component do
  it "renders date picker with Stimulus controller" do
    render_inline(described_class.new)
    expect(rendered_content).to include('data-controller="date-picker"')
  end

  it "renders input with date-picker target" do
    render_inline(described_class.new)
    expect(rendered_content).to include('data-date-picker-target="input"')
  end

  it "renders with today button when enabled" do
    render_inline(described_class.new(show_today_button: true))
    expect(rendered_content).to include('data-date-picker-show-today-button-value="true"')
  end

  it "renders with clear button when enabled" do
    render_inline(described_class.new(show_clear_button: true))
    expect(rendered_content).to include('data-date-picker-show-clear-button-value="true"')
  end

  it "renders with custom placeholder" do
    render_inline(described_class.new(placeholder: "Pick a date"))
    expect(rendered_content).to include('placeholder="Pick a date"')
  end

  it "renders calendar icon" do
    render_inline(described_class.new)
    expect(rendered_content).to include('<svg')
    expect(rendered_content).to include('viewBox="0 0 18 18"')
  end

  it "includes proper styling classes" do
    render_inline(described_class.new)
    expect(rendered_content).to include("rounded-lg")
    expect(rendered_content).to include("dark:bg-neutral-700")
  end
end
