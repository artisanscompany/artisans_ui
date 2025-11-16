# frozen_string_literal: true

module ArtisansUi
  module Typography
    # Body Component
    # Standard paragraph text for body content
    # Always renders as <p> tag with readable typography
    #
    # @example Large body text
    #   <%= render ArtisansUi::Typography::BodyComponent.new(variant: :large) do %>
    #     This is larger body text for emphasis
    #   <% end %>
    #
    # @example Regular body text
    #   <%= render ArtisansUi::Typography::BodyComponent.new do %>
    #     This is standard paragraph text
    #   <% end %>
    #
    # @example Small body text
    #   <%= render ArtisansUi::Typography::BodyComponent.new(variant: :small) do %>
    #     This is smaller helper text
    #   <% end %>
    #
    # @example Custom styling
    #   <%= render ArtisansUi::Typography::BodyComponent.new(
    #     variant: nil,
    #     class: "text-blue-600 font-semibold"
    #   ) do %>
    #     Custom styled paragraph
    #   <% end %>
    class BodyComponent < ApplicationViewComponent
      VARIANTS = {
        large: "text-base sm:text-lg text-neutral-700 dark:text-neutral-300",
        regular: "text-sm sm:text-base text-neutral-700 dark:text-neutral-300",
        small: "text-xs sm:text-sm text-neutral-600 dark:text-neutral-400"
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
        @html_options.merge(class: [body_classes, custom_class].compact.join(" "))
      end

      def body_classes
        VARIANTS[@variant] if @variant
      end
    end
  end
end
