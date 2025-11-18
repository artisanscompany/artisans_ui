# frozen_string_literal: true

module ArtisansUi
  module Accordion
    # Accordion with Item Open by Default (Variant 9)
    # Accordion where specific items start in the open state
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Accordion::OpenByDefaultComponent.new(items: [
    #     { question: "First Question", answer: "First Answer", open: true },
    #     { question: "Second Question", answer: "Second Answer" }
    #   ]) %>
    class OpenByDefaultComponent < ApplicationViewComponent
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
        is_open = item[:open] == true

        tag.div(
          data: { accordion_target: "item", state: is_open ? "open" : "closed" },
          class: "border-b pb-2 border-neutral-200"
        ) do
          safe_join([
            render_trigger(item, index, is_open),
            render_content(item, index, is_open)
          ])
        end
      end

      def render_trigger(item, index, is_open)
        tag.h3(data: { state: is_open ? "open" : "closed" }, class: "flex text-base font-semibold mt-2 mb-0") do
          tag.button(
            type: "button",
            data: { accordion_target: "trigger", action: "click->accordion#toggle", state: is_open ? "open" : "closed" },
            aria: { controls: "accordion-content-#{index}", expanded: is_open.to_s },
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

      def render_content(item, index, is_open)
        tag.div(
          id: "accordion-content-#{index}",
          role: "region",
          aria: { labelledby: "accordion-trigger-#{index}" },
          data: { accordion_target: "content", state: is_open ? "open" : "closed" },
          hidden: !is_open,
          class: "overflow-hidden text-sm transition-all duration-300 ease-in-out",
          style: is_open ? "" : "max-height: 0px;"
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
