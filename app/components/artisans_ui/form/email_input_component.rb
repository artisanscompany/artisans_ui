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
        tag.input(type: "email", **merged_options)
      end

      private

      def default_classes
        "w-full px-4 py-2.5 text-sm border border-neutral-200 rounded-lg bg-white text-neutral-900 placeholder-neutral-500 focus:outline-none focus:ring-2 focus:ring-neutral-300 focus:border-transparent transition-colors"
      end

      def merged_options
        custom_class = @html_options.delete(:class)
        @html_options.merge(class: [default_classes, custom_class].compact.join(" "))
      end
    end
  end
end
