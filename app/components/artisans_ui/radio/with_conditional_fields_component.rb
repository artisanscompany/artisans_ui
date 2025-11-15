# frozen_string_literal: true

module ArtisansUi
  module Radio
    # Radio with Conditional Fields Component (Variant 5)
    # Radio cards that show/hide conditional fields using artisans-ui--conditional-radio controller
    # Uses data-controller, data-action, data-targets, and data-values
    # Exact RailsBlocks implementation
    #
    # @example Radio with conditional fields
    #   <%= render ArtisansUi::Radio::WithConditionalFieldsComponent.new %>
    class WithConditionalFieldsComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.div(
          data: {
            controller: "artisans-ui--conditional-radio",
            "artisans-ui--conditional-radio-field-map-value": {
              credit_card: "credit_card_fields",
              paypal: "paypal_fields",
              bank_transfer: "bank_transfer_fields"
            }.to_json
          }
        ) do
          safe_join([
            tag.fieldset(class: "flex flex-col gap-4") do
              safe_join([
                tag.legend("Select payment method", class: "text-sm font-semibold mb-2"),
                conditional_radio(
                  "Credit Card",
                  "credit_card",
                  "Pay with Visa, Mastercard, or Amex",
                  checked: true
                ),
                conditional_radio(
                  "PayPal",
                  "paypal",
                  "Fast and secure PayPal checkout"
                ),
                conditional_radio(
                  "Bank Transfer",
                  "bank_transfer",
                  "Direct transfer from your bank account"
                )
              ])
            end,
            credit_card_fields,
            paypal_fields,
            bank_transfer_fields
          ])
        end
      end

      private

      def conditional_radio(title, value, description, checked: false)
        input_id = "payment_#{value}"

        tag.label(
          for: input_id,
          class: "relative flex items-start gap-4 rounded-xl border border-neutral-200 dark:border-neutral-700 p-4 cursor-pointer has-[:checked]:ring-2 has-[:checked]:ring-neutral-400 dark:has-[:checked]:ring-neutral-500"
        ) do
          safe_join([
            tag.input(
              type: "radio",
              id: input_id,
              name: "payment",
              value: value,
              checked: checked || nil,
              class: "absolute left-4",
              data: {
                action: "change->artisans-ui--conditional-radio#change"
              }
            ),
            tag.div(class: "ml-8") do
              safe_join([
                tag.div(class: "font-semibold text-neutral-900 dark:text-neutral-100") { title },
                tag.p(
                  description,
                  class: "text-sm text-neutral-500 mt-1"
                )
              ])
            end
          ])
        end
      end

      def credit_card_fields
        tag.div(
          class: "mt-4 p-4 border border-neutral-200 dark:border-neutral-700 rounded-lg",
          data: {
            "artisans-ui--conditional-radio-target": "conditionalField",
            "conditional-field": "credit_card_fields"
          }
        ) do
          safe_join([
            tag.label("Card Number", class: "block text-sm font-medium text-neutral-700 dark:text-neutral-300 mb-1"),
            tag.input(
              type: "text",
              placeholder: "1234 5678 9012 3456",
              class: "w-full px-3 py-2 border border-neutral-300 dark:border-neutral-600 rounded-md"
            ),
            tag.div(class: "grid grid-cols-2 gap-4 mt-3") do
              safe_join([
                tag.div do
                  safe_join([
                    tag.label("Expiry", class: "block text-sm font-medium text-neutral-700 dark:text-neutral-300 mb-1"),
                    tag.input(
                      type: "text",
                      placeholder: "MM/YY",
                      class: "w-full px-3 py-2 border border-neutral-300 dark:border-neutral-600 rounded-md"
                    )
                  ])
                end,
                tag.div do
                  safe_join([
                    tag.label("CVV", class: "block text-sm font-medium text-neutral-700 dark:text-neutral-300 mb-1"),
                    tag.input(
                      type: "text",
                      placeholder: "123",
                      class: "w-full px-3 py-2 border border-neutral-300 dark:border-neutral-600 rounded-md"
                    )
                  ])
                end
              ])
            end
          ])
        end
      end

      def paypal_fields
        tag.div(
          class: "hidden mt-4 p-4 border border-neutral-200 dark:border-neutral-700 rounded-lg",
          data: {
            "artisans-ui--conditional-radio-target": "conditionalField",
            "conditional-field": "paypal_fields"
          }
        ) do
          safe_join([
            tag.label("PayPal Email", class: "block text-sm font-medium text-neutral-700 dark:text-neutral-300 mb-1"),
            tag.input(
              type: "email",
              placeholder: "your.email@example.com",
              class: "w-full px-3 py-2 border border-neutral-300 dark:border-neutral-600 rounded-md"
            ),
            tag.p(
              "You'll be redirected to PayPal to complete your payment",
              class: "text-xs text-neutral-500 mt-2"
            )
          ])
        end
      end

      def bank_transfer_fields
        tag.div(
          class: "hidden mt-4 p-4 border border-neutral-200 dark:border-neutral-700 rounded-lg",
          data: {
            "artisans-ui--conditional-radio-target": "conditionalField",
            "conditional-field": "bank_transfer_fields"
          }
        ) do
          safe_join([
            tag.label("Account Number", class: "block text-sm font-medium text-neutral-700 dark:text-neutral-300 mb-1"),
            tag.input(
              type: "text",
              placeholder: "0123456789",
              class: "w-full px-3 py-2 border border-neutral-300 dark:border-neutral-600 rounded-md"
            ),
            tag.div(class: "mt-3") do
              safe_join([
                tag.label("Routing Number", class: "block text-sm font-medium text-neutral-700 dark:text-neutral-300 mb-1"),
                tag.input(
                  type: "text",
                  placeholder: "021000021",
                  class: "w-full px-3 py-2 border border-neutral-300 dark:border-neutral-600 rounded-md"
                )
              ])
            end,
            tag.p(
              "Processing may take 3-5 business days",
              class: "text-xs text-neutral-500 mt-2"
            )
          ])
        end
      end
    end
  end
end
