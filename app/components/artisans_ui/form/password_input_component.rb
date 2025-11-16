# frozen_string_literal: true

module ArtisansUi
  module Form
    # Password Input Component
    # Standalone password input field with optional visibility toggle
    #
    # @example Basic password input
    #   <%= render ArtisansUi::Form::PasswordInputComponent.new(
    #     name: :password,
    #     placeholder: "Enter password"
    #   ) %>
    #
    # @example With autocomplete off
    #   <%= render ArtisansUi::Form::PasswordInputComponent.new(
    #     name: :password,
    #     autocomplete: "new-password"
    #   ) %>
    #
    # @example With required attribute
    #   <%= render ArtisansUi::Form::PasswordInputComponent.new(
    #     name: :password,
    #     required: true,
    #     minlength: 8
    #   ) %>
    class PasswordInputComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.input(type: "password", **merged_options)
      end

      private

      def default_classes
        "w-full px-4 py-2.5 text-sm border border-neutral-300 dark:border-neutral-700 rounded-lg bg-white dark:bg-neutral-900 text-neutral-900 dark:text-white placeholder-neutral-500 dark:placeholder-neutral-400 focus:outline-none focus:ring-2 focus:ring-neutral-900 dark:focus:ring-neutral-100 focus:border-transparent transition-colors"
      end

      def merged_options
        custom_class = @html_options.delete(:class)
        @html_options.merge(class: [default_classes, custom_class].compact.join(" "))
      end
    end
  end
end
