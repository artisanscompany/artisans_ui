# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::DatePicker::InlineCalendarComponent, type: :component do
  it "renders with inline mode enabled" do
    render_inline(described_class.new)
    expect(rendered_content).to include('data-date-picker-inline-value="true"')
  end

  it "renders with hidden input" do
    render_inline(described_class.new)
    expect(rendered_content).to include('class="hidden"')
  end

  it "renders with range when enabled" do
    render_inline(described_class.new(range: true))
    expect(rendered_content).to include('data-date-picker-range-value="true"')
  end
end
