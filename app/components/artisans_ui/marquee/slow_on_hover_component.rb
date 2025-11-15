# frozen_string_literal: true

module ArtisansUi
  module Marquee
    # Marquee that slows down on hover instead of pausing
    #
    # @example Slow down on hover (40s vs 15s normal speed)
    #   <%= render ArtisansUi::Marquee::SlowOnHoverComponent.new(
    #     speed: 15,
    #     hover_speed: 40,
    #     direction: "left"
    #   ) do %>
    #     <!-- Content -->
    #   <% end %>
    class SlowOnHoverComponent < ApplicationViewComponent
      def initialize(speed: 15, hover_speed: 40, direction: "left", **html_options)
        @speed = speed
        @hover_speed = hover_speed
        @direction = direction
        @html_options = html_options
      end

      def call
        tag.div(
          data: {
            controller: "marquee",
            marquee_speed_value: @speed,
            marquee_hover_speed_value: @hover_speed,
            marquee_direction_value: @direction,
            action: "mouseenter->marquee#pauseAnimation mouseleave->marquee#resumeAnimation"
          },
          class: merge_classes("relative overflow-hidden bg-transparent py-4", @html_options[:class]),
          **@html_options.except(:class)
        ) do
          safe_join([
            track_container,
            gradient_overlay
          ])
        end
      end

      private

      def track_container
        tag.div(
          data: { marquee_target: "track" },
          class: "relative flex w-full"
        ) do
          tag.div(
            data: { marquee_target: "list" },
            class: "flex w-full shrink-0 flex-nowrap items-center justify-around gap-8 px-4"
          ) do
            content
          end
        end
      end

      def gradient_overlay
        tag.div(class: "flex pointer-events-none absolute inset-0 justify-between items-center") do
          tag.div(class: "relative h-full w-full") do
            safe_join([
              tag.div(class: "w-5 bg-gradient-to-r from-white dark:from-[#080808] to-transparent absolute left-0 inset-y-0"),
              tag.div(class: "w-5 bg-gradient-to-l from-white dark:from-[#080808] to-transparent absolute right-0 inset-y-0")
            ])
          end
        end
      end

      def merge_classes(*classes)
        classes.compact.join(" ")
      end
    end
  end
end
