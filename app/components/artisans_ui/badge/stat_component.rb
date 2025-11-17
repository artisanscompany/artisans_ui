# frozen_string_literal: true

module ArtisansUi
  module Badge
    # Stat Badge Component
    # Compact badge for displaying statistics with label and value
    # Shows label and emphasized value in a badge format
    # Supports all color variants for visual distinction
    #
    # @example Basic stat badge
    #   <%= render ArtisansUi::Badge::StatComponent.new(
    #     label: "Total Users",
    #     value: "1,234"
    #   ) %>
    #
    # @example Success variant
    #   <%= render ArtisansUi::Badge::StatComponent.new(
    #     label: "Success Rate",
    #     value: "98%",
    #     variant: :success
    #   ) %>
    #
    # @example Primary variant
    #   <%= render ArtisansUi::Badge::StatComponent.new(
    #     label: "Applications",
    #     value: "42",
    #     variant: :primary
    #   ) %>
    class StatComponent < ApplicationViewComponent
      VARIANTS = {
        neutral: "bg-neutral-100 text-neutral-700 dark:bg-neutral-700 dark:text-neutral-300",
        primary: "bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-300",
        success: "bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-300",
        error: "bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-300",
        warning: "bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-300",
        info: "bg-cyan-100 text-cyan-700 dark:bg-cyan-900/30 dark:text-cyan-300"
      }.freeze

      def initialize(label:, value:, variant: :neutral, **html_options)
        @label = label
        @value = value
        @variant = variant.to_sym
        @html_options = html_options

        raise ArgumentError, "Invalid variant: #{@variant}" unless VARIANTS.key?(@variant)
      end

      def call
        tag.span(
          class: "inline-flex items-center gap-1.5 rounded-md px-3 py-1.5 text-xs sm:text-sm #{variant_classes}",
          **@html_options
        ) do
          safe_join([
            tag.span(@label, class: "font-medium"),
            tag.span(":", class: "font-medium"),
            tag.span(@value, class: "font-bold")
          ])
        end
      end

      private

      def variant_classes
        VARIANTS[@variant]
      end
    end
  end
end
