# frozen_string_literal: true

module ArtisansUi
  module Radio
    # Card Radio Component (Variant 3)
    # Card-style radio buttons for pricing with rounded-xl styling
    # Uses has-[:checked]:ring-2, has-[:checked]:ring-neutral-400
    # Exact RailsBlocks implementation
    #
    # @example Card-style radio
    #   <%= render ArtisansUi::Radio::CardComponent.new %>
    class CardComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.fieldset(class: "flex flex-col gap-4") do
          safe_join([
            tag.legend("Choose a pricing plan", class: "text-sm font-semibold mb-2"),
            card_radio(
              "Starter",
              "starter",
              "$10/month",
              "Perfect for individuals"
            ),
            card_radio(
              "Professional",
              "professional",
              "$30/month",
              "Best for small teams",
              checked: true
            ),
            card_radio(
              "Business",
              "business",
              "$100/month",
              "For growing companies"
            )
          ])
        end
      end

      private

      def card_radio(title, value, price, description, checked: false)
        input_id = "pricing_#{value}"

        tag.label(
          for: input_id,
          class: "relative flex items-start gap-4 rounded-xl border border-neutral-200 p-4 cursor-pointer has-[:checked]:ring-2 has-[:checked]:ring-neutral-400"
        ) do
          safe_join([
            tag.input(
              type: "radio",
              id: input_id,
              name: "pricing",
              value: value,
              checked: checked || nil,
              class: "absolute left-4"
            ),
            tag.div(class: "ml-8") do
              safe_join([
                tag.div(class: "flex items-center justify-between") do
                  safe_join([
                    tag.div(class: "font-semibold text-neutral-900") { title },
                    tag.div(class: "text-sm font-medium text-neutral-700") { price }
                  ])
                end,
                tag.p(
                  description,
                  class: "text-sm text-neutral-500 mt-1"
                )
              ])
            end
          ])
        end
      end
    end
  end
end
