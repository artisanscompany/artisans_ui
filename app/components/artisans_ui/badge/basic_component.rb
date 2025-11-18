# frozen_string_literal: true

module ArtisansUi
  module Badge
    # Basic Badge Component (Variant 1)
    # Simple badge with text and color variants
    # Supports neutral, primary, success, error, warning, and info color schemes
    # Exact RailsBlocks implementation
    #
    # @example Basic neutral badge
    #   <%= render ArtisansUi::Badge::BasicComponent.new(text: "Badge") %>
    #
    # @example Success badge
    #   <%= render ArtisansUi::Badge::BasicComponent.new(
    #     text: "Active",
    #     variant: :success
    #   ) %>
    #
    # @example Primary badge
    #   <%= render ArtisansUi::Badge::BasicComponent.new(
    #     text: "New",
    #     variant: :primary
    #   ) %>
    #
    # @example Error badge
    #   <%= render ArtisansUi::Badge::BasicComponent.new(
    #     text: "Error",
    #     variant: :error
    #   ) %>
    class BasicComponent < ApplicationViewComponent
      VARIANTS = {
        neutral: "bg-neutral-100 text-neutral-700",
        primary: "bg-blue-100 text-blue-700",
        success: "bg-green-100 text-green-700",
        error: "bg-red-100 text-red-700",
        warning: "bg-yellow-100 text-yellow-700",
        info: "bg-cyan-100 text-cyan-700"
      }.freeze

      def initialize(text:, variant: :neutral, **html_options)
        @text = text
        @variant = variant.to_sym
        @html_options = html_options

        raise ArgumentError, "Invalid variant: #{@variant}" unless VARIANTS.key?(@variant)
      end

      def call
        tag.span(
          @text,
          class: "inline-flex items-center rounded-md px-2 py-1 text-xs font-medium #{variant_classes}",
          **@html_options
        )
      end

      private

      def variant_classes
        VARIANTS[@variant]
      end
    end
  end
end
