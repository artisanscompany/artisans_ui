# frozen_string_literal: true

module ArtisansUi
  module AnimatedNumber
    # Basic Animated Number Component (Variant 1)
    # Simple counter animation from start to end value
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::AnimatedNumber::BasicComponent.new(
    #     start_value: 0,
    #     end_value: 1250,
    #     duration: 2000,
    #     label: "Users registered"
    #   ) %>
    #
    # @example Without label
    #   <%= render ArtisansUi::AnimatedNumber::BasicComponent.new(
    #     start_value: 0,
    #     end_value: 100
    #   ) %>
    class BasicComponent < ApplicationViewComponent
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
              tag.div(class: "text-4xl font-bold text-neutral-800 mb-2") do
                tag.span(
                  data: {
                    controller: "animated-number",
                    animated_number_start_value: @start_value,
                    animated_number_end_value: @end_value,
                    animated_number_duration_value: @duration
                  }
                )
              end
            ]

            if @label
              content << tag.p(class: "text-sm text-neutral-600") { @label }
            end

            safe_join(content)
          end
        end
      end
    end
  end
end
