# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::DatePicker::MinMaxDatesComponent, type: :component do
  it "renders with min date" do
    render_inline(described_class.new(min_date: "2024-01-01"))
    expect(rendered_content).to include('data-date-picker-min-date-value="2024-01-01"')
  end

  it "renders with max date" do
    render_inline(described_class.new(max_date: "2024-12-31"))
    expect(rendered_content).to include('data-date-picker-max-date-value="2024-12-31"')
  end
end
