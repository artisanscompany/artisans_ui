# frozen_string_literal: true

module ArtisansUi
  module Form
    # Email Input Component
    # Email-specific input with HTML5 email validation
    # Optimized for email entry with consistent styling
    #
    # @example Basic email input
    #   <%= render ArtisansUi::Form::EmailInputComponent.new(
    #     name: :email,
    #     placeholder: "you@example.com"
    #   ) %>
    #
    # @example Required email field
    #   <%= render ArtisansUi::Form::EmailInputComponent.new(
    #     name: :email,
    #     required: true,
    #     autocomplete: "email"
    #   ) %>
    class EmailInputComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.input(type: "email", class: default_classes, **@html_options)
      end

      private

      def default_classes
        "w-full px-4 py-2.5 text-sm border border-neutral-300 dark:border-neutral-700 rounded-lg bg-white dark:bg-neutral-900 text-neutral-900 dark:text-white placeholder-neutral-500 dark:placeholder-neutral-400 focus:outline-none focus:ring-2 focus:ring-neutral-900 dark:focus:ring-neutral-100 focus:border-transparent transition-colors"
      end
    end
  end
end
