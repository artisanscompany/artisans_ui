# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Accordion::AccordionComponent, type: :component do
  it "renders an accordion with single item" do
    render_inline(described_class.new) do |accordion|
      accordion.with_item(title: "Section 1") { "Content 1" }
    end

    expect(rendered_content).to include("Section 1")
    expect(rendered_content).to include("Content 1")
    expect(rendered_content).to include("data-controller=\"accordion\"")
  end

  it "renders multiple accordion items" do
    render_inline(described_class.new) do |accordion|
      accordion.with_item(title: "Section 1") { "Content 1" }
      accordion.with_item(title: "Section 2") { "Content 2" }
      accordion.with_item(title: "Section 3") { "Content 3" }
    end

    expect(rendered_content).to include("Section 1")
    expect(rendered_content).to include("Section 2")
    expect(rendered_content).to include("Section 3")
    expect(rendered_content).to include("Content 1")
    expect(rendered_content).to include("Content 2")
    expect(rendered_content).to include("Content 3")
  end

  it "renders item in open state" do
    render_inline(described_class.new) do |accordion|
      accordion.with_item(title: "Open Section", open: true) { "Visible content" }
    end

    expect(rendered_content).to include("data-state=\"open\"")
    expect(rendered_content).to include("aria-expanded=\"true\"")
    expect(rendered_content).not_to include("hidden=\"hidden\"")
  end

  it "renders item in closed state by default" do
    render_inline(described_class.new) do |accordion|
      accordion.with_item(title: "Closed Section") { "Hidden content" }
    end

    expect(rendered_content).to include("data-state=\"closed\"")
    expect(rendered_content).to include("aria-expanded=\"false\"")
    expect(rendered_content).to include("hidden")
  end

  it "sets allow_multiple value" do
    render_inline(described_class.new(allow_multiple: true)) do |accordion|
      accordion.with_item(title: "Section 1") { "Content 1" }
    end

    expect(rendered_content).to include("data-accordion-allow-multiple-value=\"true\"")
  end

  it "includes accordion targets" do
    render_inline(described_class.new) do |accordion|
      accordion.with_item(title: "Test") { "Content" }
    end

    expect(rendered_content).to include("data-accordion-target=\"item\"")
    expect(rendered_content).to include("data-accordion-target=\"trigger\"")
    expect(rendered_content).to include("data-accordion-target=\"content\"")
    expect(rendered_content).to include("data-accordion-target=\"icon\"")
  end

  it "includes click action" do
    render_inline(described_class.new) do |accordion|
      accordion.with_item(title: "Test") { "Content" }
    end

    # Rails transforms data: { action: } to data-action attribute
    expect(rendered_content).to match(/data-action="[^"]*click-&gt;accordion#toggle/)
  end

  it "applies custom HTML attributes" do
    render_inline(described_class.new(id: "custom-accordion", class: "my-custom-class")) do |accordion|
      accordion.with_item(title: "Test") { "Content" }
    end

    expect(rendered_content).to include("id=\"custom-accordion\"")
    expect(rendered_content).to include("my-custom-class")
  end

  it "renders with chevron icon by default" do
    render_inline(described_class.new) do |accordion|
      accordion.with_item(title: "Test") { "Content" }
    end

    expect(rendered_content).to include("viewBox=\"0 0 18 18\"")
  end

  it "renders with plus/minus icon" do
    render_inline(described_class.new) do |accordion|
      accordion.with_item(title: "Test", icon: :plus_minus) { "Content" }
    end

    expect(rendered_content).to include("M5 12h14")
    expect(rendered_content).to include("M12 5v14")
  end

  it "renders with arrow icon" do
    render_inline(described_class.new) do |accordion|
      accordion.with_item(title: "Test", icon: :arrow) { "Content" }
    end

    expect(rendered_content).to include("M5 12h14M12 5l7 7-7 7")
    expect(rendered_content).to include("-rotate-90")
  end

  it "includes ARIA attributes for accessibility" do
    render_inline(described_class.new) do |accordion|
      accordion.with_item(title: "Test") { "Content" }
    end

    expect(rendered_content).to include("role=\"region\"")
    expect(rendered_content).to include("aria-expanded")
    expect(rendered_content).to include("aria-controls")
    expect(rendered_content).to include("aria-labelledby")
  end
end
