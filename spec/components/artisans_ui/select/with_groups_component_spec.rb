# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Select::WithGroupsComponent, type: :component do
  let(:groups) do
    [
      {
        label: "Group 1",
        options: [
          { label: "Option 1", value: "1" },
          { label: "Option 2", value: "2" }
        ]
      },
      {
        label: "Group 2",
        options: [
          { label: "Option 3", value: "3" },
          { label: "Option 4", value: "4" }
        ]
      }
    ]
  end

  it "renders the select element" do
    render_inline(described_class.new(groups: groups))

    expect(rendered_content).to include("select")
    expect(rendered_content).to include('data-controller="artisans-ui--select"')
  end

  it "renders optgroup elements" do
    render_inline(described_class.new(groups: groups))

    expect(rendered_content).to include("<optgroup")
    expect(rendered_content).to include('label="Group 1"')
    expect(rendered_content).to include('label="Group 2"')
  end

  it "renders all options within groups" do
    render_inline(described_class.new(groups: groups))

    groups.each do |group|
      group[:options].each do |opt|
        expect(rendered_content).to include(opt[:label])
        expect(rendered_content).to include(opt[:value])
      end
    end
  end

  it "applies correct styling classes" do
    render_inline(described_class.new(groups: groups))

    expect(rendered_content).to include("rounded-lg border border-neutral-300")
    expect(rendered_content).to include("focus:border-primary-500")
  end

  it "renders with container wrapper" do
    render_inline(described_class.new(groups: groups))

    expect(rendered_content).to include("relative w-full max-w-xs")
  end

  it "accepts custom html_options" do
    render_inline(described_class.new(groups: groups, id: "custom-select", data: { test: "value" }))

    expect(rendered_content).to include('id="custom-select"')
    expect(rendered_content).to include('data-test="value"')
  end

  it "renders option elements correctly" do
    render_inline(described_class.new(groups: groups))

    expect(rendered_content).to include("<option")
    expect(rendered_content).to include('value="1"')
    expect(rendered_content).to include('value="2"')
    expect(rendered_content).to include('value="3"')
    expect(rendered_content).to include('value="4"')
  end
end
