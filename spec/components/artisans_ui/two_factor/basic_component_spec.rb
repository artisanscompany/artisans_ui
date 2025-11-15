# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::TwoFactor::BasicComponent, type: :component do
  it "renders two-factor authentication form with 6 inputs" do
    render_inline(described_class.new(
      title: "Two-Factor Authentication",
      subtitle: "Confirm your account by entering the verification code.",
      submit_text: "Verify code"
    ))

    expect(page).to have_text("Two-Factor Authentication")
    expect(page).to have_text("Confirm your account by entering the verification code.")
    expect(page).to have_css('[data-controller="two-factor"]')
    expect(page).to have_css('input[data-two-factor-target="num1"]')
    expect(page).to have_css('input[data-two-factor-target="num2"]')
    expect(page).to have_css('input[data-two-factor-target="num3"]')
    expect(page).to have_css('input[data-two-factor-target="num4"]')
    expect(page).to have_css('input[data-two-factor-target="num5"]')
    expect(page).to have_css('input[data-two-factor-target="num6"]')
    expect(page).to have_button("Verify code")
  end

  it "sets auto-submit value" do
    render_inline(described_class.new(auto_submit: true))
    expect(page).to have_css('[data-two-factor-auto-submit-value="true"]')
  end

  it "sets autofocus value" do
    render_inline(described_class.new(autofocus: false))
    expect(page).to have_css('[data-two-factor-autofocus-value="false"]')
  end

  it "renders custom form URL and method" do
    render_inline(described_class.new(form_url: "/verify", form_method: :post))
    expect(page).to have_css('form[action="/verify"]')
  end

  it "renders with content slot" do
    render_inline(described_class.new) do
      "Haven't received it? <a href='#'>Get a new code</a>".html_safe
    end

    expect(page).to have_text("Haven't received it?")
    expect(page).to have_link("Get a new code")
  end
end
