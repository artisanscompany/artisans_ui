# frozen_string_literal: true

module ArtisansUi
  module Pagination
    # Pagination Component
    # A clean pagination component with styled page numbers
    #
    # @example Basic usage
    #   <%= render ArtisansUi::Pagination::Component.new(pagy: @pagy) %>
    class Component < ApplicationViewComponent
      def initialize(pagy:, **html_options)
        @pagy = pagy
        @html_options = html_options
      end

      def call
        return unless @pagy&.pages && @pagy.pages > 1

        tag.div(class: class_names("flex items-center justify-center gap-1 py-4", @html_options[:class]), **@html_options.except(:class)) do
          safe_join([
            render_prev_button,
            render_page_links,
            render_next_button
          ].compact)
        end
      end

      private

      def render_prev_button
        if @pagy.prev
          link_to("←", helpers.pagy_url_for(@pagy, @pagy.prev),
            class: "inline-flex items-center justify-center w-8 h-8 text-sm font-medium text-gray-700 dark:text-gray-300 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-lg hover:bg-gray-50 dark:hover:bg-gray-700")
        else
          tag.span("←",
            class: "inline-flex items-center justify-center w-8 h-8 text-sm font-medium text-gray-400 dark:text-gray-600 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-lg cursor-not-allowed")
        end
      end

      def render_next_button
        if @pagy.next
          link_to("→", helpers.pagy_url_for(@pagy, @pagy.next),
            class: "inline-flex items-center justify-center w-8 h-8 text-sm font-medium text-gray-700 dark:text-gray-300 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-lg hover:bg-gray-50 dark:hover:bg-gray-700")
        else
          tag.span("→",
            class: "inline-flex items-center justify-center w-8 h-8 text-sm font-medium text-gray-400 dark:text-gray-600 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-lg cursor-not-allowed")
        end
      end

      def render_page_links
        series = @pagy.series
        return unless series

        safe_join(
          series.map do |item|
            case item
            when Integer
              render_page_link(item)
            when String
              tag.span(item, class: "inline-flex items-center justify-center w-8 h-8 text-sm font-medium text-gray-700 dark:text-gray-300")
            end
          end.compact
        )
      end

      def render_page_link(page)
        if page == @pagy.page
          tag.span(page.to_s,
            class: "inline-flex items-center justify-center w-8 h-8 text-sm font-medium text-white bg-blue-600 border border-blue-600 rounded-lg")
        else
          link_to(page.to_s, helpers.pagy_url_for(@pagy, page),
            class: "inline-flex items-center justify-center w-8 h-8 text-sm font-medium text-gray-700 dark:text-gray-300 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-lg hover:bg-gray-50 dark:hover:bg-gray-700")
        end
      end
    end
  end
end
