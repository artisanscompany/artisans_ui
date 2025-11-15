# frozen_string_literal: true

module ArtisansUi
  module Marquee
    # Basic scrolling marquee component with pause on hover
    #
    # @example Basic usage with logos
    #   <%= render ArtisansUi::Marquee::BasicComponent.new(speed: 15) do %>
    #     <div class="flex items-center space-x-2">
    #       <!-- Logo content -->
    #     </div>
    #   <% end %>
    #
    # @example With custom direction
    #   <%= render ArtisansUi::Marquee::BasicComponent.new(
    #     speed: 20,
    #     direction: "right",
    #     pause_on_hover: false
    #   ) do %>
    #     <!-- Content -->
    #   <% end %>
    class BasicComponent < ApplicationViewComponent
      def initialize(speed: 15, direction: "left", hover_speed: 0, pause_on_hover: true, **html_options)
        @speed = speed
        @direction = direction
        @hover_speed = hover_speed
        @pause_on_hover = pause_on_hover
        @html_options = html_options
      end

      def call
        tag.div(
          data: {
            controller: "marquee",
            marquee_speed_value: @speed,
            marquee_hover_speed_value: @hover_speed,
            marquee_direction_value: @direction,
            action: @pause_on_hover ? "mouseenter->marquee#pauseAnimation mouseleave->marquee#resumeAnimation" : nil
          }.compact,
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
