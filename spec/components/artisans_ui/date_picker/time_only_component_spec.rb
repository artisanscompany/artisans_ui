# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::DatePicker::TimeOnlyComponent, type: :component do
  it "renders with time-only mode enabled" do
    render_inline(described_class.new)
    expect(rendered_content).to include('data-date-picker-time-only-value="true"')
  end
end
