# frozen_string_literal: true

module ArtisansUi
  module Button
    # Loading Button Component
    # Button with loading state that displays a spinner when processing
    # Automatically disables the button when in loading state
    # Supports all standard button variants and sizes
    #
    # @example Normal state (not loading)
    #   <%= render ArtisansUi::Button::LoadingComponent.new(text: "Submit", loading: false) %>
    #
    # @example Loading state
    #   <%= render ArtisansUi::Button::LoadingComponent.new(text: "Submit", loading: true) %>
    #
    # @example Loading with custom loading text
    #   <%= render ArtisansUi::Button::LoadingComponent.new(
    #     text: "Submit",
    #     loading: true,
    #     loading_text: "Submitting..."
    #   ) %>
    #
    # @example Colored loading button
    #   <%= render ArtisansUi::Button::LoadingComponent.new(
    #     text: "Save",
    #     loading: true,
    #     variant: :colored
    #   ) %>
    #
    # @example Small loading button
    #   <%= render ArtisansUi::Button::LoadingComponent.new(
    #     text: "Process",
    #     loading: true,
    #     size: :small
    #   ) %>
    #
    # @example Danger loading button
    #   <%= render ArtisansUi::Button::LoadingComponent.new(
    #     text: "Delete",
    #     loading: true,
    #     variant: :danger
    #   ) %>
    class LoadingComponent < ApplicationViewComponent
      VARIANTS = {
        neutral: "border-neutral-400/30 bg-neutral-800 text-white hover:bg-neutral-700 focus-visible:outline-neutral-600 dark:bg-white dark:text-neutral-800 dark:hover:bg-neutral-100 dark:focus-visible:outline-neutral-200",
        colored: "border-blue-400/30 bg-blue-600 text-white hover:bg-blue-500 focus-visible:outline-neutral-600 dark:focus-visible:outline-neutral-200",
        secondary: "border-neutral-200 bg-white/90 text-neutral-800 shadow-xs hover:bg-neutral-50 focus-visible:outline-neutral-600 dark:border-neutral-700 dark:bg-neutral-800/50 dark:text-neutral-50 dark:hover:bg-neutral-700/50 dark:focus-visible:outline-neutral-200",
        danger: "border-red-300/30 bg-red-600 text-white hover:bg-red-500 focus-visible:outline-neutral-600 dark:focus-visible:outline-neutral-200",
        warning: "border-yellow-500/30 bg-yellow-500 text-white hover:bg-yellow-600 focus-visible:outline-yellow-600 dark:bg-yellow-500 dark:text-white dark:hover:bg-yellow-600 dark:focus-visible:outline-yellow-600"
      }.freeze

      SIZES = {
        regular: "px-3.5 py-2 text-sm",
        small: "px-3 py-2 text-xs"
      }.freeze

      def initialize(text:, loading: false, loading_text: "Loading...", variant: :neutral, size: :regular, disabled: false, **html_options)
        @text = text
        @loading = loading
        @loading_text = loading_text
        @variant = variant&.to_sym
        @size = size.to_sym
        @disabled = disabled
        @html_options = html_options

        validate_params!
      end

      def call
        tag.button(
          button_content,
          type: "button",
          disabled: @disabled || @loading,
          class: button_classes,
          **@html_options
        )
      end

      private

      def validate_params!
        if @variant && !VARIANTS.key?(@variant)
          raise ArgumentError, "Invalid variant: #{@variant}"
        end
        raise ArgumentError, "Invalid size: #{@size}" unless SIZES.key?(@size)
      end

      def button_content
        if @loading
          safe_join([spinner_svg, @loading_text], " ")
        else
          @text
        end
      end

      def spinner_svg
        <<~SVG.html_safe
          <svg class="animate-spin size-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>
        SVG
      end

      def button_classes
        classes = [base_classes, SIZES[@size]]
        classes << VARIANTS[@variant] if @variant
        classes.join(" ")
      end

      def base_classes
        "flex items-center justify-center gap-1.5 rounded-lg border shadow-sm transition-all duration-100 ease-in-out select-none font-medium whitespace-nowrap focus-visible:outline-2 focus-visible:outline-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
      end
    end
  end
end
