# frozen_string_literal: true

module ArtisansUi
  module Form
    # Text Input Component
    # Standard text input field with consistent styling
    # Optimized for general text entry with full customization support
    #
    # @example Basic text input
    #   <%= render ArtisansUi::Form::TextInputComponent.new(
    #     name: :name,
    #     placeholder: "Enter your name..."
    #   ) %>
    #
    # @example Custom focus color
    #   <%= render ArtisansUi::Form::TextInputComponent.new(
    #     name: :query,
    #     class: "!focus:ring-blue-500",
    #     placeholder: "Search..."
    #   ) %>
    #
    # @example With all attributes
    #   <%= render ArtisansUi::Form::TextInputComponent.new(
    #     name: :username,
    #     id: "username-field",
    #     placeholder: "Username",
    #     value: "john_doe",
    #     required: true
    #   ) %>
    class TextInputComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.input(type: "text", **merged_options)
      end

      private

      def merged_options
        custom_class = @html_options.delete(:class)
        @html_options.merge(class: [default_classes, custom_class].compact.join(" "))
      end

      def default_classes
        "w-full px-4 py-2.5 text-sm border border-neutral-200 dark:border-neutral-800 rounded-lg bg-white dark:bg-neutral-900 text-neutral-900 dark:text-white placeholder-neutral-500 dark:placeholder-neutral-400 focus:outline-none focus:ring-2 focus:ring-neutral-400 dark:focus:ring-neutral-600 focus:border-transparent transition-colors"
      end
    end
  end
end
