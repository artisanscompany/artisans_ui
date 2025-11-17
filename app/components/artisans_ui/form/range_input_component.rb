# frozen_string_literal: true

module ArtisansUi
  module Form
    # Range Input Component
    # Standalone range slider input for selecting numeric values within a range
    #
    # @example Basic range input
    #   <%= render ArtisansUi::Form::RangeInputComponent.new(
    #     name: :volume,
    #     min: 0,
    #     max: 100
    #   ) %>
    #
    # @example With default value and step
    #   <%= render ArtisansUi::Form::RangeInputComponent.new(
    #     name: :threshold,
    #     min: 5.0,
    #     max: 9.0,
    #     step: 0.5,
    #     value: 7.0
    #   ) %>
    #
    # @example With custom data attributes
    #   <%= render ArtisansUi::Form::RangeInputComponent.new(
    #     name: :rating,
    #     min: 1,
    #     max: 10,
    #     data: { controller: "range-slider" }
    #   ) %>
    class RangeInputComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.input(type: "range", **merged_options)
      end

      private

      def default_classes
        "w-full h-2 bg-neutral-200 dark:bg-neutral-700 rounded-lg appearance-none cursor-pointer accent-neutral-900 dark:accent-white focus:outline-none focus:ring-2 focus:ring-neutral-400 dark:focus:ring-neutral-600 transition-colors"
      end

      def merged_options
        custom_class = @html_options.delete(:class)
        @html_options.merge(class: [default_classes, custom_class].compact.join(" "))
      end
    end
  end
end
