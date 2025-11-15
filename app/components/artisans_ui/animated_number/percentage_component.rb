# frozen_string_literal: true

module ArtisansUi
  module AnimatedNumber
    # Percentage Animated Number Component (Variant 4)
    # Counter with decimal formatting, prefix and suffix for percentages
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::AnimatedNumber::PercentageComponent.new(
    #     start_value: 0,
    #     end_value: 147.5,
    #     duration: 2800,
    #     prefix: "+",
    #     suffix: "%",
    #     label: "Year-over-year growth"
    #   ) %>
    #
    # @example Without prefix
    #   <%= render ArtisansUi::AnimatedNumber::PercentageComponent.new(
    #     start_value: 0,
    #     end_value: 95.8,
    #     suffix: "%",
    #     label: "Success rate"
    #   ) %>
    class PercentageComponent < ApplicationViewComponent
      def initialize(start_value: 0, end_value: 0, duration: 2800, prefix: nil, suffix: nil, label: nil, **html_options)
        @start_value = start_value
        @end_value = end_value
        @duration = duration
        @prefix = prefix
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
                    animated_number_format_options_value: '{"minimumFractionDigits":1,"maximumFractionDigits":1}',
                    animated_number_suffix_value: @suffix,
                    animated_number_prefix_value: @prefix
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
