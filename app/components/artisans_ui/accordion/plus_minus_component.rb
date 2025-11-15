# frozen_string_literal: true

module ArtisansUi
  module Accordion
    # Accordion with Plus/Minus icon (Variant 2)
    # Accordion with plus icon that transforms to minus when open
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Accordion::PlusMinusComponent.new(items: [
    #     { question: "Question 1", answer: "Answer 1" },
    #     { question: "Question 2", answer: "Answer 2" }
    #   ]) %>
    class PlusMinusComponent < ApplicationViewComponent
      def initialize(items:, **html_options)
        @items = items
        @html_options = html_options
      end

      def call
        tag.div(class: "w-full", data: { controller: "accordion" }, **@html_options) do
          safe_join(@items.map.with_index { |item, index| render_item(item, index) })
        end
      end

      private

      def render_item(item, index)
        tag.div(
          data: { accordion_target: "item", state: "closed" },
          class: "border-b pb-2 border-neutral-200 dark:border-neutral-700"
        ) do
          safe_join([
            render_trigger(item, index),
            render_content(item, index)
          ])
        end
      end

      def render_trigger(item, index)
        tag.h3(data: { state: "closed" }, class: "flex text-base font-semibold mt-2 mb-0") do
          tag.button(
            type: "button",
            data: { accordion_target: "trigger", action: "click->accordion#toggle", state: "closed" },
            aria: { controls: "accordion-content-#{index}", expanded: "false" },
            id: "accordion-trigger-#{index}",
            class: "flex flex-1 items-center text-left justify-between py-2 font-medium transition-all hover:underline focus:outline-neutral-700 dark:focus:outline-white focus:outline-offset-2 px-2"
          ) do
            safe_join([
              item[:question],
              plus_minus_icon
            ])
          end
        end
      end

      def render_content(item, index)
        tag.div(
          id: "accordion-content-#{index}",
          role: "region",
          aria: { labelledby: "accordion-trigger-#{index}" },
          data: { accordion_target: "content", state: "closed" },
          hidden: true,
          class: "overflow-hidden text-sm transition-all duration-300 ease-in-out",
          style: "max-height: 0px;"
        ) do
          tag.div(class: "px-2 pb-4 pt-0") { raw item[:answer] }
        end
      end

      def plus_minus_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          data: { accordion_target: "icon" },
          class: "size-4 shrink-0 transition-transform duration-300",
          width: "18",
          height: "18",
          viewBox: "0 0 18 18"
        ) do
          safe_join([
            # Horizontal line (always visible)
            tag.path(
              d: "M13.5 8.99999H4.5C4.08599 8.99999 3.75 9.33599 3.75 9.74999C3.75 10.164 4.08599 10.5 4.5 10.5H13.5C13.914 10.5 14.25 10.164 14.25 9.74999C14.25 9.33599 13.914 8.99999 13.5 8.99999Z",
              fill: "currentColor"
            ),
            # Vertical line (hidden when open via [&[data-state=open]>svg>path:last-child]:opacity-0)
            tag.path(
              d: "M9 13.5C8.58599 13.5 8.25 13.164 8.25 12.75V6.74999C8.25 6.33599 8.58599 5.99999 9 5.99999C9.41401 5.99999 9.75 6.33599 9.75 6.74999V12.75C9.75 13.164 9.41401 13.5 9 13.5Z",
              fill: "currentColor",
              class: "transition-opacity duration-300"
            )
          ])
        end
      end
    end
  end
end
