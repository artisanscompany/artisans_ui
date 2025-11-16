# frozen_string_literal: true

module ArtisansUi
  module Form
    # Tel Input Component
    # Standalone telephone/phone number input field
    #
    # @example Basic phone input
    #   <%= render ArtisansUi::Form::TelInputComponent.new(
    #     name: :phone,
    #     placeholder: "Enter phone number"
    #   ) %>
    #
    # @example With pattern
    #   <%= render ArtisansUi::Form::TelInputComponent.new(
    #     name: :phone,
    #     pattern: "[0-9]{3}-[0-9]{3}-[0-9]{4}",
    #     placeholder: "123-456-7890"
    #   ) %>
    #
    # @example With custom classes
    #   <%= render ArtisansUi::Form::TelInputComponent.new(
    #     name: :mobile,
    #     class: "!ring-blue-500",
    #     required: true
    #   ) %>
    class TelInputComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.input(type: "tel", class: default_classes, **@html_options)
      end

      private

      def default_classes
        "w-full px-4 py-2.5 text-sm border border-neutral-300 dark:border-neutral-700 rounded-lg bg-white dark:bg-neutral-900 text-neutral-900 dark:text-white placeholder-neutral-500 dark:placeholder-neutral-400 focus:outline-none focus:ring-2 focus:ring-neutral-900 dark:focus:ring-neutral-100 focus:border-transparent transition-colors"
      end
    end
  end
end
