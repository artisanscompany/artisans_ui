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
          class: "rounded-xl border border-neutral-200 bg-neutral-50 p-4",
          **@html_options
        ) do
          tag.div(class: "flex gap-2 items-start") do
            safe_join([
              # Icon
              tag.svg(
                xmlns: "http://www.w3.org/2000/svg",
                width: "18",
                height: "18",
                viewBox: "0 0 18 18",
                class: "text-neutral-500 shrink-0"
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
              end,
              # Title and Description container
              tag.div(class: "flex-1") do
                content = [
                  tag.h3(class: "text-sm font-medium text-neutral-800") { @title }
                ]
                if @description
                  content << tag.div(class: "text-sm text-neutral-600 mt-1") { @description }
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
