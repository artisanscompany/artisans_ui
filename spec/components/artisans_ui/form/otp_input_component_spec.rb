# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Form::OtpInputComponent, type: :component do
  it "renders 6 digit inputs" do
    render_inline(described_class.new)

    expect(page).to have_css("input[type='text']", count: 6)
  end

  it "sets up Stimulus controller" do
    render_inline(described_class.new)

    expect(page).to have_css("[data-controller='otp-input']")
  end

  it "configures auto-submit value" do
    render_inline(described_class.new(auto_submit: true))

    expect(page).to have_css("[data-otp-input-auto-submit-value='true']")
  end

  it "configures autofocus value" do
    render_inline(described_class.new(autofocus: false))

    expect(page).to have_css("[data-otp-input-autofocus-value='false']")
  end

  it "sets autofocus on first input when autofocus is true" do
    render_inline(described_class.new(autofocus: true))

    inputs = page.all("input[type='text']")
    expect(inputs.first[:autofocus]).to be_present
    expect(inputs[1][:autofocus]).to be_nil
  end

  it "sets autocomplete='one-time-code' on first input only" do
    render_inline(described_class.new)

    inputs = page.all("input[type='text']")
    expect(inputs.first[:autocomplete]).to eq("one-time-code")
    expect(inputs[1][:autocomplete]).to eq("off")
  end

  it "sets inputmode='numeric' on all inputs" do
    render_inline(described_class.new)

    expect(page).to have_css("input[inputmode='numeric']", count: 6)
  end

  it "sets maxlength='1' on all inputs" do
    render_inline(described_class.new)

    expect(page).to have_css("input[maxlength='1']", count: 6)
  end

  it "makes all inputs required" do
    render_inline(described_class.new)

    expect(page).to have_css("input[required]", count: 6)
  end

  it "uses custom name attribute" do
    render_inline(described_class.new(name: :verification_code))

    expect(page).to have_css("input[name='verification_code[]']", count: 6)
  end

  it "applies custom CSS classes to wrapper" do
    render_inline(described_class.new(class: "custom-class"))

    expect(page).to have_css(".custom-class")
  end

  it "includes proper Stimulus targets and actions" do
    render_inline(described_class.new)

    expect(page).to have_css("[data-otp-input-target='digit']", count: 6)
    expect(page).to have_css("[data-action*='input->otp-input#handleInput']", count: 6)
    expect(page).to have_css("[data-action*='keydown->otp-input#handleKeydown']", count: 6)
    expect(page).to have_css("[data-action*='paste->otp-input#handlePaste']", count: 6)
  end
end
