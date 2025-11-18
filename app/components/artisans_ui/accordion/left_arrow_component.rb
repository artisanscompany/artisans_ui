# frozen_string_literal: true

module ArtisansUi
  module Accordion
    # Accordion with Left Arrow (Variant 4)
    # Accordion with left-pointing arrow that rotates when open
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Accordion::LeftArrowComponent.new(items: [
    #     { question: "Question 1", answer: "Answer 1" },
    #     { question: "Question 2", answer: "Answer 2" }
    #   ]) %>
    class LeftArrowComponent < ApplicationViewComponent
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
            class: "flex flex-1 items-center text-left justify-between py-2 font-medium transition-all hover:underline [&[data-state=open]>svg]:rotate-90 focus:outline-neutral-700 focus:outline-offset-2 px-2"
          ) do
            safe_join([
              item[:question],
              left_arrow_icon
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

      def left_arrow_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          data: { accordion_target: "icon" },
          class: "size-4 shrink-0 transition-transform duration-300",
          width: "18",
          height: "18",
          viewBox: "0 0 18 18"
        ) do
          tag.g(fill: "currentColor") do
            tag.path(d: "M11.5605 14.7803C11.3685 14.7803 11.1765 14.7074 11.0305 14.5604L5.78046 9.31042C5.48746 9.01742 5.48746 8.54239 5.78046 8.24939L11.0305 2.99939C11.3235 2.70639 11.7985 2.70639 12.0915 2.99939C12.3845 3.29239 12.3845 3.76742 12.0915 4.06042L7.37096 8.77991L12.0905 13.5004C12.3835 13.7934 12.3835 14.2684 12.0905 14.5614C11.9455 14.7074 11.7535 14.7803 11.5605 14.7803Z")
          end
        end
      end
    end
  end
end
