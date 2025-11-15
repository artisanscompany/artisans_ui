# frozen_string_literal: true

module ArtisansUi
  module Button
    # Button With Icon Component
    # Button with text and an accompanying icon
    # Icon can be positioned on either left or right side of the text
    # Supports all standard button variants and sizes
    #
    # @example Button with icon on left (default)
    #   <%= render ArtisansUi::Button::WithIconComponent.new(
    #     text: "Add Item",
    #     icon: '<svg class="size-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" /></svg>'
    #   ) %>
    #
    # @example Button with icon on right
    #   <%= render ArtisansUi::Button::WithIconComponent.new(
    #     text: "Continue",
    #     icon: '<svg class="size-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" /></svg>',
    #     icon_position: :right
    #   ) %>
    #
    # @example Colored button with icon
    #   <%= render ArtisansUi::Button::WithIconComponent.new(
    #     text: "Save",
    #     icon: '<svg class="size-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" /></svg>',
    #     variant: :colored
    #   ) %>
    #
    # @example Small button with icon
    #   <%= render ArtisansUi::Button::WithIconComponent.new(
    #     text: "Delete",
    #     icon: '<svg class="size-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" /></svg>',
    #     variant: :danger,
    #     size: :small
    #   ) %>
    #
    # @example Disabled button with icon
    #   <%= render ArtisansUi::Button::WithIconComponent.new(
    #     text: "Processing",
    #     icon: '<svg class="size-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>',
    #     disabled: true
    #   ) %>
    class WithIconComponent < ApplicationViewComponent
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

      ICON_POSITIONS = [:left, :right].freeze

      def initialize(text:, icon:, icon_position: :left, variant: :neutral, size: :regular, disabled: false, **html_options)
        @text = text
        @icon = icon
        @icon_position = icon_position.to_sym
        @variant = variant.to_sym
        @size = size.to_sym
        @disabled = disabled
        @html_options = html_options

        validate_params!
      end

      def call
        tag.button(
          button_content,
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
        raise ArgumentError, "Invalid icon_position: #{@icon_position}" unless ICON_POSITIONS.include?(@icon_position)
      end

      def button_content
        if @icon_position == :left
          safe_join([icon_html, @text], " ")
        else
          safe_join([@text, icon_html], " ")
        end
      end

      def icon_html
        @icon.html_safe
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
