# frozen_string_literal: true

module ArtisansUi
  module Alert
    # Success Alert Component (Variant 1)
    # Green color scheme with checkmark icon
    # Confirms successful actions with title and optional description
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Alert::SuccessComponent.new(
    #     title: "Success! Your changes have been saved",
    #     description: "This is an alert with icon, title and description."
    #   ) %>
    #
    # @example Without description
    #   <%= render ArtisansUi::Alert::SuccessComponent.new(
    #     title: "Success! Your changes have been saved"
    #   ) %>
    class SuccessComponent < ApplicationViewComponent
      def initialize(title:, description: nil, **html_options)
        @title = title
        @description = description
        @html_options = html_options
      end

      def call
        tag.div(
          class: "rounded-xl border border-green-200 bg-green-50 p-4 dark:border-green-800 dark:bg-green-900/20",
          **@html_options
        ) do
          tag.div(class: "grid grid-cols-[auto_1fr] gap-2 items-start") do
            safe_join([
              # Column 1: Icon
              tag.div(class: "flex items-center h-full") do
                tag.svg(
                  xmlns: "http://www.w3.org/2000/svg",
                  width: "18",
                  height: "18",
                  viewBox: "0 0 18 18",
                  class: "text-green-500 dark:text-green-400"
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
                      tag.polyline(points: "5.75 9.25 8 11.75 12.25 6.25")
                    ])
                  end
                end
              end,
              # Column 2: Title and Description container
              tag.div do
                content = [
                  tag.h3(class: "text-sm font-medium text-green-800 dark:text-green-200") { @title }
                ]
                if @description
                  content << tag.div(class: "text-sm text-green-700 dark:text-green-300") { @description }
                end
                safe_join(content)
              end
            ])
          end
        end
      end
    end
  end
end
