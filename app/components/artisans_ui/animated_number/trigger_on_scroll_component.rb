# frozen_string_literal: true

module ArtisansUi
  module AnimatedNumber
    # Trigger on Scroll Animated Number Component (Variant 7)
    # Counter that animates when element enters viewport or on page load
    # Exact RailsBlocks implementation
    #
    # @example Trigger on load
    #   <%= render ArtisansUi::AnimatedNumber::TriggerOnScrollComponent.new(
    #     start_value: 0,
    #     end_value: 100000,
    #     duration: 3500,
    #     trigger: "load",
    #     suffix: "+",
    #     label: "Lines of code",
    #     hint: "Press \"Refresh\" button to trigger animation"
    #   ) %>
    #
    # @example Trigger on viewport (default)
    #   <%= render ArtisansUi::AnimatedNumber::TriggerOnScrollComponent.new(
    #     start_value: 0,
    #     end_value: 5000,
    #     suffix: "+",
    #     label: "Active users"
    #   ) %>
    class TriggerOnScrollComponent < ApplicationViewComponent
      def initialize(
        start_value: 0,
        end_value: 0,
        duration: 3500,
        trigger: "load",
        suffix: nil,
        label: nil,
        hint: nil,
        **html_options
      )
        @start_value = start_value
        @end_value = end_value
        @duration = duration
        @trigger = trigger
        @suffix = suffix
        @label = label
        @hint = hint
        @html_options = html_options
      end

      def call
        tag.div(class: "space-y-4", **@html_options) do
          tag.div(class: "text-center") do
            content = [
              tag.div(class: "text-5xl font-bold mb-2") do
                tag.span(
                  data: {
                    controller: "animated-number",
                    animated_number_start_value: @start_value,
                    animated_number_end_value: @end_value,
                    animated_number_duration_value: @duration,
                    animated_number_trigger_value: @trigger,
                    animated_number_suffix_value: @suffix
                  }.compact
                )
              end
            ]

            if @label
              content << tag.p(class: "text-sm text-neutral-800 dark:text-neutral-200") { @label }
            end

            if @hint
              content << tag.p(class: "text-xs text-neutral-600 dark:text-neutral-400 mt-2") { @hint }
            end

            safe_join(content)
          end
        end
      end
    end
  end
end
