# frozen_string_literal: true

module ArtisansUi
  module Accordion
    # Accordion with Multiple Items Open (Variant 3)
    # Allows multiple accordion items to be open simultaneously
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Accordion::MultipleOpenComponent.new(items: [
    #     { question: "Question 1", answer: "Answer 1" },
    #     { question: "Question 2", answer: "Answer 2" }
    #   ]) %>
    class MultipleOpenComponent < ApplicationViewComponent
      def initialize(items:, **html_options)
        @items = items
        @html_options = html_options
      end

      def call
        tag.div(class: "w-full", data: { controller: "accordion", accordion_multiple_value: "true" }, **@html_options) do
          safe_join(@items.map.with_index { |item, index| render_item(item, index) })
        end
      end

      private

      def render_item(item, index)
        tag.div(
          data: { accordion_target: "item", state: "closed" },
          class: "border-b pb-2 border-neutral-200"
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
            class: "flex flex-1 items-center text-left justify-between py-2 font-medium transition-all hover:underline [&[data-state=open]>svg]:rotate-180 focus:outline-neutral-700 focus:outline-offset-2 px-2"
          ) do
            safe_join([
              item[:question],
              chevron_icon
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

      def chevron_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          data: { accordion_target: "icon" },
          class: "size-4 shrink-0 transition-transform duration-300",
          width: "18",
          height: "18",
          viewBox: "0 0 18 18"
        ) do
          tag.g(fill: "currentColor") do
            tag.path(d: "M8.99999 13.5C8.80799 13.5 8.61599 13.4271 8.46999 13.2801L2.21999 7.03005C1.92699 6.73705 1.92699 6.26202 2.21999 5.96902C2.51299 5.67602 2.98799 5.67602 3.28099 5.96902L8.99999 11.6896L14.719 5.97005C15.012 5.67705 15.487 5.67705 15.78 5.97005C16.073 6.26305 16.073 6.73801 15.78 7.03101L9.52999 13.281C9.38399 13.4271 9.19199 13.5 8.99999 13.5Z")
          end
        end
      end
    end
  end
end
