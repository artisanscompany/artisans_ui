# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Ui::CardComponent, type: :component do
  it "renders a basic card with body content" do
    render_inline(described_class.new) do |card|
      card.with_body { "Card content" }
    end

    expect(rendered_content).to include("Card content")
    expect(rendered_content).to include("bg-white")
    expect(rendered_content).to include("rounded-xl")
  end

  it "renders a card with header and body" do
    render_inline(described_class.new) do |card|
      card.with_header { "Card Title" }
      card.with_body { "Card body text" }
    end

    expect(rendered_content).to include("Card Title")
    expect(rendered_content).to include("Card body text")
    expect(rendered_content).to include("divide-y")
  end

  it "renders a card with all sections" do
    render_inline(described_class.new) do |card|
      card.with_header { "Header" }
      card.with_body { "Body" }
      card.with_footer { "Footer" }
    end

    expect(rendered_content).to include("Header")
    expect(rendered_content).to include("Body")
    expect(rendered_content).to include("Footer")
  end

  it "applies custom HTML attributes" do
    render_inline(described_class.new(id: "custom-card", data: { controller: "card" })) do |card|
      card.with_body { "Content" }
    end

    expect(rendered_content).to include('id="custom-card"')
    expect(rendered_content).to include('data-controller="card"')
  end

  it "doesn't add divide classes for single section" do
    render_inline(described_class.new) do |card|
      card.with_body { "Only body" }
    end

    expect(rendered_content).not_to include("divide-y")
  end
end
