# frozen_string_literal: true

module ArtisansUi
  module Radio
    # Radio with Description Component (Variant 2)
    # Radio buttons with descriptions for subscription plans
    # Uses mt-1 spacing and text-xs text-neutral-500 for descriptions
    # Exact RailsBlocks implementation
    #
    # @example Radio with descriptions
    #   <%= render ArtisansUi::Radio::WithDescriptionComponent.new %>
    class WithDescriptionComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.fieldset(class: "flex flex-col gap-4") do
          safe_join([
            tag.legend("Select a subscription plan", class: "text-sm font-semibold mb-2"),
            radio_with_description(
              "Free",
              "free",
              "Perfect for personal projects and testing",
              checked: true
            ),
            radio_with_description(
              "Pro",
              "pro",
              "Great for professionals and small teams"
            ),
            radio_with_description(
              "Enterprise",
              "enterprise",
              "Advanced features for large organizations"
            )
          ])
        end
      end

      private

      def radio_with_description(label, value, description, checked: false)
        input_id = "plan_#{value}"

        tag.div(class: "flex items-start gap-2") do
          safe_join([
            tag.input(
              type: "radio",
              id: input_id,
              name: "plan",
              value: value,
              checked: checked || nil,
              class: "mt-1"
            ),
            tag.div do
              safe_join([
                tag.label(
                  label,
                  for: input_id,
                  class: "text-sm font-medium text-neutral-700 dark:text-neutral-300"
                ),
                tag.p(
                  description,
                  class: "text-xs text-neutral-500"
                )
              ])
            end
          ])
        end
      end
    end
  end
end
