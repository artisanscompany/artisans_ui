# frozen_string_literal: true

module ArtisansUi
  module Alert
    # Error Alert Component (Variant 2)
    # Red color scheme with warning icon
    # Indicates problems or failures requiring user attention
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Alert::ErrorComponent.new(
    #     title: "Something went wrong!",
    #     description: "Please check your input and try again."
    #   ) %>
    #
    # @example Without description
    #   <%= render ArtisansUi::Alert::ErrorComponent.new(
    #     title: "Error: Unable to save changes"
    #   ) %>
    class ErrorComponent < ApplicationViewComponent
      def initialize(title:, description: nil, **html_options)
        @title = title
        @description = description
        @html_options = html_options
      end

      def call
        tag.div(
          class: "rounded-xl border border-red-200 bg-red-50 p-4 dark:border-red-800 dark:bg-red-900/20",
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
            class: "text-red-500 dark:text-red-400"
          ) do
            tag.g(
              fill: "none",
              "stroke-linecap": "round",
              "stroke-linejoin": "round",
              "stroke-width": "1.5",
              stroke: "currentColor"
            ) do
              safe_join([
                tag.path(d: "M9 16.25C13.0041 16.25 16.25 13.004 16.25 9C16.25 4.996 13.0041 1.75 9 1.75C4.9959 1.75 1.75 4.996 1.75 9C1.75 13.004 4.9959 16.25 9 16.25Z"),
                tag.path(d: "M9 5.431V9.5"),
                tag.path(d: "M9 13.417C8.448 13.417 8 12.968 8 12.417C8 11.866 8.448 11.417 9 11.417C9.552 11.417 10 11.866 10 12.417C10 12.968 9.552 13.417 9 13.417Z", fill: "currentColor", "data-stroke": "none", stroke: "none")
              ])
            end
          end
        end
      end

      def render_title
        tag.h3(
          class: "text-sm font-medium text-red-800 dark:text-red-200"
        ) { @title }
      end

      def render_spacer
        return unless @description

        tag.div
      end

      def render_description
        return unless @description

        tag.div(
          class: "text-sm text-red-700 dark:text-red-300"
        ) { @description }
      end
    end
  end
end
