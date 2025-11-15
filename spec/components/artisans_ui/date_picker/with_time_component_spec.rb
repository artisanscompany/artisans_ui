# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::DatePicker::WithTimeComponent, type: :component do
  it "renders with timepicker enabled" do
    render_inline(described_class.new)
    expect(rendered_content).to include('data-date-picker-timepicker-value="true"')
  end

  it "renders with initial datetime" do
    render_inline(described_class.new(initial_datetime: "2024-08-15 14:30"))
    expect(rendered_content).to include('data-date-picker-initial-date-value="2024-08-15 14:30"')
  end
end
