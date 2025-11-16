# frozen_string_literal: true

module ArtisansUi
  module Form
    # Error Input Component
    # Input field in error state with red styling
    # Used for any input type that has validation errors
    #
    # @example Text input with error
    #   <%= render ArtisansUi::Form::ErrorInputComponent.new(
    #     type: :text,
    #     name: :name,
    #     value: "invalid value"
    #   ) %>
    #
    # @example Email input with error
    #   <%= render ArtisansUi::Form::ErrorInputComponent.new(
    #     type: :email,
    #     name: :email,
    #     value: "bad@email"
    #   ) %>
    class ErrorInputComponent < ApplicationViewComponent
      def initialize(type: :text, **html_options)
        @type = type.to_sym
        @html_options = html_options
      end

      def call
        tag.input(type: @type, **merged_options)
      end

      private

      def error_classes
        "w-full px-4 py-2.5 text-sm border border-red-300 dark:border-red-700 rounded-lg bg-white dark:bg-neutral-900 text-neutral-900 dark:text-white placeholder-neutral-500 dark:placeholder-neutral-400 focus:outline-none focus:ring-2 focus:ring-red-600 dark:focus:ring-red-400 focus:border-transparent transition-colors"
      end

      def merged_options
        custom_class = @html_options.delete(:class)
        @html_options.merge(class: [error_classes, custom_class].compact.join(" "))
      end
    end
  end
end
