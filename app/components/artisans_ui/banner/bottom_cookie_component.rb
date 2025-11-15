# frozen_string_literal: true

module ArtisansUi
  module Banner
    # Bottom Cookie Consent Banner Component (Variant 2)
    # A cookie consent banner positioned at the bottom of the page with icon and multiple action buttons
    # Re-shows on every page refresh (cookieDays: -1)
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Banner::BottomCookieComponent.new(
    #     title: "We use cookies",
    #     description: "By continuing to use this site, you agree to our use of cookies.",
    #     accept_text: "Accept All Cookies",
    #     manage_text: "Manage Preferences",
    #     manage_url: "#"
    #   ) %>
    class BottomCookieComponent < ApplicationViewComponent
      def initialize(title:, description: nil, accept_text: "Accept All Cookies", manage_text: nil, manage_url: nil, cookie_name: "cookie_consent_dismissed", **html_options)
        @title = title
        @description = description
        @accept_text = accept_text
        @manage_text = manage_text
        @manage_url = manage_url
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
          class: "hidden fixed bottom-0 left-0 right-0 z-50 bg-white dark:bg-neutral-900 border-t border-black/10 dark:border-white/10 shadow-xs transition-all duration-300 ease-in-out opacity-0 translate-y-full",
          **@html_options
        ) do
          tag.div(class: "container mx-auto px-4") do
            tag.div(class: "flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 py-4") do
              safe_join([
                tag.div(class: "flex items-start gap-3 flex-1") do
                  safe_join([
                    tag.div(class: "flex size-9 shrink-0 items-center justify-center rounded-full bg-neutral-100 dark:bg-neutral-800 mt-0.5", aria: { hidden: "true" }) do
                      tag.svg(
                        xmlns: "http://www.w3.org/2000/svg",
                        width: "18",
                        height: "18",
                        viewBox: "0 0 18 18",
                        class: "text-neutral-700 dark:text-neutral-50",
                        fill: "none",
                        stroke: "currentColor",
                        stroke_width: "1.5",
                        stroke_linecap: "round",
                        stroke_linejoin: "round"
                      ) do
                        safe_join([
                          tag.path(d: "M14.75,8c-1.91,0-3.469-1.433-3.703-3.28-.099,.01-.195,.03-.297,.03-1.618,0-2.928-1.283-2.989-2.887-3.413,.589-6.011,3.556-6.011,7.137,0,4.004,3.246,7.25,7.25,7.25s7.25-3.246,7.25-7.25c0-.434-.045-.857-.118-1.271-.428,.17-.893,.271-1.382,.271Z"),
                          tag.circle(cx: "12.25", cy: "1.75", r: ".75", fill: "currentColor", **{ "data-stroke" => "none", stroke: "none" }),
                          tag.circle(cx: "14.75", cy: "4.25", r: ".75", fill: "currentColor", **{ "data-stroke" => "none", stroke: "none" }),
                          tag.circle(cx: "11.25", cy: "11.75", r: ".75", fill: "currentColor", **{ "data-stroke" => "none", stroke: "none" }),
                          tag.circle(cx: "7", cy: "7", r: "1", fill: "currentColor", **{ "data-stroke" => "none", stroke: "none" }),
                          tag.circle(cx: "7.25", cy: "11.25", r: "1.25", fill: "currentColor", **{ "data-stroke" => "none", stroke: "none" })
                        ])
                      end
                    end,
                    tag.div(class: "space-y-1") do
                      content = [tag.h3(@title, class: "text-sm font-semibold text-neutral-900 dark:text-white")]
                      if @description
                        content << tag.p(@description, class: "text-xs text-neutral-600 dark:text-neutral-400 max-w-2xl")
                      end
                      safe_join(content)
                    end
                  ])
                end,
                tag.div(class: "flex flex-col sm:flex-row items-stretch sm:items-center gap-2 w-full sm:w-auto") do
                  content = [
                    tag.button(
                      @accept_text,
                      data: { action: "click->artisans-ui--banner#hide" },
                      class: "flex items-center justify-center gap-1.5 rounded-lg border border-neutral-400/30 bg-neutral-800 px-3.5 py-2 text-sm font-medium whitespace-nowrap text-white shadow-sm transition-all duration-100 ease-in-out select-none hover:bg-neutral-700 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600 disabled:cursor-not-allowed disabled:opacity-50 dark:bg-white dark:text-neutral-800 dark:hover:bg-neutral-100 dark:focus-visible:outline-neutral-200"
                    )
                  ]
                  if @manage_text && @manage_url
                    content << tag.a(
                      @manage_text,
                      href: @manage_url,
                      class: "flex items-center justify-center gap-1.5 rounded-lg border border-neutral-200 bg-white/90 px-3.5 py-2 text-sm font-medium whitespace-nowrap text-neutral-800 shadow-xs transition-all duration-100 ease-in-out select-none hover:bg-neutral-50 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600 disabled:cursor-not-allowed disabled:opacity-50 dark:border-neutral-700 dark:bg-neutral-800/50 dark:text-neutral-50 dark:hover:bg-neutral-700/50 dark:focus-visible:outline-neutral-200"
                    )
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
