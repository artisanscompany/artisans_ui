# frozen_string_literal: true

module ArtisansUi
  module Breadcrumb
    # Basic Breadcrumb Component (Variant 1)
    # Simple breadcrumb navigation with slash separators
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Breadcrumb::BasicComponent.new(items: [
    #     { label: "Home", href: "/" },
    #     { label: "Products", href: "/products" },
    #     { label: "Electronics", href: "/products/electronics" },
    #     { label: "Headphones" }
    #   ]) %>
    class BasicComponent < ApplicationViewComponent
      def initialize(items:, **html_options)
        @items = items
        @html_options = html_options
      end

      def call
        tag.div(class: "w-full flex justify-start", **@html_options) do
          tag.nav(aria: { label: "Breadcrumb" }, class: "flex justify-start overflow-x-auto whitespace-nowrap") do
            tag.ol(class: "flex items-center space-x-2 text-sm w-full") do
              safe_join(@items.map.with_index { |item, index| render_item(item, index) })
            end
          end
        end
      end

      private

      def render_item(item, index)
        is_last = index == @items.length - 1

        if index == 0
          # First item (no separator)
          tag.li do
            if is_last
              render_current_page(item)
            else
              render_link(item)
            end
          end
        else
          # Subsequent items (with separator)
          tag.li(class: "flex items-center space-x-2") do
            safe_join([
              tag.span(class: "text-neutral-400 dark:text-neutral-600") { "/" },
              is_last ? render_current_page(item) : render_link(item)
            ])
          end
        end
      end

      def render_link(item)
        tag.a(
          href: item[:href],
          class: "text-neutral-500 hover:text-neutral-700 dark:text-neutral-400 dark:hover:text-neutral-200 transition-colors"
        ) { item[:label] }
      end

      def render_current_page(item)
        tag.span(
          class: "text-neutral-900 dark:text-neutral-100 font-medium",
          aria: { current: "page" }
        ) { item[:label] }
      end
    end
  end
end
