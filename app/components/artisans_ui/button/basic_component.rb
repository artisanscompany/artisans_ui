# frozen_string_literal: true

module ArtisansUi
  module Button
    # Basic Button Component (Variant 1)
    # Standard button with clean, simple design
    # Supports multiple color variants, sizes, and states
    # Exact RailsBlocks implementation
    #
    # @example Neutral button
    #   <%= render ArtisansUi::Button::BasicComponent.new do %>
    #     Neutral Button
    #   <% end %>
    #
    # @example Colored (blue) button
    #   <%= render ArtisansUi::Button::BasicComponent.new(variant: :colored) do %>
    #     Colored Button
    #   <% end %>
    #
    # @example Secondary (white) button
    #   <%= render ArtisansUi::Button::BasicComponent.new(variant: :secondary) do %>
    #     Secondary Button
    #   <% end %>
    #
    # @example Danger (red) button
    #   <%= render ArtisansUi::Button::BasicComponent.new(variant: :danger) do %>
    #     Delete Button
    #   <% end %>
    #
    # @example Small button
    #   <%= render ArtisansUi::Button::BasicComponent.new(size: :small) do %>
    #     Small Button
    #   <% end %>
    #
    # @example Disabled button
    #   <%= render ArtisansUi::Button::BasicComponent.new(disabled: true) do %>
    #     Disabled Button
    #   <% end %>
    class BasicComponent < ApplicationViewComponent
      VARIANTS = {
        neutral: "border-neutral-400/30 bg-neutral-800 text-white hover:bg-neutral-700 focus-visible:outline-neutral-600 dark:bg-white dark:text-neutral-800 dark:hover:bg-neutral-100 dark:focus-visible:outline-neutral-200",
        colored: "border-blue-400/30 bg-blue-600 text-white hover:bg-blue-500 focus-visible:outline-neutral-600 dark:focus-visible:outline-neutral-200",
        secondary: "border-neutral-200 bg-white/90 text-neutral-800 shadow-xs hover:bg-neutral-50 focus-visible:outline-neutral-600 dark:border-neutral-700 dark:bg-neutral-800/50 dark:text-neutral-50 dark:hover:bg-neutral-700/50 dark:focus-visible:outline-neutral-200",
        danger: "border-red-300/30 bg-red-600 text-white hover:bg-red-500 focus-visible:outline-neutral-600 dark:focus-visible:outline-neutral-200"
      }.freeze

      SIZES = {
        regular: "px-3.5 py-2 text-sm",
        small: "px-3 py-2 text-xs"
      }.freeze

      def initialize(variant: :neutral, size: :regular, disabled: false, **html_options)
        @variant = variant.to_sym
        @size = size.to_sym
        @disabled = disabled
        @html_options = html_options

        validate_params!
      end

      def call
        tag.button(
          content,
          type: "button",
          disabled: @disabled,
          class: button_classes,
          **@html_options
        )
      end

      private

      def validate_params!
        raise ArgumentError, "Invalid variant: #{@variant}" unless VARIANTS.key?(@variant)
        raise ArgumentError, "Invalid size: #{@size}" unless SIZES.key?(@size)
      end

      def button_classes
        [
          base_classes,
          SIZES[@size],
          VARIANTS[@variant]
        ].join(" ")
      end

      def base_classes
        "flex items-center justify-center gap-1.5 rounded-lg border shadow-sm transition-all duration-100 ease-in-out select-none font-medium whitespace-nowrap focus-visible:outline-2 focus-visible:outline-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
      end
    end
  end
end
