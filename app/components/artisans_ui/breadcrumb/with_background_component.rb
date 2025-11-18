# frozen_string_literal: true

module ArtisansUi
  module Breadcrumb
    # Breadcrumb with Background Component (Variant 3)
    # Breadcrumb navigation with background styling and custom separators
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Breadcrumb::WithBackgroundComponent.new(items: [
    #     { label: "Home", href: "/" },
    #     { label: "Documentation", href: "/docs" },
    #     { label: "Components", href: "/docs/components" },
    #     { label: "Breadcrumb" }
    #   ]) %>
    class WithBackgroundComponent < ApplicationViewComponent
      def initialize(items:, **html_options)
        @items = items
        @html_options = html_options
      end

      def call
        tag.div(class: "w-full flex justify-center", **@html_options) do
          tag.nav(aria: { label: "Breadcrumb" }, class: "flex justify-center w-full") do
            tag.ol(class: "flex items-center space-x-1 text-sm bg-neutral-50 px-4 py-2 rounded-lg overflow-x-auto whitespace-nowrap") do
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
            is_last ? render_current_page(item) : render_link(item)
          end
        else
          # Subsequent items (with chevron separator)
          tag.li(class: "flex items-center space-x-1") do
            safe_join([
              chevron_icon,
              is_last ? render_current_page(item) : render_link(item)
            ])
          end
        end
      end

      def render_link(item)
        tag.a(
          href: item[:href],
          class: "text-neutral-600 hover:text-neutral-900 transition-colors font-medium"
        ) { item[:label] }
      end

      def render_current_page(item)
        tag.span(
          class: "text-neutral-900 font-semibold",
          aria: { current: "page" }
        ) { item[:label] }
      end

      def chevron_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          class: "size-4 shrink-0",
          viewBox: "0 0 20 20",
          fill: "currentColor"
        ) do
          tag.path(
            fill_rule: "evenodd",
            d: "M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z",
            clip_rule: "evenodd"
          )
        end
      end
    end
  end
end
