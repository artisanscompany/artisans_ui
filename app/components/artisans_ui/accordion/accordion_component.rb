# frozen_string_literal: true

module ArtisansUi
  module Accordion
    # Accordion component with expandable/collapsible sections.
    # Inspired by RailsBlocks accordion patterns with Stimulus controller.
    #
    # @example Basic accordion
    #   <%= render ArtisansUi::Accordion::AccordionComponent.new do |accordion| %>
    #     <% accordion.with_item(title: "Section 1") do %>
    #       Content for section 1
    #     <% end %>
    #     <% accordion.with_item(title: "Section 2", open: true) do %>
    #       Content for section 2
    #     <% end %>
    #   <% end %>
    #
    # @example Allow multiple sections open
    #   <%= render ArtisansUi::Accordion::AccordionComponent.new(allow_multiple: true) do |accordion| %>
    #     <% accordion.with_item(title: "Section 1") do %>
    #       Content here
    #     <% end %>
    #   <% end %>
    class AccordionComponent < ApplicationViewComponent
      renders_many :items, "ArtisansUi::Accordion::AccordionItemComponent"

      def initialize(allow_multiple: false, **html_options)
        @allow_multiple = allow_multiple
        @html_options = html_options
      end

      def call
        tag.div(**accordion_attributes) do
          safe_join(items)
        end
      end

      private

      def accordion_attributes
        {
          class: ["w-full", @html_options[:class]].compact.join(" "),
          data: {
            controller: "accordion",
            accordion_allow_multiple_value: @allow_multiple
          }.merge(@html_options.fetch(:data, {}))
        }.merge(@html_options.except(:class, :data))
      end
    end

    # Individual accordion item (internal component)
    class AccordionItemComponent < ApplicationViewComponent
      def initialize(title:, open: false, icon: :chevron, **html_options)
        @title = title
        @open = open
        @icon = icon
        @html_options = html_options
        @item_id = SecureRandom.uuid
      end

      def call
        tag.div(**item_attributes) do
          safe_join([
            render_trigger,
            render_content
          ])
        end
      end

      private

      def item_attributes
        {
          data: {
            accordion_target: "item",
            state: @open ? "open" : "closed"
          },
          class: "border-b pb-2 border-neutral-200 dark:border-neutral-700"
        }
      end

      def render_trigger
        tag.h3(class: "flex text-base font-semibold mt-2 mb-0", data: { state: @open ? "open" : "closed" }) do
          tag.button(
            type: "button",
            data: {
              accordion_target: "trigger",
              state: @open ? "open" : "closed",
              action: "click->accordion#toggle"
            },
            aria: {
              controls: "accordion-content-#{@item_id}",
              expanded: @open
            },
            id: "accordion-trigger-#{@item_id}",
            class: "flex flex-1 items-center text-left justify-between py-2 font-medium transition-all hover:underline [&[data-state=open]>svg]:rotate-180 focus:outline-neutral-700 dark:focus:outline-white focus:outline-offset-2 px-2"
          ) do
            safe_join([
              @title,
              render_icon
            ])
          end
        end
      end

      def render_content
        content_attrs = {
          id: "accordion-content-#{@item_id}",
          role: "region",
          aria: { labelledby: "accordion-trigger-#{@item_id}" },
          data: {
            accordion_target: "content",
            state: @open ? "open" : "closed"
          },
          class: "overflow-hidden text-sm transition-all duration-300 ease-in-out",
          style: @open ? "max-height: auto;" : "max-height: 0px;"
        }

        content_attrs[:hidden] = "" unless @open

        tag.div(**content_attrs) do
          tag.div(class: "px-2 pb-4 pt-0") do
            content
          end
        end
      end

      def render_icon
        case @icon
        when :chevron
          render_chevron_icon
        when :plus_minus
          render_plus_minus_icon
        when :arrow
          render_arrow_icon
        else
          render_chevron_icon
        end
      end

      def render_chevron_icon
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

      def render_plus_minus_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          data: { accordion_target: "icon" },
          class: "size-4 shrink-0 transition-transform duration-300 [&[data-state=open]]:rotate-180",
          width: "24",
          height: "24",
          viewBox: "0 0 24 24",
          fill: "none",
          stroke: "currentColor",
          stroke_width: "2"
        ) do
          safe_join([
            tag.path(d: "M5 12h14"),
            tag.path(d: "M12 5v14", class: "[button[data-state=open]_&]:hidden")
          ])
        end
      end

      def render_arrow_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          data: { accordion_target: "icon" },
          class: "size-4 shrink-0 -rotate-90 transition-transform duration-300",
          width: "24",
          height: "24",
          viewBox: "0 0 24 24",
          fill: "none",
          stroke: "currentColor",
          stroke_width: "2"
        ) do
          tag.path(d: "M5 12h14M12 5l7 7-7 7")
        end
      end
    end
  end
end
