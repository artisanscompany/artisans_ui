# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Radio::WithConditionalFieldsComponent, type: :component do
  it "renders radio group with conditional fields" do
    render_inline(described_class.new)

    expect(rendered_content).to include('<fieldset')
    expect(rendered_content).to include('class="flex flex-col gap-4"')
    expect(rendered_content).to include('<legend')
    expect(rendered_content).to include('Select payment method')
  end

  it "renders Stimulus controller data attribute" do
    render_inline(described_class.new)

    expect(rendered_content).to include('data-controller="artisans-ui--conditional-radio"')
  end

  it "renders field map value as JSON" do
    render_inline(described_class.new)

    expect(rendered_content).to include('data-artisans-ui--conditional-radio-field-map-value')
    expect(rendered_content).to include('credit_card')
    expect(rendered_content).to include('credit_card_fields')
    expect(rendered_content).to include('paypal')
    expect(rendered_content).to include('paypal_fields')
    expect(rendered_content).to include('bank_transfer')
    expect(rendered_content).to include('bank_transfer_fields')
  end

  it "renders all three payment options" do
    render_inline(described_class.new)

    expect(rendered_content).to include('value="credit_card"')
    expect(rendered_content).to include('value="paypal"')
    expect(rendered_content).to include('value="bank_transfer"')
  end

  it "renders payment method titles" do
    render_inline(described_class.new)

    expect(rendered_content).to include('Credit Card')
    expect(rendered_content).to include('PayPal')
    expect(rendered_content).to include('Bank Transfer')
  end

  it "renders payment method descriptions" do
    render_inline(described_class.new)

    expect(rendered_content).to include('Pay with Visa, Mastercard, or Amex')
    expect(rendered_content).to include('Fast and secure PayPal checkout')
    expect(rendered_content).to include('Direct transfer from your bank account')
  end

  it "has Credit Card checked by default" do
    render_inline(described_class.new)

    expect(rendered_content).to include('id="payment_credit_card"')
    expect(rendered_content).to include('checked')
  end

  it "renders change action on radio inputs" do
    render_inline(described_class.new)

    expect(rendered_content).to include('data-action="change-&gt;artisans-ui--conditional-radio#change"')
  end

  it "renders conditional field targets" do
    render_inline(described_class.new)

    expect(rendered_content).to include('data-artisans-ui--conditional-radio-target="conditionalField"')
  end

  it "renders conditional field data attributes" do
    render_inline(described_class.new)

    expect(rendered_content).to include('data-conditional-field="credit_card_fields"')
    expect(rendered_content).to include('data-conditional-field="paypal_fields"')
    expect(rendered_content).to include('data-conditional-field="bank_transfer_fields"')
  end

  it "renders credit card fields" do
    render_inline(described_class.new)

    expect(rendered_content).to include('Card Number')
    expect(rendered_content).to include('placeholder="1234 5678 9012 3456"')
    expect(rendered_content).to include('Expiry')
    expect(rendered_content).to include('placeholder="MM/YY"')
    expect(rendered_content).to include('CVV')
    expect(rendered_content).to include('placeholder="123"')
  end

  it "renders PayPal fields with hidden class" do
    render_inline(described_class.new)

    expect(rendered_content).to include('PayPal Email')
    expect(rendered_content).to include('placeholder="your.email@example.com"')
    expect(rendered_content).to include('be redirected to PayPal to complete your payment')
  end

  it "renders bank transfer fields with hidden class" do
    render_inline(described_class.new)

    expect(rendered_content).to include('Account Number')
    expect(rendered_content).to include('placeholder="0123456789"')
    expect(rendered_content).to include('Routing Number')
    expect(rendered_content).to include('placeholder="021000021"')
    expect(rendered_content).to include('Processing may take 3-5 business days')
  end

  it "applies hidden class to non-default conditional fields" do
    render_inline(described_class.new)

    expect(rendered_content).to include('class="hidden')
  end

  it "uses card styling with rounded-xl" do
    render_inline(described_class.new)

    expect(rendered_content).to include('rounded-xl')
  end

  it "uses has-[:checked]:ring-2 for checked state" do
    render_inline(described_class.new)

    expect(rendered_content).to include('has-[:checked]:ring-2')
    expect(rendered_content).to include('has-[:checked]:ring-neutral-400')
  end

  it "uses absolute positioning for radio input" do
    render_inline(described_class.new)

    expect(rendered_content).to include('absolute left-4')
  end

  it "uses ml-8 for content offset" do
    render_inline(described_class.new)

    expect(rendered_content).to include('ml-8')
  end

  it "uses proper name attribute for all radios" do
    render_inline(described_class.new)

    expect(rendered_content).to include('name="payment"')
  end

  it "applies border styling to conditional field containers" do
    render_inline(described_class.new)

    expect(rendered_content).to include('border-neutral-200')
    expect(rendered_content).to include('rounded-lg')
  end
end
