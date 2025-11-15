# frozen_string_literal: true

module ArtisansUi
  module AnimatedNumber
    # Compact Animated Number Component (Variant 3)
    # Counter with compact notation formatting (1K, 1M, etc.)
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::AnimatedNumber::CompactComponent.new(
    #     start_value: 0,
    #     end_value: 125600,
    #     duration: 2000,
    #     label: "Total downloads"
    #   ) %>
    #
    # @example With larger number
    #   <%= render ArtisansUi::AnimatedNumber::CompactComponent.new(
    #     start_value: 0,
    #     end_value: 1500000,
    #     label: "Total users"
    #   ) %>
    class CompactComponent < ApplicationViewComponent
      def initialize(start_value: 0, end_value: 0, duration: 2000, label: nil, **html_options)
        @start_value = start_value
        @end_value = end_value
        @duration = duration
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
                    animated_number_format_options_value: '{"notation":"compact","compactDisplay":"short"}'
                  }
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
