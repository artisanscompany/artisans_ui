# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::DatePicker::RangeComponent, type: :component do
  it "renders with range enabled" do
    render_inline(described_class.new)
    expect(rendered_content).to include('data-date-picker-range-value="true"')
  end

  it "renders with initial dates array" do
    render_inline(described_class.new(initial_dates: ["2024-01-01", "2024-01-31"]))
    expect(rendered_content).to include('data-date-picker-initial-date-value')
    expect(rendered_content).to include("2024-01-01")
    expect(rendered_content).to include("2024-01-31")
  end
end
