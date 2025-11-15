# frozen_string_literal: true

module ArtisansUi
  module Dock
    # Dock menu with top placement (desktop) and tooltips below icons
    # Exact RailsBlocks implementation with Motion.dev animations
    #
    # @example
    #   <%= render ArtisansUi::Dock::TopPlacementComponent.new(
    #     desktop_items: [
    #       { icon: "home_icon_svg", tooltip: "Home", hotkey: "h", href: "/" },
    #       { icon: "search_icon_svg", tooltip: "Search", hotkey: "s", href: "/search" }
    #     ],
    #     mobile_items: [
    #       { label: "Home", icon: "home_icon_svg", href: "/" },
    #       { label: "Search", icon: "search_icon_svg", href: "/search" }
    #     ]
    #   ) %>
    class TopPlacementComponent < ApplicationViewComponent
      def initialize(desktop_items: [], mobile_items: [], **html_options)
        @desktop_items = desktop_items
        @mobile_items = mobile_items
        @html_options = html_options
      end

      def call
        tag.div(class: "fixed top-0 left-0 right-0 z-50 flex items-center justify-center pt-6 pb-0 pointer-events-none") do
          safe_join([
            render_desktop_dock,
            render_mobile_dock
          ])
        end
      end

      private

      def render_desktop_dock
        tag.div(
          class: "hidden md:flex flex-row gap-1 p-1.5 bg-white/90 dark:bg-neutral-800/90 backdrop-blur-md rounded-full border border-neutral-200/70 dark:border-neutral-600/50 shadow-lg pointer-events-auto",
          data: { controller: "dock" }
        ) do
          safe_join(@desktop_items.map { |item| render_desktop_icon(item) })
        end
      end

      def render_desktop_icon(item)
        tag.a(
          href: item[:href],
          data: {
            dock_target: "icon",
            tooltip: item[:tooltip],
            tooltip_hotkey: item[:hotkey],
            tooltip_placement: "bottom",
            controller: item[:hotkey] ? "hotkey" : nil,
            hotkey_key_value: item[:hotkey],
            action: item[:hotkey] ? "keydown.#{item[:hotkey]}@document->hotkey#click" : nil
          }.compact,
          class: "flex items-center justify-center"
        ) do
          tag.div(
            class: "size-10 flex items-center justify-center rounded-full text-neutral-500 dark:text-neutral-300 bg-neutral-200 dark:bg-neutral-800 active:bg-neutral-300 dark:active:bg-neutral-700 transition-colors duration-150"
          ) do
            raw item[:icon]
          end
        end
      end

      def render_mobile_dock
        tag.div(class: "md:hidden flex items-center gap-2 pointer-events-auto px-4") do
          safe_join([
            render_mobile_button,
            render_mobile_menu
          ])
        end
      end

      def render_mobile_button
        tag.button(
          type: "button",
          data: {
            dock_target: "mobileButton",
            action: "click->dock#toggleMobile"
          },
          class: "size-10 flex items-center justify-center rounded-full bg-white dark:bg-neutral-800 border border-neutral-200/70 dark:border-neutral-600/50 shadow-lg active:bg-neutral-100 dark:active:bg-neutral-700"
        ) do
          tag.svg(
            xmlns: "http://www.w3.org/2000/svg",
            class: "size-5 text-neutral-700 dark:text-neutral-300",
            width: "24",
            height: "24",
            viewBox: "0 0 24 24",
            fill: "none",
            stroke: "currentColor",
            stroke_width: "2",
            stroke_linecap: "round",
            stroke_linejoin: "round"
          ) do
            safe_join([
              tag.path(d: "m6 9 6 6 6-6")
            ])
          end
        end
      end

      def render_mobile_menu
        tag.div(
          data: { dock_target: "mobileMenu" },
          class: "absolute top-16 left-4 right-4 flex flex-col gap-1 p-1.5 bg-white dark:bg-neutral-800 border border-neutral-200/70 dark:border-neutral-600/50 rounded-2xl shadow-xl hidden"
        ) do
          safe_join(@mobile_items.map { |item| render_mobile_item(item) })
        end
      end

      def render_mobile_item(item)
        tag.a(
          href: item[:href],
          class: "flex items-center gap-3 px-4 py-3 rounded-xl text-neutral-500 dark:text-neutral-300 hover:text-neutral-500 dark:hover:text-neutral-300 bg-neutral-50 dark:bg-neutral-800 active:bg-neutral-100 dark:active:bg-neutral-700 transition-colors duration-150"
        ) do
          safe_join([
            tag.div(class: "size-5 flex-shrink-0") { raw item[:icon] },
            tag.span(item[:label], class: "text-sm font-medium")
          ])
        end
      end
    end
  end
end
