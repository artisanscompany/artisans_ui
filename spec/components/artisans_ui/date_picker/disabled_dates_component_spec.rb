# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::DatePicker::DisabledDatesComponent, type: :component do
  it "renders with disabled dates array" do
    render_inline(described_class.new(disabled_dates: ["2024-01-01", "2024-12-25"]))
    expect(rendered_content).to include('data-date-picker-disabled-dates-value')
  end
end
