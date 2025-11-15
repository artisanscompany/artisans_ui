# frozen_string_literal: true

module ArtisansUi
  module Accordion
    # Zero Dependency Exclusive Accordion (Variant 11)
    # Pure HTML accordion using details/summary elements with name attribute
    # Only one item can be open at a time (exclusive/mutually exclusive)
    # No JavaScript required
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Accordion::ZeroDependencyExclusiveComponent.new(items: [
    #     { question: "Question 1", answer: "Answer 1" },
    #     { question: "Question 2", answer: "Answer 2" }
    #   ]) %>
    class ZeroDependencyExclusiveComponent < ApplicationViewComponent
      def initialize(items:, **html_options)
        @items = items
        @html_options = html_options
        @accordion_name = "accordion-#{SecureRandom.hex(4)}"
      end

      def call
        tag.div(class: "w-full", **@html_options) do
          safe_join(@items.map.with_index { |item, index| render_item(item, index) })
        end
      end

      private

      def render_item(item, index)
        tag.details(name: @accordion_name, class: "border-b pb-2 border-neutral-200 dark:border-neutral-700 group") do
          safe_join([
            render_summary(item),
            render_content(item)
          ])
        end
      end

      def render_summary(item)
        tag.summary(
          class: "flex items-center text-left justify-between py-2 font-medium transition-all hover:underline focus:outline-neutral-700 dark:focus:outline-white focus:outline-offset-2 px-2 cursor-pointer list-none [&::-webkit-details-marker]:hidden mt-2 text-base font-semibold"
        ) do
          safe_join([
            tag.span { item[:question] },
            chevron_icon
          ])
        end
      end

      def render_content(item)
        tag.div(class: "px-2 pb-4 pt-0 text-sm") do
          raw item[:answer]
        end
      end

      def chevron_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          class: "size-4 shrink-0 transition-transform duration-300 group-open:rotate-180",
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
