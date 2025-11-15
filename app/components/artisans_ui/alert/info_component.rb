# frozen_string_literal: true

module ArtisansUi
  module Alert
    # Info/Neutral Alert Component (Variant 3)
    # Neutral gray color scheme with information icon
    # General information updates without urgent action needed
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Alert::InfoComponent.new(
    #     title: "Information",
    #     description: "This is a neutral alert for general information or updates."
    #   ) %>
    #
    # @example Without description
    #   <%= render ArtisansUi::Alert::InfoComponent.new(
    #     title: "System maintenance scheduled"
    #   ) %>
    class InfoComponent < ApplicationViewComponent
      def initialize(title:, description: nil, **html_options)
        @title = title
        @description = description
        @html_options = html_options
      end

      def call
        tag.div(
          class: "rounded-xl border border-neutral-200 bg-neutral-50 p-4 dark:border-neutral-700 dark:bg-neutral-800/50",
          **@html_options
        ) do
          tag.div(class: "grid grid-cols-[auto_1fr] gap-2 items-start") do
            safe_join([
              render_icon,
              render_title,
              render_spacer,
              render_description
            ].compact)
          end
        end
      end

      private

      def render_icon
        tag.div(class: "flex items-center h-full") do
          tag.svg(
            xmlns: "http://www.w3.org/2000/svg",
            width: "18",
            height: "18",
            viewBox: "0 0 18 18",
            class: "text-neutral-500 dark:text-neutral-400"
          ) do
            tag.g(
              fill: "none",
              "stroke-linecap": "round",
              "stroke-linejoin": "round",
              "stroke-width": "1.5",
              stroke: "currentColor"
            ) do
              safe_join([
                tag.circle(cx: "9", cy: "9", r: "7.25"),
                tag.path(d: "M9 5.75V9.25"),
                tag.path(d: "M9 12.25H9.0075")
              ])
            end
          end
        end
      end

      def render_title
        tag.h3(
          class: "text-sm font-medium text-neutral-800 dark:text-neutral-200"
        ) { @title }
      end

      def render_spacer
        return unless @description

        tag.div
      end

      def render_description
        return unless @description

        tag.div(
          class: "text-sm text-neutral-600 dark:text-neutral-400"
        ) { @description }
      end
    end
  end
end
