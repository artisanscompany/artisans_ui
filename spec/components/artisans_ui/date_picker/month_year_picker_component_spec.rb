# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::DatePicker::MonthYearPickerComponent, type: :component do
  it "renders with months view by default" do
    render_inline(described_class.new)
    expect(rendered_content).to include('data-date-picker-start-view-value="months"')
    expect(rendered_content).to include('data-date-picker-min-view-value="months"')
  end

  it "renders with years view when specified" do
    render_inline(described_class.new(view: "years"))
    expect(rendered_content).to include('data-date-picker-start-view-value="years"')
  end
end
