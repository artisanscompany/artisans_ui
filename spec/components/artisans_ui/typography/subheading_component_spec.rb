# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Typography::SubheadingComponent, type: :component do
  it "renders a paragraph tag" do
    render_inline(described_class.new) { "Subheading Text" }

    expect(rendered_content).to include("<p")
    expect(rendered_content).to include("Subheading Text")
  end

  it "renders large variant" do
    render_inline(described_class.new(variant: :large)) { "Large" }

    expect(rendered_content).to include("text-lg")
    expect(rendered_content).to include("text-neutral-600")
    expect(rendered_content).to include("dark:text-neutral-400")
  end

  it "renders regular variant by default" do
    render_inline(described_class.new) { "Regular" }

    expect(rendered_content).to include("text-base")
    expect(rendered_content).to include("text-neutral-600")
  end

  it "renders small variant" do
    render_inline(described_class.new(variant: :small)) { "Small" }

    expect(rendered_content).to include("text-sm")
  end

  it "renders with nil variant (custom classes)" do
    render_inline(described_class.new(variant: nil, class: "text-lg text-blue-600")) { "Custom" }

    expect(rendered_content).to include("text-lg text-blue-600")
    expect(rendered_content).not_to include("text-neutral-600")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(id: "sub", class: "extra")) { "Text" }

    expect(rendered_content).to include('id="sub"')
    expect(rendered_content).to include("extra")
  end

  it "supports dark mode" do
    render_inline(described_class.new) { "Dark" }

    expect(rendered_content).to include("dark:text-neutral-400")
  end

  it "raises error for invalid variant" do
    expect {
      described_class.new(variant: :invalid)
    }.to raise_error(ArgumentError, "Invalid variant: invalid")
  end
end
