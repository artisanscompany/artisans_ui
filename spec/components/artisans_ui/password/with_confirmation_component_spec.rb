# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Password::WithConfirmationComponent, type: :component do
  it "renders password and confirmation fields" do
    render_inline(described_class.new)

    expect(rendered_content).to include('data-controller="artisans-ui--password"')
    expect(rendered_content).to include('data-artisans-ui--password-confirm-value="true"')
    expect(rendered_content).to include('type="password"')
  end

  it "renders password input with checkMatch action" do
    render_inline(described_class.new)

    expect(rendered_content).to include('data-artisans-ui--password-target="input"')
    expect(rendered_content).to include('data-action="input-&gt;artisans-ui--password#checkMatch"')
  end

  it "renders confirm input with checkMatch action" do
    render_inline(described_class.new)

    expect(rendered_content).to include('data-artisans-ui--password-target="confirm"')
    # Check that checkMatch action appears at least twice (once for each input)
    expect(rendered_content.scan(/input-&gt;artisans-ui--password#checkMatch/).count).to eq(2)
  end

  it "renders both toggle icons" do
    render_inline(described_class.new)

    expect(rendered_content).to include('data-artisans-ui--password-target="toggleIcon"')
    expect(rendered_content).to include('data-artisans-ui--password-target="confirmToggleIcon"')
  end

  it "renders match indicator element" do
    render_inline(described_class.new)

    expect(rendered_content).to include('data-artisans-ui--password-target="matchIndicator"')
    expect(rendered_content).to include('class="hidden"')
  end

  it "renders match text element" do
    render_inline(described_class.new)

    expect(rendered_content).to include('data-artisans-ui--password-target="matchText"')
    expect(rendered_content).to include('class="text-sm"')
  end

  it "renders password label" do
    render_inline(described_class.new)

    expect(rendered_content).to include("Password")
    expect(rendered_content).to include("Confirm Password")
  end

  it "renders with default placeholders" do
    render_inline(described_class.new)

    expect(rendered_content).to include('placeholder="Enter your password"')
    expect(rendered_content).to include('placeholder="Confirm your password"')
  end

  it "renders with custom placeholders" do
    render_inline(described_class.new(
      placeholder: "Custom password",
      confirm_placeholder: "Custom confirm"
    ))

    expect(rendered_content).to include('placeholder="Custom password"')
    expect(rendered_content).to include('placeholder="Custom confirm"')
  end

  it "renders with default name attributes" do
    render_inline(described_class.new)

    expect(rendered_content).to include('name="password"')
    expect(rendered_content).to include('name="password_confirmation"')
  end

  it "renders with custom name attributes" do
    render_inline(described_class.new(
      name: "user[password]",
      confirm_name: "user[password_confirmation]"
    ))

    expect(rendered_content).to include('name="user[password]"')
    expect(rendered_content).to include('name="user[password_confirmation]"')
  end

  it "renders eye icon SVGs with correct structure" do
    render_inline(described_class.new)

    expect(rendered_content).to include('<svg')
    expect(rendered_content).to include('class="w-5 h-5"')
    expect(rendered_content).to include('stroke="currentColor"')
    expect(rendered_content).to include('stroke-width="2"')
    expect(rendered_content).to include('viewBox="0 0 24 24"')
  end

  it "renders both toggle buttons with click actions" do
    render_inline(described_class.new)

    # Should have 2 toggle buttons
    expect(rendered_content.scan(/data-action="click-&gt;artisans-ui--password#toggle"/).count).to eq(2)
    expect(rendered_content.scan(/type="button"/).count).to be >= 2
  end

  it "renders with proper spacing classes" do
    render_inline(described_class.new)

    expect(rendered_content).to include("space-y-4")
    expect(rendered_content).to include("space-y-2")
  end

  it "accepts custom HTML options on password input" do
    render_inline(described_class.new(class: "extra-class", id: "custom-id"))

    expect(rendered_content).to include("extra-class")
    expect(rendered_content).to include('id="custom-id"')
  end
end
