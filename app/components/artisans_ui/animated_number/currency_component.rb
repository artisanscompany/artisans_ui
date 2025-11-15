# frozen_string_literal: true

module ArtisansUi
  module AnimatedNumber
    # Currency Animated Number Component (Variant 2)
    # Counter with currency formatting and optional suffix
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::AnimatedNumber::CurrencyComponent.new(
    #     start_value: 50,
    #     end_value: 850.99,
    #     duration: 2500,
    #     suffix: " / month",
    #     label: "Monthly revenue"
    #   ) %>
    #
    # @example Without suffix
    #   <%= render ArtisansUi::AnimatedNumber::CurrencyComponent.new(
    #     start_value: 0,
    #     end_value: 1500.50,
    #     label: "Total revenue"
    #   ) %>
    class CurrencyComponent < ApplicationViewComponent
      def initialize(start_value: 0, end_value: 0, duration: 2500, suffix: nil, label: nil, **html_options)
        @start_value = start_value
        @end_value = end_value
        @duration = duration
        @suffix = suffix
        @label = label
        @html_options = html_options
      end

      def call
        tag.div(class: "space-y-4", **@html_options) do
          tag.div(class: "text-center") do
            content = [
              tag.div(class: "text-4xl font-bold text-neutral-800 dark:text-neutral-200 mb-2") do
                tag.span(
                  data: {
                    controller: "animated-number",
                    animated_number_start_value: @start_value,
                    animated_number_end_value: @end_value,
                    animated_number_duration_value: @duration,
                    animated_number_format_options_value: '{"style":"currency","currency":"USD","minimumFractionDigits":2}',
                    animated_number_suffix_value: @suffix
                  }.compact
                )
              end
            ]

            if @label
              content << tag.p(class: "text-sm text-neutral-600 dark:text-neutral-400") { @label }
            end

            safe_join(content)
          end
        end
      end
    end
  end
end
