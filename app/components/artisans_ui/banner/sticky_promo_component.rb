# frozen_string_literal: true

module ArtisansUi
  module Banner
    # Sticky Promotional Banner Component (Variant 4)
    # A centered sticky promotional banner at the bottom
    # Dismissible with session cookie (shows again on next visit)
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Banner::StickyPromoComponent.new(
    #     title: "🎉 Special Offer",
    #     description: "Get 20% off your first order!",
    #     button_text: "Claim Offer",
    #     button_url: "/signup",
    #     cookie_name: "promo_banner"
    #   ) %>
    class StickyPromoComponent < ApplicationViewComponent
      def initialize(title:, description: nil, button_text: nil, button_url: nil, cookie_name: "promo_banner", **html_options)
        @title = title
        @description = description
        @button_text = button_text
        @button_url = button_url
        @cookie_name = cookie_name
        @html_options = html_options
      end

      def call
        tag.div(
          data: {
            controller: "artisans-ui--banner",
            artisans_ui__banner_cookie_name_value: @cookie_name,
            artisans_ui__banner_cookie_days_value: 0
          },
          class: "hidden fixed bottom-4 left-1/2 -translate-x-1/2 z-50 w-full max-w-md mx-4 bg-white dark:bg-neutral-900 text-neutral-900 dark:text-white border border-black/10 dark:border-white/10 rounded-xl shadow-2xl transition-all duration-300 ease-in-out opacity-0 translate-y-full",
          **@html_options
        ) do
          tag.div(class: "relative p-4") do
            safe_join([
              render_close_button,
              render_content
            ])
          end
        end
      end

      private

      def render_close_button
        tag.button(
          data: { action: "click->artisans-ui--banner#hide" },
          class: "absolute right-2 top-2 inline-flex items-center justify-center p-1.5 rounded-full opacity-70 ring-offset-background transition-opacity hover:opacity-100 focus:outline-hidden hover:bg-neutral-500/15 active:bg-neutral-500/25 disabled:pointer-events-none",
          aria: { label: "Close banner" }
        ) do
          tag.svg(
            xmlns: "http://www.w3.org/2000/svg",
            width: "24",
            height: "24",
            viewBox: "0 0 24 24",
            fill: "none",
            stroke: "currentColor",
            stroke_width: "2",
            stroke_linecap: "round",
            stroke_linejoin: "round",
            class: "h-4 w-4"
          ) do
            safe_join([
              tag.line(x1: "18", x2: "6", y1: "6", y2: "18"),
              tag.line(x1: "6", x2: "18", y1: "6", y2: "18")
            ])
          end
        end
      end

      def render_content
        tag.div(class: "pr-6") do
          content = [
            tag.h3(@title, class: "text-base font-bold mb-1")
          ]
          if @description
            content << tag.p(@description, class: "text-sm text-neutral-600 dark:text-neutral-400 mb-3")
          end
          if @button_text && @button_url
            content << tag.a(
              @button_text,
              href: @button_url,
              class: "inline-flex items-center justify-center gap-1.5 rounded-lg border border-neutral-400/30 bg-neutral-800 px-4 py-2 text-sm font-medium whitespace-nowrap text-white shadow-sm transition-all duration-100 ease-in-out select-none hover:bg-neutral-700 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600 disabled:cursor-not-allowed disabled:opacity-50 dark:bg-white dark:text-neutral-800 dark:hover:bg-neutral-100 dark:focus-visible:outline-neutral-200"
            )
          end
          safe_join(content)
        end
      end
    end
  end
end
