# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Radio::BasicComponent, type: :component do
  it "renders basic radio group" do
    render_inline(described_class.new)

    expect(rendered_content).to include('<fieldset')
    expect(rendered_content).to include('class="flex flex-col gap-2"')
    expect(rendered_content).to include('<legend')
    expect(rendered_content).to include('Choose your favorite framework')
    expect(rendered_content).to include('type="radio"')
  end

  it "renders all four radio options" do
    render_inline(described_class.new)

    expect(rendered_content).to include('value="react"')
    expect(rendered_content).to include('value="vue"')
    expect(rendered_content).to include('value="svelte"')
    expect(rendered_content).to include('value="angular"')
  end

  it "renders labels for all options" do
    render_inline(described_class.new)

    expect(rendered_content).to include('React')
    expect(rendered_content).to include('Vue')
    expect(rendered_content).to include('Svelte')
    expect(rendered_content).to include('Angular')
  end

  it "has React checked by default" do
    render_inline(described_class.new)

    expect(rendered_content).to include('id="framework_react"')
    expect(rendered_content).to include('checked')
  end

  it "has Svelte disabled" do
    render_inline(described_class.new)

    expect(rendered_content).to include('id="framework_svelte"')
    expect(rendered_content).to include('disabled')
  end

  it "applies disabled styling to disabled option" do
    render_inline(described_class.new)

    expect(rendered_content).to include('text-neutral-400')
    expect(rendered_content).to include('cursor-not-allowed')
    expect(rendered_content).to include('opacity-50')
  end

  it "uses proper name attribute for all radios" do
    render_inline(described_class.new)

    expect(rendered_content).to include('name="framework"')
  end

  it "uses gap-2 for radio items" do
    render_inline(described_class.new)

    expect(rendered_content).to include('gap-2')
  end
end
