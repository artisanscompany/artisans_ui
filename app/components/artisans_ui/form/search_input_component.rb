# frozen_string_literal: true

module ArtisansUi
  module Form
    # Search Input Component
    # Search-specific input with optional search icon
    # Optimized for search bars and hero sections
    #
    # @example With search icon (default)
    #   <%= render ArtisansUi::Form::SearchInputComponent.new(
    #     name: :q,
    #     placeholder: "Search jobs..."
    #   ) %>
    #
    # @example Without icon
    #   <%= render ArtisansUi::Form::SearchInputComponent.new(
    #     icon: false,
    #     name: :q,
    #     placeholder: "Search..."
    #   ) %>
    #
    # @example Custom focus ring
    #   <%= render ArtisansUi::Form::SearchInputComponent.new(
    #     name: :q,
    #     class: "!focus:ring-blue-500",
    #     placeholder: "e.g., Remote marketing role"
    #   ) %>
    class SearchInputComponent < ApplicationViewComponent
      def initialize(icon: true, **html_options)
        @icon = icon
        @html_options = html_options
      end

      def call
        if @icon
          tag.div(class: "relative") do
            safe_join([search_icon, search_input])
          end
        else
          search_input
        end
      end

      private

      def search_input
        tag.input(type: "search", **merged_options)
      end

      def merged_options
        custom_class = @html_options.delete(:class)
        base_classes = @icon ? input_with_icon_classes : default_classes
        @html_options.merge(class: [base_classes, custom_class].compact.join(" "))
      end

      def search_icon
        tag.div(class: "absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none") do
          tag.svg(
            class: "h-5 w-5 text-neutral-400",
            fill: "none",
            viewBox: "0 0 24 24",
            stroke: "currentColor"
          ) do
            tag.path(
              "stroke-linecap": "round",
              "stroke-linejoin": "round",
              "stroke-width": "2",
              d: "M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
            )
          end
        end
      end

      def default_classes
        "w-full px-4 py-2.5 text-sm border border-neutral-300 dark:border-neutral-700 rounded-lg bg-white dark:bg-neutral-900 text-neutral-900 dark:text-white placeholder-neutral-500 dark:placeholder-neutral-400 focus:outline-none focus:ring-2 focus:ring-neutral-900 dark:focus:ring-neutral-100 focus:border-transparent transition-colors"
      end

      def input_with_icon_classes
        "w-full pl-11 pr-4 py-2.5 text-sm border border-neutral-300 dark:border-neutral-700 rounded-lg bg-white dark:bg-neutral-900 text-neutral-900 dark:text-white placeholder-neutral-500 dark:placeholder-neutral-400 focus:outline-none focus:ring-2 focus:ring-neutral-900 dark:focus:ring-neutral-100 focus:border-transparent transition-colors"
      end
    end
  end
end
