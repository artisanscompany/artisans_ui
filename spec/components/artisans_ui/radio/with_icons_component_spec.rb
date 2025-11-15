# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Radio::WithIconsComponent, type: :component do
  it "renders radio group with icons" do
    render_inline(described_class.new)

    expect(rendered_content).to include('<fieldset')
    expect(rendered_content).to include('class="flex flex-col gap-4"')
    expect(rendered_content).to include('<legend')
    expect(rendered_content).to include('How did you hear about us?')
  end

  it "renders all four source options" do
    render_inline(described_class.new)

    expect(rendered_content).to include('value="search"')
    expect(rendered_content).to include('value="ai"')
    expect(rendered_content).to include('value="social"')
    expect(rendered_content).to include('value="referral"')
  end

  it "renders source titles" do
    render_inline(described_class.new)

    expect(rendered_content).to include('Search Engine')
    expect(rendered_content).to include('AI Assistant')
    expect(rendered_content).to include('Social Media')
    expect(rendered_content).to include('Referral')
  end

  it "renders source descriptions" do
    render_inline(described_class.new)

    expect(rendered_content).to include('Found us through Google, Bing, etc.')
    expect(rendered_content).to include('ChatGPT, Claude, or other AI recommended us')
    expect(rendered_content).to include('Discovered on Twitter, LinkedIn, etc.')
    expect(rendered_content).to include('A friend or colleague told me')
  end

  it "has Search Engine checked by default" do
    render_inline(described_class.new)

    expect(rendered_content).to include('id="source_search"')
    expect(rendered_content).to include('checked')
  end

  it "renders SVG icons" do
    render_inline(described_class.new)

    expect(rendered_content).to include('<svg')
    expect(rendered_content).to include('xmlns="http://www.w3.org/2000/svg"')
    expect(rendered_content).to include('viewBox="0 0 24 24"')
  end

  it "applies proper SVG attributes" do
    render_inline(described_class.new)

    expect(rendered_content).to include('stroke-width="1.5"')
    expect(rendered_content).to include('stroke="currentColor"')
    expect(rendered_content).to include('fill="none"')
  end

  it "applies icon styling" do
    render_inline(described_class.new)

    expect(rendered_content).to include('w-6 h-6')
    expect(rendered_content).to include('text-neutral-600')
  end

  it "uses card styling with rounded-xl" do
    render_inline(described_class.new)

    expect(rendered_content).to include('rounded-xl')
  end

  it "uses has-[:checked]:ring-2 for checked state" do
    render_inline(described_class.new)

    expect(rendered_content).to include('has-[:checked]:ring-2')
    expect(rendered_content).to include('has-[:checked]:ring-neutral-400')
  end

  it "uses absolute positioning for radio input" do
    render_inline(described_class.new)

    expect(rendered_content).to include('absolute left-4')
  end

  it "uses ml-8 for content offset" do
    render_inline(described_class.new)

    expect(rendered_content).to include('ml-8')
  end

  it "uses proper name attribute for all radios" do
    render_inline(described_class.new)

    expect(rendered_content).to include('name="source"')
  end

  it "uses flex gap for icon layout" do
    render_inline(described_class.new)

    expect(rendered_content).to include('flex gap-3')
  end

  it "renders SVG path elements" do
    render_inline(described_class.new)

    expect(rendered_content).to include('<path')
    expect(rendered_content).to include('stroke-linecap="round"')
    expect(rendered_content).to include('stroke-linejoin="round"')
  end
end
