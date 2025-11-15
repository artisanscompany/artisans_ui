# frozen_string_literal: true

module ArtisansUi
  module Banner
    # Countdown Banner Component (Variant 3)
    # A banner with live countdown timer (e.g., Black Friday sale)
    # Auto-hides when countdown expires
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Banner::CountdownComponent.new(
    #     title: "Black Friday Sale!",
    #     description: "Get 50% off everything. Limited time offer!",
    #     countdown_end_time: "2024-11-29T23:59:59",
    #     button_text: "Shop Now",
    #     button_url: "/shop",
    #     cookie_name: "black_friday_banner",
    #     auto_hide: true
    #   ) %>
    class CountdownComponent < ApplicationViewComponent
      def initialize(title:, description: nil, countdown_end_time:, button_text: nil, button_url: nil, cookie_name: "countdown_banner", auto_hide: true, **html_options)
        @title = title
        @description = description
        @countdown_end_time = countdown_end_time
        @button_text = button_text
        @button_url = button_url
        @cookie_name = cookie_name
        @auto_hide = auto_hide
        @html_options = html_options
      end

      def call
        tag.div(
          data: {
            controller: "artisans-ui--banner",
            artisans_ui__banner_cookie_name_value: @cookie_name,
            artisans_ui__banner_cookie_days_value: 7,
            artisans_ui__banner_countdown_end_time_value: @countdown_end_time,
            artisans_ui__banner_auto_hide_value: @auto_hide
          },
          class: "hidden fixed top-0 left-0 right-0 z-50 bg-gradient-to-r from-purple-600 to-pink-600 text-white border-b border-white/10 shadow-lg transition-all duration-300 ease-in-out opacity-0 -translate-y-full",
          **@html_options
        ) do
          tag.div(class: "container mx-auto px-4") do
            tag.div(class: "flex flex-col sm:flex-row items-center justify-between gap-4 py-3") do
              safe_join([
                render_content,
                render_countdown,
                render_actions
              ])
            end
          end
        end
      end

      private

      def render_content
        tag.div(class: "flex-1 text-center sm:text-left") do
          content = [tag.h3(@title, class: "text-base font-bold")]
          if @description
            content << tag.p(@description, class: "text-sm opacity-90 mt-1")
          end
          safe_join(content)
        end
      end

      def render_countdown
        tag.div(class: "flex items-center gap-2 shrink-0") do
          safe_join([
            render_countdown_unit("days", "Days"),
            render_countdown_separator,
            render_countdown_unit("hours", "Hrs"),
            render_countdown_separator,
            render_countdown_unit("minutes", "Min"),
            render_countdown_separator,
            render_countdown_unit("seconds", "Sec")
          ])
        end
      end

      def render_countdown_unit(target, label)
        tag.div(class: "flex flex-col items-center") do
          safe_join([
            tag.div(
              "00",
              data: { artisans_ui__banner_target: target },
              class: "text-2xl font-bold tabular-nums leading-none"
            ),
            tag.div(label, class: "text-xs opacity-75 mt-1")
          ])
        end
      end

      def render_countdown_separator
        tag.div(":", class: "text-2xl font-bold opacity-50 -mt-4")
      end

      def render_actions
        tag.div(class: "flex items-center gap-2 shrink-0") do
          content = []
          if @button_text && @button_url
            content << tag.a(
              @button_text,
              href: @button_url,
              class: "inline-flex items-center justify-center gap-1.5 rounded-lg border border-white/30 bg-white px-4 py-2 text-sm font-medium whitespace-nowrap text-purple-600 shadow-sm transition-all duration-100 ease-in-out select-none hover:bg-white/90 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-white disabled:cursor-not-allowed disabled:opacity-50"
            )
          end
          content << render_close_button
          safe_join(content)
        end
      end

      def render_close_button
        tag.button(
          data: { action: "click->artisans-ui--banner#hide" },
          class: "inline-flex items-center justify-center p-1.5 rounded-full opacity-70 ring-offset-background transition-opacity hover:opacity-100 focus:outline-hidden hover:bg-white/15 active:bg-white/25 disabled:pointer-events-none",
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
    end
  end
end
