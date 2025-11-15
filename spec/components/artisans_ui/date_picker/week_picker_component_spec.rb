# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::DatePicker::WeekPickerComponent, type: :component do
  it "renders with week picker enabled" do
    render_inline(described_class.new)
    expect(rendered_content).to include('data-date-picker-week-picker-value="true"')
  end
end
