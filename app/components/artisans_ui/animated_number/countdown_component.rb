# frozen_string_literal: true

module ArtisansUi
  module AnimatedNumber
    # Countdown Animated Number Component (Variant 8)
    # Real-time countdown timer with interval updates
    # Exact RailsBlocks implementation
    #
    # @example Basic countdown
    #   <%= render ArtisansUi::AnimatedNumber::CountdownComponent.new(
    #     start_value: 10,
    #     end_value: 0,
    #     duration: 500,
    #     trend: -1,
    #     suffix: "s",
    #     update_interval: 1000,
    #     label: "Countdown timer"
    #   ) %>
    #
    # @example Countdown from 60
    #   <%= render ArtisansUi::AnimatedNumber::CountdownComponent.new(
    #     start_value: 60,
    #     end_value: 0,
    #     suffix: "s",
    #     label: "Session timeout"
    #   ) %>
    class CountdownComponent < ApplicationViewComponent
      def initialize(
        start_value: 10,
        end_value: 0,
        duration: 500,
        trend: -1,
        suffix: nil,
        update_interval: 1000,
        label: nil,
        **html_options
      )
        @start_value = start_value
        @end_value = end_value
        @duration = duration
        @trend = trend
        @suffix = suffix
        @update_interval = update_interval
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
                    animated_number_trend_value: @trend,
                    animated_number_format_options_value: '{"minimumIntegerDigits":2}',
                    animated_number_suffix_value: @suffix,
                    animated_number_realtime_value: true,
                    animated_number_update_interval_value: @update_interval
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
