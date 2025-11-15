# frozen_string_literal: true

module ArtisansUi
  module Banner
    # Bottom Cookie Consent Banner Component (Variant 2)
    # A cookie consent banner fixed to the bottom of the page
    # Dismissible with cookie persistence (default 30 days)
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Banner::BottomCookieComponent.new(
    #     title: "We use cookies",
    #     description: "We use cookies to ensure you get the best experience on our website.",
    #     accept_text: "Accept",
    #     decline_text: "Decline",
    #     cookie_name: "cookie_consent",
    #     cookie_days: 30
    #   ) %>
    class BottomCookieComponent < ApplicationViewComponent
      def initialize(title:, description: nil, accept_text: "Accept", decline_text: "Decline", cookie_name: "cookie_consent", cookie_days: 30, **html_options)
        @title = title
        @description = description
        @accept_text = accept_text
        @decline_text = decline_text
        @cookie_name = cookie_name
        @cookie_days = cookie_days
        @html_options = html_options
      end

      def call
        tag.div(
          data: {
            controller: "artisans-ui--banner",
            artisans_ui__banner_cookie_name_value: @cookie_name,
            artisans_ui__banner_cookie_days_value: @cookie_days
          },
          class: "hidden fixed bottom-0 left-0 right-0 z-50 bg-white dark:bg-neutral-900 text-neutral-900 dark:text-white border-t border-black/10 dark:border-white/10 shadow-lg transition-all duration-300 ease-in-out opacity-0 translate-y-full",
          **@html_options
        ) do
          tag.div(class: "container mx-auto px-4") do
            tag.div(class: "flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 py-4") do
              safe_join([
                render_content,
                render_actions
              ])
            end
          end
        end
      end

      private

      def render_content
        tag.div(class: "flex-1") do
          content = [tag.h3(@title, class: "text-sm font-semibold mb-1")]
          if @description
            content << tag.p(@description, class: "text-sm text-neutral-600 dark:text-neutral-400")
          end
          safe_join(content)
        end
      end

      def render_actions
        tag.div(class: "flex items-center gap-2 shrink-0") do
          safe_join([
            tag.button(
              @decline_text,
              data: { action: "click->artisans-ui--banner#hide" },
              class: "inline-flex items-center justify-center gap-1.5 rounded-lg border border-neutral-400/30 bg-white px-4 py-2 text-sm font-medium whitespace-nowrap text-neutral-900 shadow-sm transition-all duration-100 ease-in-out select-none hover:bg-neutral-50 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600 disabled:cursor-not-allowed disabled:opacity-50 dark:bg-neutral-800 dark:text-white dark:hover:bg-neutral-700 dark:focus-visible:outline-neutral-200"
            ),
            tag.button(
              @accept_text,
              data: { action: "click->artisans-ui--banner#hide" },
              class: "inline-flex items-center justify-center gap-1.5 rounded-lg border border-neutral-400/30 bg-neutral-800 px-4 py-2 text-sm font-medium whitespace-nowrap text-white shadow-sm transition-all duration-100 ease-in-out select-none hover:bg-neutral-700 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600 disabled:cursor-not-allowed disabled:opacity-50 dark:bg-white dark:text-neutral-800 dark:hover:bg-neutral-100 dark:focus-visible:outline-neutral-200"
            )
          ])
        end
      end
    end
  end
end
