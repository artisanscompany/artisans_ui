# frozen_string_literal: true

module ArtisansUi
  module Button
    # Icon-Only Button Component
    # Compact button design containing only an icon (no text)
    # Perfect for toolbars, action buttons, and space-constrained interfaces
    # Supports multiple color variants and sizes
    #
    # @example Neutral icon-only button
    #   <%= render ArtisansUi::Button::IconOnlyComponent.new do %>
    #     <svg class="size-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
    #       <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
    #     </svg>
    #   <% end %>
    #
    # @example Colored icon-only button
    #   <%= render ArtisansUi::Button::IconOnlyComponent.new(variant: :colored) do %>
    #     <svg class="size-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
    #       <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
    #     </svg>
    #   <% end %>
    #
    # @example Small icon-only button
    #   <%= render ArtisansUi::Button::IconOnlyComponent.new(size: :small) do %>
    #     <svg class="size-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
    #       <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
    #     </svg>
    #   <% end %>
    #
    # @example Tiny icon-only button
    #   <%= render ArtisansUi::Button::IconOnlyComponent.new(size: :tiny) do %>
    #     <svg class="size-3" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
    #       <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
    #     </svg>
    #   <% end %>
    #
    # @example Disabled icon-only button
    #   <%= render ArtisansUi::Button::IconOnlyComponent.new(disabled: true) do %>
    #     <svg class="size-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
    #       <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
    #     </svg>
    #   <% end %>
    class IconOnlyComponent < ApplicationViewComponent
      VARIANTS = {
        neutral: "border-neutral-400/30 bg-neutral-800 text-white hover:bg-neutral-700 focus-visible:outline-neutral-600 dark:bg-white dark:text-neutral-800 dark:hover:bg-neutral-100 dark:focus-visible:outline-neutral-200",
        colored: "border-blue-400/30 bg-blue-600 text-white hover:bg-blue-500 focus-visible:outline-neutral-600 dark:focus-visible:outline-neutral-200",
        secondary: "border-neutral-200 bg-white/90 text-neutral-800 shadow-xs hover:bg-neutral-50 focus-visible:outline-neutral-600 dark:border-neutral-700 dark:bg-neutral-800/50 dark:text-neutral-50 dark:hover:bg-neutral-700/50 dark:focus-visible:outline-neutral-200",
        danger: "border-red-300/30 bg-red-600 text-white hover:bg-red-500 focus-visible:outline-neutral-600 dark:focus-visible:outline-neutral-200"
      }.freeze

      SIZES = {
        regular: "p-2.5",
        small: "p-2",
        tiny: "p-1.5"
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
