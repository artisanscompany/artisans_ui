# frozen_string_literal: true

module ArtisansUi
  module Breadcrumb
    # Breadcrumb with Icons Component (Variant 2)
    # Breadcrumb navigation with home icon and chevron separators
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Breadcrumb::WithIconsComponent.new(items: [
    #     { label: "Home", href: "/", home_icon: true },
    #     { label: "Dashboard", href: "/dashboard" },
    #     { label: "Projects", href: "/projects" },
    #     { label: "Project Alpha" }
    #   ]) %>
    class WithIconsComponent < ApplicationViewComponent
      def initialize(items:, **html_options)
        @items = items
        @html_options = html_options
      end

      def call
        tag.div(class: "w-full flex justify-center", **@html_options) do
          tag.nav(aria: { label: "Breadcrumb" }, class: "flex justify-center overflow-x-auto whitespace-nowrap") do
            tag.ol(class: "flex items-center space-x-1 text-sm w-full") do
              safe_join(@items.map.with_index { |item, index| render_item(item, index) })
            end
          end
        end
      end

      private

      def render_item(item, index)
        is_last = index == @items.length - 1
        is_home = index == 0 && item[:home_icon]

        if index == 0
          # First item (no separator)
          tag.li do
            if is_home
              render_home_link(item, is_last)
            elsif is_last
              render_current_page(item)
            else
              render_link(item)
            end
          end
        else
          # Subsequent items (with chevron separator)
          tag.li(class: "flex items-center") do
            safe_join([
              chevron_icon,
              is_last ? render_current_page(item) : render_link(item)
            ])
          end
        end
      end

      def render_home_link(item, is_last)
        tag.a(
          href: item[:href],
          class: "flex items-center text-neutral-500 hover:text-neutral-700 dark:text-neutral-400 dark:hover:text-neutral-200 transition-colors p-1.5 rounded hover:bg-neutral-100 dark:hover:bg-neutral-800"
        ) do
          safe_join([
            home_icon,
            tag.span(class: "sr-only") { item[:label] }
          ])
        end
      end

      def render_link(item)
        tag.a(
          href: item[:href],
          class: "ml-1 text-neutral-500 hover:text-neutral-700 dark:text-neutral-400 dark:hover:text-neutral-200 transition-colors p-1.5 rounded hover:bg-neutral-100 dark:hover:bg-neutral-800"
        ) { item[:label] }
      end

      def render_current_page(item)
        tag.span(
          class: "ml-1 text-neutral-900 dark:text-neutral-100 font-medium p-1.5",
          aria: { current: "page" }
        ) { item[:label] }
      end

      def home_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          class: "size-4 shrink-0",
          width: "18",
          height: "18",
          viewBox: "0 0 18 18"
        ) do
          tag.g(fill: "currentColor") do
            tag.path(d: "M7.94127 1.36281C8.56694 0.887445 9.4333 0.886569 10.0591 1.36312L15.3088 5.35287C15.7448 5.68398 16 6.20008 16 6.746V14.25C16 15.7692 14.7692 17 13.25 17H10.75V13.251C10.75 12.699 10.302 12.251 9.75 12.251H8.25C7.698 12.251 7.25 12.699 7.25 13.251V17H4.75C3.23079 17 2 15.7692 2 14.25V6.746C2 6.19867 2.2559 5.68346 2.69155 5.3526L7.94127 1.36281Z")
          end
        end
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
