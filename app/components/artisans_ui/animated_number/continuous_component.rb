# frozen_string_literal: true

module ArtisansUi
  module AnimatedNumber
    # Continuous vs Discrete Animated Number Component (Variant 5)
    # Demonstrates continuous smooth animation vs discrete step animation
    # Exact RailsBlocks implementation
    #
    # @example Continuous animation
    #   <%= render ArtisansUi::AnimatedNumber::ContinuousComponent.new(
    #     start_value: 0,
    #     end_value: 100,
    #     duration: 1500,
    #     continuous: true,
    #     label: "Continuous Animation"
    #   ) %>
    #
    # @example Discrete animation
    #   <%= render ArtisansUi::AnimatedNumber::ContinuousComponent.new(
    #     start_value: 0,
    #     end_value: 100,
    #     duration: 1500,
    #     continuous: false,
    #     label: "Discrete Animation"
    #   ) %>
    class ContinuousComponent < ApplicationViewComponent
      def initialize(start_value: 0, end_value: 100, duration: 1500, continuous: true, label: nil, **html_options)
        @start_value = start_value
        @end_value = end_value
        @duration = duration
        @continuous = continuous
        @label = label
        @html_options = html_options
      end

      def call
        tag.div(class: "space-y-6", **@html_options) do
          tag.div(class: "grid grid-cols-1 md:grid-cols-2 gap-6") do
            render_animation_card
          end
        end
      end

      private

      def render_animation_card
        tag.div(class: "text-center p-6 bg-neutral-50 dark:bg-neutral-800/50 rounded-lg border border-black/5 dark:border-white/10") do
          content = []

          if @label
            content << tag.h4(class: "text-sm font-medium text-neutral-600 dark:text-neutral-400 mb-4") { @label }
          end

          content << tag.div(
            class: "text-3xl font-bold text-neutral-900 dark:text-white mb-2",
            data: {
              controller: "animated-number",
              animated_number_start_value: @start_value,
              animated_number_end_value: @end_value,
              animated_number_duration_value: @duration,
              animated_number_continuous_value: @continuous
            }
          )

          safe_join(content)
        end
      end
    end
  end
end
