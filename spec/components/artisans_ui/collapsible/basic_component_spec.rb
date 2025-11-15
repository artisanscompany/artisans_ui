# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Collapsible::BasicComponent, type: :component do
  let(:title) { "Click to expand" }
  let(:content) { "This is the collapsible content." }

  it "renders the component" do
    render_inline(described_class.new(title: title)) { content }

    expect(rendered_content).to include(title)
    expect(rendered_content).to include(content)
  end

  it "has collapsible controller" do
    render_inline(described_class.new(title: title)) { content }

    expect(rendered_content).to include('data-controller="collapsible"')
  end

  it "renders with closed state by default" do
    render_inline(described_class.new(title: title)) { content }

    expect(rendered_content).to include('data-collapsible-open-value="false"')
    expect(rendered_content).to include('data-state="closed"')
  end

  it "renders with open state when specified" do
    render_inline(described_class.new(title: title, open: true)) { content }

    expect(rendered_content).to include('data-collapsible-open-value="true"')
    expect(rendered_content).to include('data-state="open"')
  end

  it "has toggle button" do
    render_inline(described_class.new(title: title)) { content }

    expect(rendered_content).to include('data-action="click')
    expect(rendered_content).to include('collapsible#toggle"')
  end

  it "has content target" do
    render_inline(described_class.new(title: title)) { content }

    expect(rendered_content).to include('data-collapsible-target="content"')
  end

  it "has icon targets" do
    render_inline(described_class.new(title: title)) { content }

    expect(rendered_content).to include('data-collapsible-target="collapsedIcon"')
    expect(rendered_content).to include('data-collapsible-target="expandedIcon"')
  end

  it "renders plus and minus icons" do
    render_inline(described_class.new(title: title)) { content }

    expect(rendered_content.scan(/<svg/).count).to eq(2)
  end

  it "applies custom HTML options" do
    render_inline(described_class.new(title: title, class: "custom-class", id: "custom-id")) { content }

    expect(rendered_content).to include('id="custom-id"')
    expect(rendered_content).to include('custom-class')
  end

  context "when closed" do
    it "shows collapsed icon with opacity 1" do
      render_inline(described_class.new(title: title, open: false)) { content }

      expect(rendered_content).to include('opacity: 1')
    end

    it "shows expanded icon with opacity 0" do
      render_inline(described_class.new(title: title, open: false)) { content }

      expect(rendered_content).to include('opacity: 0')
    end

    it "sets content max-height to 0" do
      render_inline(described_class.new(title: title, open: false)) { content }

      expect(rendered_content).to include('max-height: 0')
    end
  end

  context "when open" do
    it "shows collapsed icon with opacity 0" do
      render_inline(described_class.new(title: title, open: true)) { content }

      expect(rendered_content).to include('opacity: 0')
    end

    it "shows expanded icon with opacity 1" do
      render_inline(described_class.new(title: title, open: true)) { content }

      expect(rendered_content).to include('opacity: 1')
    end

    it "sets content max-height to none" do
      render_inline(described_class.new(title: title, open: true)) { content }

      expect(rendered_content).to include('max-height: none')
    end
  end
end
