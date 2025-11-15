# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Password::WithRequirementsComponent, type: :component do
  it "renders password input with requirements checklist" do
    render_inline(described_class.new)

    expect(rendered_content).to include('data-controller="artisans-ui--password"')
    expect(rendered_content).to include('data-artisans-ui--password-requirements-value="true"')
    expect(rendered_content).to include('type="password"')
  end

  it "renders with handleInput action" do
    render_inline(described_class.new)

    expect(rendered_content).to include('data-artisans-ui--password-target="input"')
    expect(rendered_content).to include('data-action="input-&gt;artisans-ui--password#handleInput"')
  end

  it "renders all requirement check targets" do
    render_inline(described_class.new)

    expect(rendered_content).to include('data-artisans-ui--password-target="lengthCheck"')
    expect(rendered_content).to include('data-artisans-ui--password-target="lowercaseCheck"')
    expect(rendered_content).to include('data-artisans-ui--password-target="uppercaseCheck"')
    expect(rendered_content).to include('data-artisans-ui--password-target="numberCheck"')
  end

  it "renders requirement text labels" do
    render_inline(described_class.new)

    expect(rendered_content).to include("At least 8 characters")
    expect(rendered_content).to include("One lowercase letter")
    expect(rendered_content).to include("One uppercase letter")
    expect(rendered_content).to include("One number")
  end

  it "renders requirements list with proper structure" do
    render_inline(described_class.new)

    expect(rendered_content).to include('<ul')
    expect(rendered_content).to include('class="space-y-2 text-sm"')
    expect(rendered_content).to include('<li')
    expect(rendered_content).to include('flex items-center gap-2 text-neutral-600 dark:text-neutral-400')
  end

  it "renders unchecked circle icons" do
    render_inline(described_class.new)

    expect(rendered_content).to include('text-neutral-400 dark:text-neutral-500')
    expect(rendered_content).to include('<circle')
    expect(rendered_content).to include('cx="12"')
    expect(rendered_content).to include('cy="12"')
    expect(rendered_content).to include('r="10"')
  end

  it "renders checked icons (hidden by default)" do
    render_inline(described_class.new)

    expect(rendered_content).to include('text-green-500 dark:text-green-400 hidden')
    expect(rendered_content).to include('M22 11.08V12a10 10 0 1 1-5.93-9.14')
    expect(rendered_content).to include('m9 11 3 3L22 4')
  end

  it "renders dual SVG icons for each requirement" do
    render_inline(described_class.new)

    # Should have multiple SVG elements (2 per requirement * 4 requirements + toggle icon)
    expect(rendered_content.scan(/<svg/).count).to be >= 9
  end

  it "renders toggle button with eye icon" do
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
    render_inline(described_class.new(placeholder: "Create a secure password"))

    expect(rendered_content).to include('placeholder="Create a secure password"')
  end

  it "renders with custom name attribute" do
    render_inline(described_class.new(name: "user[password]"))

    expect(rendered_content).to include('name="user[password]"')
  end

  it "renders SVG icons with correct attributes" do
    render_inline(described_class.new)

    expect(rendered_content).to include('class="w-5 h-5"')
    expect(rendered_content).to include('fill="none"')
    expect(rendered_content).to include('stroke="currentColor"')
    expect(rendered_content).to include('stroke-width="2"')
    expect(rendered_content).to include('viewBox="0 0 24 24"')
  end

  it "renders with proper spacing" do
    render_inline(described_class.new)

    expect(rendered_content).to include("space-y-2")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(class: "extra-class", id: "custom-password"))

    expect(rendered_content).to include("extra-class")
    expect(rendered_content).to include('id="custom-password"')
  end
end
