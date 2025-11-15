# frozen_string_literal: true

module ArtisansUi
  module Badge
    # Color Variant Badge Component (Variant 2)
    # Demonstrates explicit color options with both solid and soft variants
    # Supports a wide range of colors: red, green, blue, yellow, purple, pink, indigo, orange
    # Exact RailsBlocks implementation
    #
    # @example Red solid badge
    #   <%= render ArtisansUi::Badge::ColorVariantComponent.new(
    #     text: "Red",
    #     color: :red
    #   ) %>
    #
    # @example Green soft badge
    #   <%= render ArtisansUi::Badge::ColorVariantComponent.new(
    #     text: "Green",
    #     color: :green,
    #     style: :soft
    #   ) %>
    #
    # @example Blue solid badge
    #   <%= render ArtisansUi::Badge::ColorVariantComponent.new(
    #     text: "Blue",
    #     color: :blue,
    #     style: :solid
    #   ) %>
    class ColorVariantComponent < ApplicationViewComponent
      SOLID_COLORS = {
        red: "bg-red-500 text-white",
        green: "bg-green-500 text-white",
        blue: "bg-blue-500 text-white",
        yellow: "bg-yellow-500 text-white",
        purple: "bg-purple-500 text-white",
        pink: "bg-pink-500 text-white",
        indigo: "bg-indigo-500 text-white",
        orange: "bg-orange-500 text-white",
        neutral: "bg-neutral-500 text-white"
      }.freeze

      SOFT_COLORS = {
        red: "bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-300",
        green: "bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-300",
        blue: "bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-300",
        yellow: "bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-300",
        purple: "bg-purple-100 text-purple-700 dark:bg-purple-900/30 dark:text-purple-300",
        pink: "bg-pink-100 text-pink-700 dark:bg-pink-900/30 dark:text-pink-300",
        indigo: "bg-indigo-100 text-indigo-700 dark:bg-indigo-900/30 dark:text-indigo-300",
        orange: "bg-orange-100 text-orange-700 dark:bg-orange-900/30 dark:text-orange-300",
        neutral: "bg-neutral-100 text-neutral-700 dark:bg-neutral-700 dark:text-neutral-300"
      }.freeze

      def initialize(text:, color: :neutral, style: :soft, **html_options)
        @text = text
        @color = color.to_sym
        @style = style.to_sym
        @html_options = html_options

        validate_params!
      end

      def call
        tag.span(
          @text,
          class: "inline-flex items-center rounded-md px-2 py-1 text-xs font-medium #{color_classes}",
          **@html_options
        )
      end

      private

      def validate_params!
        raise ArgumentError, "Invalid color: #{@color}" unless valid_color?
        raise ArgumentError, "Invalid style: #{@style}. Must be :solid or :soft" unless %i[solid soft].include?(@style)
      end

      def valid_color?
        SOLID_COLORS.key?(@color) && SOFT_COLORS.key?(@color)
      end

      def color_classes
        @style == :solid ? SOLID_COLORS[@color] : SOFT_COLORS[@color]
      end
    end
  end
end
