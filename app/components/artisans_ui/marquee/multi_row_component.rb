# frozen_string_literal: true

module ArtisansUi
  module Marquee
    # Multi-row marquee with different directions for each row
    #
    # @example Two rows with opposite directions
    #   <%= render ArtisansUi::Marquee::MultiRowComponent.new(
    #     title: "Trusted by leading brands",
    #     subtitle: "You're in good company",
    #     rows: [
    #       { direction: "left", content: [...] },
    #       { direction: "right", content: [...] }
    #     ]
    #   ) %>
    class MultiRowComponent < ApplicationViewComponent
      def initialize(title:, subtitle: nil, rows: [], speed: 30, hover_speed: 0, **html_options)
        @title = title
        @subtitle = subtitle
        @rows = rows
        @speed = speed
        @hover_speed = hover_speed
        @html_options = html_options
      end

      def call
        tag.div(class: merge_classes("relative w-full py-16", @html_options[:class]), **@html_options.except(:class)) do
          safe_join([
            header_section,
            rows_container
          ])
        end
      end

      private

      def header_section
        return "" unless @title

        tag.div(class: "mx-auto") do
          tag.div(class: "mx-auto max-w-2xl text-center") do
            safe_join([
              (@subtitle ? tag.h2(@subtitle, class: "text-base leading-7 font-medium text-neutral-500") : nil),
              tag.p(@title, class: "mt-2 text-xl font-bold tracking-tight text-neutral-900 sm:text-2xl lg:text-3xl")
            ].compact)
          end
        end
      end

      def rows_container
        tag.div(class: "mt-8 overflow-hidden") do
          safe_join(
            @rows.map.with_index do |row, index|
              render_row(row, index)
            end
          )
        end
      end

      def render_row(row, index)
        direction = row[:direction] || "left"
        content_items = row[:content] || []
        spacing_class = index < @rows.length - 1 ? "mb-8" : ""

        tag.div(
          data: {
            controller: "marquee",
            marquee_hover_speed_value: @hover_speed,
            marquee_speed_value: @speed,
            marquee_direction_value: direction,
            action: "mouseenter->marquee#pauseAnimation mouseleave->marquee#resumeAnimation"
          },
          class: "relative overflow-hidden #{spacing_class}"
        ) do
          safe_join([
            row_track(content_items),
            gradient_overlay
          ])
        end
      end

      def row_track(content_items)
        tag.div(data: { marquee_target: "track" }, class: "relative flex w-full") do
          tag.div(
            data: { marquee_target: "list" },
            class: "flex shrink-0 flex-nowrap items-center gap-6 px-3 py-1"
          ) do
            safe_join(
              content_items.map { |item| brand_card(item) }
            )
          end
        end
      end

      def brand_card(item)
        tag.div(
          class: "flex min-w-[150px] items-center justify-center rounded-xl border border-black/5 bg-neutral-50 px-6 py-4 shadow-xs transition-all hover:bg-neutral-100"
        ) do
          tag.div(class: "flex items-center space-x-3") do
            safe_join([
              (item[:icon] ? raw(item[:icon]) : nil),
              tag.span(item[:name], class: "text-lg font-medium text-neutral-800")
            ].compact)
          end
        end
      end

      def gradient_overlay
        tag.div(class: "pointer-events-none absolute inset-0 flex items-center justify-between") do
          tag.div(class: "relative h-full w-full") do
            safe_join([
              tag.div(class: "absolute inset-y-0 left-0 w-5 bg-gradient-to-r from-white to-transparent"),
              tag.div(class: "absolute inset-y-0 right-0 w-5 bg-gradient-to-l from-white to-transparent")
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
