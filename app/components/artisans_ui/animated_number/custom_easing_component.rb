# frozen_string_literal: true

module ArtisansUi
  module AnimatedNumber
    # Custom Easing Animated Number Component (Variant 6)
    # Demonstrates different easing functions for animations
    # Exact RailsBlocks implementation
    #
    # @example Linear easing
    #   <%= render ArtisansUi::AnimatedNumber::CustomEasingComponent.new(
    #     start_value: 0,
    #     end_value: 1000,
    #     duration: 2000,
    #     spin_easing: "linear",
    #     transform_easing: "linear",
    #     label: "Linear",
    #     description: "Constant speed"
    #   ) %>
    #
    # @example Bounce easing
    #   <%= render ArtisansUi::AnimatedNumber::CustomEasingComponent.new(
    #     start_value: 0,
    #     end_value: 1000,
    #     duration: 2000,
    #     spin_easing: "cubic-bezier(0.68, -0.55, 0.265, 1.55)",
    #     transform_easing: "cubic-bezier(0.68, -0.55, 0.265, 1.55)",
    #     label: "Bounce",
    #     description: "Overshoots & settles"
    #   ) %>
    class CustomEasingComponent < ApplicationViewComponent
      def initialize(
        start_value: 0,
        end_value: 1000,
        duration: 2000,
        spin_easing: "ease-in-out",
        transform_easing: "ease-in-out",
        trigger: "viewport",
        label: nil,
        description: nil,
        **html_options
      )
        @start_value = start_value
        @end_value = end_value
        @duration = duration
        @spin_easing = spin_easing
        @transform_easing = transform_easing
        @trigger = trigger
        @label = label
        @description = description
        @html_options = html_options
      end

      def call
        tag.div(class: "group", **@html_options) do
          content = []

          if @label
            content << tag.h4(class: "text-sm font-medium text-neutral-700 dark:text-neutral-300 mb-3") { @label }
          end

          content << tag.div(
            class: "bg-neutral-50 dark:bg-neutral-800/50 rounded-lg p-4 text-center group-hover:bg-neutral-100 border border-black/5 dark:border-white/10 dark:group-hover:bg-neutral-700 transition-colors cursor-pointer",
            onclick: "this.querySelector('[data-controller]')?.click()"
          ) do
            inner_content = [
              tag.button(
                class: "text-3xl font-bold text-neutral-900 dark:text-white",
                data: {
                  controller: "animated-number",
                  animated_number_start_value: @start_value,
                  animated_number_end_value: @end_value,
                  animated_number_duration_value: @duration,
                  animated_number_spin_easing_value: @spin_easing,
                  animated_number_transform_easing_value: @transform_easing,
                  animated_number_trigger_value: @trigger,
                  action: "click->animated-number#triggerAnimation"
                }
              )
            ]

            if @description
              inner_content << tag.p(class: "text-xs text-neutral-500 dark:text-neutral-400 mt-2") { @description }
            end

            safe_join(inner_content)
          end

          safe_join(content)
        end
      end
    end
  end
end
