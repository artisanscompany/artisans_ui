# frozen_string_literal: true

module ArtisansUi
  module Form
    # Number Input Component
    # Standalone number input field optimized for numeric values
    #
    # @example Basic number input
    #   <%= render ArtisansUi::Form::NumberInputComponent.new(
    #     name: :quantity,
    #     placeholder: "Enter quantity"
    #   ) %>
    #
    # @example With min/max
    #   <%= render ArtisansUi::Form::NumberInputComponent.new(
    #     name: :age,
    #     min: 0,
    #     max: 120,
    #     placeholder: "Enter your age"
    #   ) %>
    #
    # @example With step
    #   <%= render ArtisansUi::Form::NumberInputComponent.new(
    #     name: :price,
    #     step: 0.01,
    #     placeholder: "0.00"
    #   ) %>
    class NumberInputComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.input(type: "number", **merged_options)
      end

      private

      def default_classes
        "w-full px-4 py-2.5 text-sm border border-neutral-200 dark:border-neutral-800 rounded-lg bg-white dark:bg-neutral-900 text-neutral-900 dark:text-white placeholder-neutral-500 dark:placeholder-neutral-400 focus:outline-none focus:ring-2 focus:ring-neutral-400 dark:focus:ring-neutral-600 focus:border-transparent transition-colors"
      end

      def merged_options
        custom_class = @html_options.delete(:class)
        @html_options.merge(class: [default_classes, custom_class].compact.join(" "))
      end
    end
  end
end
