# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Password::BasicComponent, type: :component do
  it "renders basic password input with toggle button" do
    render_inline(described_class.new)

    expect(rendered_content).to include('data-controller="artisans-ui--password"')
    expect(rendered_content).to include('type="password"')
    expect(rendered_content).to include('data-artisans-ui--password-target="input"')
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
    render_inline(described_class.new(placeholder: "Custom placeholder text"))

    expect(rendered_content).to include('placeholder="Custom placeholder text"')
  end

  it "renders with default name attribute" do
    render_inline(described_class.new)

    expect(rendered_content).to include('name="password"')
  end

  it "renders with custom name attribute" do
    render_inline(described_class.new(name: "user[password]"))

    expect(rendered_content).to include('name="user[password]"')
  end

  it "renders toggle button with eye icon SVG" do
    render_inline(described_class.new)

    expect(rendered_content).to include('<svg')
    expect(rendered_content).to include('class="w-5 h-5"')
    expect(rendered_content).to include('stroke="currentColor"')
    expect(rendered_content).to include('stroke-width="2"')
    expect(rendered_content).to include('viewBox="0 0 24 24"')
  end

  it "renders eye icon with correct paths" do
    render_inline(described_class.new)

    expect(rendered_content).to include('M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z')
    expect(rendered_content).to include('M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7Z')
  end

  it "renders with proper styling classes" do
    render_inline(described_class.new)

    expect(rendered_content).to include("space-y-2")
    expect(rendered_content).to include("relative")
    expect(rendered_content).to include("w-full px-3 py-2 pr-10")
    expect(rendered_content).to include("border border-neutral-300 dark:border-neutral-600")
    expect(rendered_content).to include("rounded-lg")
    expect(rendered_content).to include("bg-white dark:bg-neutral-800")
    expect(rendered_content).to include("text-neutral-900 dark:text-neutral-100")
  end

  it "renders toggle button with hover states" do
    render_inline(described_class.new)

    expect(rendered_content).to include("text-neutral-400 hover:text-neutral-600 dark:hover:text-neutral-300")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(class: "extra-class", id: "custom-password"))

    expect(rendered_content).to include("extra-class")
    expect(rendered_content).to include('id="custom-password"')
  end

  it "renders button with type button" do
    render_inline(described_class.new)

    expect(rendered_content).to include('type="button"')
  end
end
