# frozen_string_literal: true

module ArtisansUi
  module Form
    # URL Input Component
    # Standalone URL input field optimized for website addresses
    #
    # @example Basic URL input
    #   <%= render ArtisansUi::Form::UrlInputComponent.new(
    #     name: :website,
    #     placeholder: "https://example.com"
    #   ) %>
    #
    # @example With pattern
    #   <%= render ArtisansUi::Form::UrlInputComponent.new(
    #     name: :portfolio,
    #     pattern: "https://.*",
    #     placeholder: "https://yoursite.com"
    #   ) %>
    #
    # @example With custom focus ring
    #   <%= render ArtisansUi::Form::UrlInputComponent.new(
    #     name: :blog,
    #     class: "!focus:ring-blue-500",
    #     required: true
    #   ) %>
    class UrlInputComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.input(type: "url", **merged_options)
      end

      private

      def default_classes
        "w-full px-4 py-2.5 text-sm border border-neutral-300 dark:border-neutral-700 rounded-lg bg-white dark:bg-neutral-900 text-neutral-900 dark:text-white placeholder-neutral-500 dark:placeholder-neutral-400 focus:outline-none focus:ring-2 focus:ring-neutral-400 dark:focus:ring-neutral-600 focus:border-transparent transition-colors"
      end

      def merged_options
        custom_class = @html_options.delete(:class)
        @html_options.merge(class: [default_classes, custom_class].compact.join(" "))
      end
    end
  end
end
