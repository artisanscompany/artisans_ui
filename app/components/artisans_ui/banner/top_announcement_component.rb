# frozen_string_literal: true

module ArtisansUi
  module Banner
    # Top Announcement Banner Component (Variant 1)
    # A banner fixed to the top of the page with icon, title, description, and action button
    # Perfect for product announcements and feature launches
    # Re-shows on every page refresh (cookieDays: -1)
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Banner::TopAnnouncementComponent.new(
    #     title: "New Feature Launch! 🚀",
    #     description: "Check out our latest Stimulus components for Rails.",
    #     button_text: "Learn more",
    #     button_url: "#"
    #   ) %>
    class TopAnnouncementComponent < ApplicationViewComponent
      def initialize(title:, description: nil, button_text: nil, button_url: nil, cookie_name: "top_announcement_dismissed", **html_options)
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
            artisans_ui__banner_cookie_days_value: -1
          },
          class: "hidden fixed top-0 left-0 right-0 z-50 bg-white text-neutral-900 border-b border-black/10 shadow-xs transition-all duration-300 ease-in-out opacity-0 -translate-y-full",
          **@html_options
        ) do
          tag.div(class: "container mx-auto px-4") do
            tag.div(class: "flex items-center justify-between gap-2 sm:gap-4 py-3") do
              safe_join([
                tag.div(class: "flex items-center gap-3 flex-1") do
                  safe_join([
                    tag.div(class: "hidden sm:flex size-9 shrink-0 items-center justify-center rounded-full sm:bg-neutral-100", aria: { hidden: "true" }) do
                      tag.svg(
                        xmlns: "http://www.w3.org/2000/svg",
                        width: "16",
                        height: "16",
                        viewBox: "0 0 24 24",
                        fill: "none",
                        stroke: "currentColor",
                        stroke_width: "2",
                        stroke_linecap: "round",
                        stroke_linejoin: "round",
                        class: "opacity-90",
                        aria: { hidden: "true" }
                      ) do
                        safe_join([
                          tag.path(d: "M12 2L2 7l10 5 10-5-10-5z"),
                          tag.path(d: "m2 17 10 5 10-5"),
                          tag.path(d: "m2 12 10 5 10-5")
                        ])
                      end
                    end,
                    tag.div(class: "space-y-1") do
                      content = [tag.p(@title, class: "text-sm font-semibold")]
                      if @description
                        content << tag.p(@description, class: "hidden sm:block text-xs text-neutral-600")
                      end
                      safe_join(content)
                    end
                  ])
                end,
                tag.div(class: "flex items-center gap-2") do
                  content = []
                  if @button_text && @button_url
                    content << tag.a(
                      @button_text,
                      href: @button_url,
                      class: "inline-flex items-center justify-center gap-1.5 rounded-lg border border-neutral-400/30 bg-neutral-800 px-3 py-1.5 text-sm font-medium whitespace-nowrap text-white shadow-sm transition-all duration-100 ease-in-out select-none hover:bg-neutral-700 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600 disabled:cursor-not-allowed disabled:opacity-50"
                    )
                  end
                  content << tag.button(
                    data: { action: "click->artisans-ui--banner#hide" },
                    class: "inline-flex items-center justify-center p-1.5 right-2 top-2 rounded-full opacity-70 ring-offset-background transition-opacity hover:opacity-100 focus:outline-hidden hover:bg-neutral-500/15 active:bg-neutral-500/25 disabled:pointer-events-none",
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
                  safe_join(content)
                end
              ])
            end
          end
        end
      end
    end
  end
end
