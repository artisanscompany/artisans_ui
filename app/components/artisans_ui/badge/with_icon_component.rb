# frozen_string_literal: true

module ArtisansUi
  module Badge
    # Badge with Icon Component (Variant 3)
    # Badge displaying an SVG icon alongside text
    # Supports icon positioning (left or right) and all color variants
    # Exact RailsBlocks implementation
    #
    # @example Badge with left icon
    #   <%= render ArtisansUi::Badge::WithIconComponent.new(
    #     text: "Active",
    #     variant: :success,
    #     icon_position: :left
    #   ) %>
    #
    # @example Badge with right icon
    #   <%= render ArtisansUi::Badge::WithIconComponent.new(
    #     text: "New Feature",
    #     variant: :primary,
    #     icon_position: :right
    #   ) %>
    #
    # @example Badge with custom icon
    #   <%= render ArtisansUi::Badge::WithIconComponent.new(
    #     text: "Alert",
    #     variant: :error,
    #     icon_type: :alert
    #   ) %>
    class WithIconComponent < ApplicationViewComponent
      VARIANTS = {
        neutral: "bg-neutral-100 text-neutral-700 dark:bg-neutral-700 dark:text-neutral-300",
        primary: "bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-300",
        success: "bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-300",
        error: "bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-300",
        warning: "bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-300",
        info: "bg-cyan-100 text-cyan-700 dark:bg-cyan-900/30 dark:text-cyan-300"
      }.freeze

      ICON_TYPES = %i[check star alert info].freeze

      def initialize(text:, variant: :neutral, icon_position: :left, icon_type: :check, **html_options)
        @text = text
        @variant = variant.to_sym
        @icon_position = icon_position.to_sym
        @icon_type = icon_type.to_sym
        @html_options = html_options

        validate_params!
      end

      def call
        tag.span(
          class: "inline-flex items-center gap-1.5 rounded-md px-2 py-1 text-xs font-medium #{variant_classes}",
          **@html_options
        ) do
          if @icon_position == :left
            safe_join([icon_svg, tag.span(@text)])
          else
            safe_join([tag.span(@text), icon_svg])
          end
        end
      end

      private

      def validate_params!
        raise ArgumentError, "Invalid variant: #{@variant}" unless VARIANTS.key?(@variant)
        raise ArgumentError, "Invalid icon_position: #{@icon_position}. Must be :left or :right" unless %i[left right].include?(@icon_position)
        raise ArgumentError, "Invalid icon_type: #{@icon_type}" unless ICON_TYPES.include?(@icon_type)
      end

      def variant_classes
        VARIANTS[@variant]
      end

      def icon_svg
        case @icon_type
        when :check
          check_icon
        when :star
          star_icon
        when :alert
          alert_icon
        when :info
          info_icon
        end
      end

      def check_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          width: "12",
          height: "12",
          viewBox: "0 0 12 12",
          fill: "none",
          class: "shrink-0"
        ) do
          tag.path(
            d: "M10 3L4.5 8.5L2 6",
            stroke: "currentColor",
            "stroke-width": "1.5",
            "stroke-linecap": "round",
            "stroke-linejoin": "round"
          )
        end
      end

      def star_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          width: "12",
          height: "12",
          viewBox: "0 0 12 12",
          fill: "currentColor",
          class: "shrink-0"
        ) do
          tag.path(
            d: "M6 1L7.545 4.13L11 4.635L8.5 7.07L9.09 10.5L6 8.885L2.91 10.5L3.5 7.07L1 4.635L4.455 4.13L6 1Z"
          )
        end
      end

      def alert_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          width: "12",
          height: "12",
          viewBox: "0 0 12 12",
          fill: "none",
          class: "shrink-0"
        ) do
          safe_join([
            tag.circle(
              cx: "6",
              cy: "6",
              r: "5",
              stroke: "currentColor",
              "stroke-width": "1.5"
            ),
            tag.path(
              d: "M6 3.5V6.5",
              stroke: "currentColor",
              "stroke-width": "1.5",
              "stroke-linecap": "round"
            ),
            tag.circle(
              cx: "6",
              cy: "8.5",
              r: "0.5",
              fill: "currentColor"
            )
          ])
        end
      end

      def info_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          width: "12",
          height: "12",
          viewBox: "0 0 12 12",
          fill: "none",
          class: "shrink-0"
        ) do
          safe_join([
            tag.circle(
              cx: "6",
              cy: "6",
              r: "5",
              stroke: "currentColor",
              "stroke-width": "1.5"
            ),
            tag.path(
              d: "M6 5.5V8.5",
              stroke: "currentColor",
              "stroke-width": "1.5",
              "stroke-linecap": "round"
            ),
            tag.circle(
              cx: "6",
              cy: "3.5",
              r: "0.5",
              fill: "currentColor"
            )
          ])
        end
      end
    end
  end
end
