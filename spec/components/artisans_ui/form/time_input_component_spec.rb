# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Form::TimeInputComponent, type: :component do
  it "renders a time input" do
    render_inline(described_class.new)
    expect(rendered_content).to include('type="time"')
    expect(rendered_content).to include('<input')
  end

  it "includes default styling" do
    render_inline(described_class.new)
    expect(rendered_content).to include("border-neutral-300")
    expect(rendered_content).to include("rounded-lg")
  end

  it "supports dark mode" do
    render_inline(described_class.new)
    expect(rendered_content).to include("dark:bg-neutral-900")
    expect(rendered_content).to include("dark:text-white")
  end

  it "accepts HTML options" do
    render_inline(described_class.new(name: :meeting_time, required: true))
    expect(rendered_content).to include('name="meeting_time"')
    expect(rendered_content).to include("required")
  end

  it "accepts min attribute" do
    render_inline(described_class.new(min: "09:00"))
    expect(rendered_content).to include('min="09:00"')
  end

  it "accepts max attribute" do
    render_inline(described_class.new(max: "17:00"))
    expect(rendered_content).to include('max="17:00"')
  end

  it "accepts step attribute" do
    render_inline(described_class.new(step: 900))
    expect(rendered_content).to include('step="900"')
  end
end
