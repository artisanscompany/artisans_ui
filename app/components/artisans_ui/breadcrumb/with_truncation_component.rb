# frozen_string_literal: true

module ArtisansUi
  module Breadcrumb
    # Breadcrumb with Truncation Component (Variant 4)
    # Breadcrumb navigation with ellipsis truncation for long paths
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Breadcrumb::WithTruncationComponent.new(items: [
    #     { label: "Home", href: "/" },
    #     { label: "...", collapsed: true },
    #     { label: "Category", href: "/category" },
    #     { label: "Subcategory", href: "/category/subcategory" },
    #     { label: "Very Long Product Name That Might Need Truncation" }
    #   ]) %>
    #
    # @example Without collapsed items
    #   <%= render ArtisansUi::Breadcrumb::WithTruncationComponent.new(items: [
    #     { label: "Home", href: "/" },
    #     { label: "Products", href: "/products" },
    #     { label: "Long Product Name", max_width: "200px" }
    #   ]) %>
    class WithTruncationComponent < ApplicationViewComponent
      def initialize(items:, **html_options)
        @items = items
        @html_options = html_options
      end

      def call
        tag.div(class: "w-full flex justify-center", **@html_options) do
          tag.nav(aria: { label: "Breadcrumb" }, class: "flex justify-center overflow-x-auto whitespace-nowrap") do
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
            elsif item[:collapsed]
              render_collapsed_button(item)
            else
              render_link(item)
            end
          end
        else
          # Subsequent items (with separator)
          tag.li(class: "flex items-center space-x-2") do
            safe_join([
              tag.span(class: "text-neutral-400 dark:text-neutral-600") { "/" },
              if is_last
                render_current_page(item)
              elsif item[:collapsed]
                render_collapsed_button(item)
              else
                render_link(item)
              end
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

      def render_collapsed_button(item)
        tag.button(
          type: "button",
          class: "text-neutral-500 hover:text-neutral-700 dark:text-neutral-400 dark:hover:text-neutral-200 transition-colors"
        ) { item[:label] }
      end

      def render_current_page(item)
        max_width = item[:max_width] || "200px"

        classes = "text-neutral-900 dark:text-neutral-100 font-medium truncate"
        classes += " max-w-[#{max_width}]" if item[:max_width] || item[:label].length > 50

        tag.span(
          class: classes,
          aria: { current: "page" },
          title: item[:label]
        ) { item[:label] }
      end
    end
  end
end
