# frozen_string_literal: true

module ArtisansUi
  module Typography
    # Subheading Component
    # Paragraph text optimized for descriptions and subtitles
    # Always renders as <p> tag with muted colors
    #
    # @example Large subheading
    #   <%= render ArtisansUi::Typography::SubheadingComponent.new(variant: :large) do %>
    #     Search jobs using natural language
    #   <% end %>
    #
    # @example Regular subheading
    #   <%= render ArtisansUi::Typography::SubheadingComponent.new do %>
    #     This is a regular description
    #   <% end %>
    #
    # @example Custom styling
    #   <%= render ArtisansUi::Typography::SubheadingComponent.new(
    #     variant: nil,
    #     class: "text-lg text-blue-600"
    #   ) do %>
    #     Custom subheading
    #   <% end %>
    class SubheadingComponent < ApplicationViewComponent
      VARIANTS = {
        large: "text-lg sm:text-xl text-neutral-600 dark:text-neutral-400",
        regular: "text-base text-neutral-600 dark:text-neutral-400",
        small: "text-sm text-neutral-600 dark:text-neutral-400"
      }.freeze

      def initialize(variant: :regular, **html_options)
        @variant = variant&.to_sym
        @html_options = html_options

        validate_params!
      end

      def call
        tag.p(**merged_options) do
          content
        end
      end

      private

      def validate_params!
        if @variant && !VARIANTS.key?(@variant)
          raise ArgumentError, "Invalid variant: #{@variant}"
        end
      end

      def merged_options
        custom_class = @html_options.delete(:class)
        @html_options.merge(class: [subheading_classes, custom_class].compact.join(" "))
      end

      def subheading_classes
        VARIANTS[@variant] if @variant
      end
    end
  end
end
