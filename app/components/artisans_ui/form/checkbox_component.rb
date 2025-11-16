# frozen_string_literal: true

module ArtisansUi
  module Form
    # Checkbox Component
    # Standalone checkbox input with optional label
    #
    # @example Basic checkbox
    #   <%= render ArtisansUi::Form::CheckboxComponent.new(
    #     name: :agree,
    #     id: :agree
    #   ) %>
    #
    # @example With checked state
    #   <%= render ArtisansUi::Form::CheckboxComponent.new(
    #     name: :subscribe,
    #     checked: true
    #   ) %>
    #
    # @example With value
    #   <%= render ArtisansUi::Form::CheckboxComponent.new(
    #     name: :terms,
    #     value: "1",
    #     required: true
    #   ) %>
    #
    # @example With custom classes
    #   <%= render ArtisansUi::Form::CheckboxComponent.new(
    #     name: :option,
    #     class: "!ring-blue-500"
    #   ) %>
    class CheckboxComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.input(type: "checkbox", **merged_options)
      end

      private

      def default_classes
        "h-4 w-4 rounded border-neutral-200 dark:border-neutral-800 bg-white dark:bg-neutral-900 text-neutral-900 dark:text-white focus:ring-2 focus:ring-neutral-400 dark:focus:ring-neutral-600 transition-colors"
      end

      def merged_options
        custom_class = @html_options.delete(:class)
        @html_options.merge(class: [default_classes, custom_class].compact.join(" "))
      end
    end
  end
end
