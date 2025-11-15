# frozen_string_literal: true

module ArtisansUi
  module Radio
    # Radio with Icons Component (Variant 4)
    # Radio cards with SVG icons (search, AI chat, thumbs up, handshake)
    # Same card styling as CardComponent but with icons
    # Exact RailsBlocks implementation
    #
    # @example Radio with icons
    #   <%= render ArtisansUi::Radio::WithIconsComponent.new %>
    class WithIconsComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.fieldset(class: "flex flex-col gap-4") do
          safe_join([
            tag.legend("How did you hear about us?", class: "text-sm font-semibold mb-2"),
            icon_radio(
              "Search Engine",
              "search",
              "Found us through Google, Bing, etc.",
              search_icon,
              checked: true
            ),
            icon_radio(
              "AI Assistant",
              "ai",
              "ChatGPT, Claude, or other AI recommended us",
              ai_icon
            ),
            icon_radio(
              "Social Media",
              "social",
              "Discovered on Twitter, LinkedIn, etc.",
              social_icon
            ),
            icon_radio(
              "Referral",
              "referral",
              "A friend or colleague told me",
              referral_icon
            )
          ])
        end
      end

      private

      def icon_radio(title, value, description, icon, checked: false)
        input_id = "source_#{value}"

        tag.label(
          for: input_id,
          class: "relative flex items-start gap-4 rounded-xl border border-neutral-200 dark:border-neutral-700 p-4 cursor-pointer has-[:checked]:ring-2 has-[:checked]:ring-neutral-400 dark:has-[:checked]:ring-neutral-500"
        ) do
          safe_join([
            tag.input(
              type: "radio",
              id: input_id,
              name: "source",
              value: value,
              checked: checked || nil,
              class: "absolute left-4"
            ),
            tag.div(class: "ml-8 flex gap-3") do
              safe_join([
                tag.div(class: "flex-shrink-0 mt-0.5") { icon },
                tag.div do
                  safe_join([
                    tag.div(class: "font-semibold text-neutral-900 dark:text-neutral-100") { title },
                    tag.p(
                      description,
                      class: "text-sm text-neutral-500 mt-1"
                    )
                  ])
                end
              ])
            end
          ])
        end
      end

      def search_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          fill: "none",
          viewBox: "0 0 24 24",
          "stroke-width": "1.5",
          stroke: "currentColor",
          class: "w-6 h-6 text-neutral-600 dark:text-neutral-400"
        ) do
          tag.path(
            "stroke-linecap": "round",
            "stroke-linejoin": "round",
            d: "m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z"
          )
        end
      end

      def ai_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          fill: "none",
          viewBox: "0 0 24 24",
          "stroke-width": "1.5",
          stroke: "currentColor",
          class: "w-6 h-6 text-neutral-600 dark:text-neutral-400"
        ) do
          tag.path(
            "stroke-linecap": "round",
            "stroke-linejoin": "round",
            d: "M8.625 12a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Zm0 0H8.25m4.125 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Zm0 0H12m4.125 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Zm0 0h-.375M21 12c0 4.556-4.03 8.25-9 8.25a9.764 9.764 0 0 1-2.555-.337A5.972 5.972 0 0 1 5.41 20.97a5.969 5.969 0 0 1-.474-.065 4.48 4.48 0 0 0 .978-2.025c.09-.457-.133-.901-.467-1.226C3.93 16.178 3 14.189 3 12c0-4.556 4.03-8.25 9-8.25s9 3.694 9 8.25Z"
          )
        end
      end

      def social_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          fill: "none",
          viewBox: "0 0 24 24",
          "stroke-width": "1.5",
          stroke: "currentColor",
          class: "w-6 h-6 text-neutral-600 dark:text-neutral-400"
        ) do
          tag.path(
            "stroke-linecap": "round",
            "stroke-linejoin": "round",
            d: "M6.633 10.25c.806 0 1.533-.446 2.031-1.08a9.041 9.041 0 0 1 2.861-2.4c.723-.384 1.35-.956 1.653-1.715a4.498 4.498 0 0 0 .322-1.672V2.75a.75.75 0 0 1 .75-.75 2.25 2.25 0 0 1 2.25 2.25c0 1.152-.26 2.243-.723 3.218-.266.558.107 1.282.725 1.282m0 0h3.126c1.026 0 1.945.694 2.054 1.715.045.422.068.85.068 1.285a11.95 11.95 0 0 1-2.649 7.521c-.388.482-.987.729-1.605.729H13.48c-.483 0-.964-.078-1.423-.23l-3.114-1.04a4.501 4.501 0 0 0-1.423-.23H5.904m10.598-9.75H14.25M5.904 18.5c.083.205.173.405.27.602.197.4-.078.898-.523.898h-.908c-.889 0-1.713-.518-1.972-1.368a12 12 0 0 1-.521-3.507c0-1.553.295-3.036.831-4.398C3.387 9.953 4.167 9.5 5.04 9.5h.8c.552 0 1.005.452.905.998a14.023 14.023 0 0 0-.145 2.012c0 .953.093 1.888.27 2.785.172.877-.067 1.789-.5 2.205Z"
          )
        end
      end

      def referral_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          fill: "none",
          viewBox: "0 0 24 24",
          "stroke-width": "1.5",
          stroke: "currentColor",
          class: "w-6 h-6 text-neutral-600 dark:text-neutral-400"
        ) do
          tag.path(
            "stroke-linecap": "round",
            "stroke-linejoin": "round",
            d: "M7.5 21 3 16.5m0 0L7.5 12M3 16.5h13.5m0-13.5L21 7.5m0 0L16.5 12M21 7.5H7.5"
          )
        end
      end
    end
  end
end
