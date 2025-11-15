# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::DatePicker::WithInitialDateComponent, type: :component do
  it "renders with initial date value" do
    render_inline(described_class.new(initial_date: "2024-08-15"))
    expect(rendered_content).to include('data-date-picker-initial-date-value="2024-08-15"')
  end

  it "renders Stimulus controller" do
    render_inline(described_class.new(initial_date: "2024-01-01"))
    expect(rendered_content).to include('data-controller="date-picker"')
  end
end
