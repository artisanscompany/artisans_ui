# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Password::WithStrengthIndicatorComponent, type: :component do
  it "renders password input with strength indicator" do
    render_inline(described_class.new)

    expect(rendered_content).to include('data-controller="artisans-ui--password"')
    expect(rendered_content).to include('data-artisans-ui--password-strength-value="true"')
    expect(rendered_content).to include('type="password"')
    expect(rendered_content).to include('data-artisans-ui--password-target="input"')
  end

  it "renders with handleInput action on input" do
    render_inline(described_class.new)

    expect(rendered_content).to include('data-action="input-&gt;artisans-ui--password#handleInput"')
  end

  it "renders strength bar element" do
    render_inline(described_class.new)

    expect(rendered_content).to include('data-artisans-ui--password-target="strengthBar"')
    expect(rendered_content).to include('style="width: 0%"')
    expect(rendered_content).to include('h-full bg-neutral-300 dark:bg-neutral-600 transition-all duration-300')
  end

  it "renders strength bar container" do
    render_inline(described_class.new)

    expect(rendered_content).to include('h-2 bg-neutral-200 dark:bg-neutral-700 rounded-full overflow-hidden')
  end

  it "renders strength text element" do
    render_inline(described_class.new)

    expect(rendered_content).to include('data-artisans-ui--password-target="strengthText"')
    expect(rendered_content).to include('Password strength:')
    expect(rendered_content).to include('text-xs text-neutral-500 dark:text-neutral-400')
  end

  it "renders toggle button and icon" do
    render_inline(described_class.new)

    expect(rendered_content).to include('data-action="click-&gt;artisans-ui--password#toggle"')
    expect(rendered_content).to include('data-artisans-ui--password-target="toggleIcon"')
  end

  it "renders password label" do
    render_inline(described_class.new)

    expect(rendered_content).to include("Password")
    expect(rendered_content).to include("block text-sm font-medium text-neutral-700 dark:text-neutral-300")
  end

  it "renders with default placeholder" do
    render_inline(described_class.new)

    expect(rendered_content).to include('placeholder="Enter your password"')
  end

  it "renders with custom placeholder" do
    render_inline(described_class.new(placeholder: "Create a strong password"))

    expect(rendered_content).to include('placeholder="Create a strong password"')
  end

  it "renders with custom name attribute" do
    render_inline(described_class.new(name: "user[password]"))

    expect(rendered_content).to include('name="user[password]"')
  end

  it "renders eye icon SVG with correct structure" do
    render_inline(described_class.new)

    expect(rendered_content).to include('<svg')
    expect(rendered_content).to include('class="w-5 h-5"')
    expect(rendered_content).to include('stroke="currentColor"')
    expect(rendered_content).to include('stroke-width="2"')
    expect(rendered_content).to include('viewBox="0 0 24 24"')
  end

  it "renders with proper container spacing" do
    render_inline(described_class.new)

    expect(rendered_content).to include("space-y-2")
    expect(rendered_content).to include("space-y-1")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(class: "extra-class", data: { custom: "value" }))

    expect(rendered_content).to include("extra-class")
    expect(rendered_content).to include('data-custom="value"')
  end
end
