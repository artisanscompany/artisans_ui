# frozen_string_literal: true

module ArtisansUi
  module Badge
    # Notification Badge Component (Variant 6)
    # Small, compact badge typically used for notification counts
    # Positioned absolutely over parent elements (e.g., icons, avatars)
    # Supports zero-width display for empty/zero values
    # Exact RailsBlocks implementation
    #
    # @example Basic notification badge
    #   <%= render ArtisansUi::Badge::NotificationComponent.new(count: 3) %>
    #
    # @example High count badge
    #   <%= render ArtisansUi::Badge::NotificationComponent.new(count: 99) %>
    #
    # @example Badge with max display (99+)
    #   <%= render ArtisansUi::Badge::NotificationComponent.new(
    #     count: 150,
    #     max: 99
    #   ) %>
    #
    # @example Error variant notification
    #   <%= render ArtisansUi::Badge::NotificationComponent.new(
    #     count: 5,
    #     variant: :error
    #   ) %>
    #
    # @example Hidden when zero
    #   <%= render ArtisansUi::Badge::NotificationComponent.new(
    #     count: 0,
    #     show_zero: false
    #   ) %>
    class NotificationComponent < ApplicationViewComponent
      VARIANTS = {
        error: "bg-red-500 text-white",
        primary: "bg-blue-500 text-white",
        success: "bg-green-500 text-white",
        warning: "bg-yellow-500 text-white",
        neutral: "bg-neutral-500 text-white"
      }.freeze

      def initialize(count:, variant: :error, max: nil, show_zero: true, **html_options)
        @count = count.to_i
        @variant = variant.to_sym
        @max = max&.to_i
        @show_zero = show_zero
        @html_options = html_options

        raise ArgumentError, "Invalid variant: #{@variant}" unless VARIANTS.key?(@variant)
      end

      def call
        return "" if @count.zero? && !@show_zero

        tag.span(
          display_count,
          class: "inline-flex items-center justify-center rounded-full px-1.5 py-0.5 text-xs font-medium leading-none min-w-[1.25rem] #{variant_classes}",
          **@html_options
        )
      end

      private

      def variant_classes
        VARIANTS[@variant]
      end

      def display_count
        return @count.to_s if @max.nil? || @count <= @max

        "#{@max}+"
      end
    end
  end
end
