# frozen_string_literal: true

module ArtisansUi
  module Badge
    # Rounded Pill Badge Component (Variant 4)
    # Badge with fully rounded borders for a pill-like appearance
    # Similar to BasicComponent but with rounded-full instead of rounded-md
    # Exact RailsBlocks implementation
    #
    # @example Basic pill badge
    #   <%= render ArtisansUi::Badge::RoundedPillComponent.new(text: "Pill") %>
    #
    # @example Success pill badge
    #   <%= render ArtisansUi::Badge::RoundedPillComponent.new(
    #     text: "Active",
    #     variant: :success
    #   ) %>
    #
    # @example Primary pill badge
    #   <%= render ArtisansUi::Badge::RoundedPillComponent.new(
    #     text: "New",
    #     variant: :primary
    #   ) %>
    class RoundedPillComponent < ApplicationViewComponent
      VARIANTS = {
        neutral: "bg-neutral-100 text-neutral-700",
        primary: "bg-blue-100 text-blue-700",
        success: "bg-green-100 text-green-700",
        error: "bg-red-100 text-red-700",
        warning: "bg-yellow-100 text-yellow-700",
        info: "bg-cyan-100 text-cyan-700",
        sky: "bg-sky-100 text-sky-800",
        violet: "bg-violet-100 text-violet-800",
        orange: "bg-orange-100 text-orange-700"
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
          class: "inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium #{variant_classes}",
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
