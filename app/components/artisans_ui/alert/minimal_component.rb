# frozen_string_literal: true

module ArtisansUi
  module Alert
    # Minimal Alert Component (Variant 4)
    # Compact alert without description, just icon and title
    # Supports success, error, and info types
    # Exact RailsBlocks implementation
    #
    # @example Success
    #   <%= render ArtisansUi::Alert::MinimalComponent.new(
    #     title: "Changes saved successfully",
    #     type: :success
    #   ) %>
    #
    # @example Error
    #   <%= render ArtisansUi::Alert::MinimalComponent.new(
    #     title: "Unable to process request",
    #     type: :error
    #   ) %>
    #
    # @example Info
    #   <%= render ArtisansUi::Alert::MinimalComponent.new(
    #     title: "System update scheduled",
    #     type: :info
    #   ) %>
    class MinimalComponent < ApplicationViewComponent
      def initialize(title:, type: :info, **html_options)
        @title = title
        @type = type.to_sym
        @html_options = html_options
      end

      def call
        tag.div(
          class: "rounded-xl border #{border_color} #{bg_color} p-4",
          **@html_options
        ) do
          tag.div(class: "flex gap-2 items-start") do
            safe_join([
              render_icon,
              render_title
            ])
          end
        end
      end

      private

      def render_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          width: "18",
          height: "18",
          viewBox: "0 0 18 18",
          class: "#{icon_color} shrink-0"
        ) do
          tag.g(
            fill: "none",
            "stroke-linecap": "round",
            "stroke-linejoin": "round",
            "stroke-width": "1.5",
            stroke: "currentColor"
          ) do
            case @type
            when :success
              safe_join([
                tag.circle(cx: "9", cy: "9", r: "7.25"),
                tag.polyline(points: "5.75 9.25 8 11.75 12.25 6.25")
              ])
            when :error
              safe_join([
                tag.path(d: "M9 16.25C13.0041 16.25 16.25 13.004 16.25 9C16.25 4.996 13.0041 1.75 9 1.75C4.9959 1.75 1.75 4.996 1.75 9C1.75 13.004 4.9959 16.25 9 16.25Z"),
                tag.path(d: "M9 5.431V9.5"),
                tag.path(d: "M9 13.417C8.448 13.417 8 12.968 8 12.417C8 11.866 8.448 11.417 9 11.417C9.552 11.417 10 11.866 10 12.417C10 12.968 9.552 13.417 9 13.417Z", fill: "currentColor", "data-stroke": "none", stroke: "none")
              ])
            else # :info
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
        tag.div(class: "flex-1") do
          tag.h3(
            class: "text-sm font-medium #{text_color}"
          ) { @title }
        end
      end

      def border_color
        case @type
        when :success then "border-green-200"
        when :error then "border-red-200"
        else "border-neutral-200"
        end
      end

      def bg_color
        case @type
        when :success then "bg-green-50"
        when :error then "bg-red-50"
        else "bg-neutral-50"
        end
      end

      def icon_color
        case @type
        when :success then "text-green-500"
        when :error then "text-red-500"
        else "text-neutral-500"
        end
      end

      def text_color
        case @type
        when :success then "text-green-800"
        when :error then "text-red-800"
        else "text-neutral-800"
        end
      end
    end
  end
end
