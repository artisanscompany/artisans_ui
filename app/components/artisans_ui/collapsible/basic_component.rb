# frozen_string_literal: true

module ArtisansUi
  module Collapsible
    # A collapsible content area with smooth height transitions and icon switching.
    #
    # @example Basic collapsible
    #   <%= render ArtisansUi::Collapsible::BasicComponent.new(
    #     title: "Click to expand",
    #     open: false
    #   ) do %>
    #     <p>This is the collapsible content.</p>
    #   <% end %>
    #
    # @example With custom styling
    #   <%= render ArtisansUi::Collapsible::BasicComponent.new(
    #     title: "FAQ Item",
    #     open: true,
    #     class: "border-b border-neutral-200"
    #   ) do %>
    #     <p>Answer to the FAQ question.</p>
    #   <% end %>
    class BasicComponent < ApplicationViewComponent
      def initialize(title:, open: false, **html_options)
        @title = title
        @open = open
        @html_options = html_options
      end

      def call
        tag.div(
          data: {
            controller: "collapsible",
            collapsible_open_value: @open,
            state: @open ? "open" : "closed"
          },
          **@html_options
        ) do
          safe_join([
            trigger_button,
            content_area
          ])
        end
      end

      private

      def trigger_button
        tag.button(
          type: "button",
          class: "flex w-full items-center justify-between py-4 text-left text-sm font-medium text-neutral-900 dark:text-neutral-100",
          data: { action: "click->collapsible#toggle" }
        ) do
          safe_join([
            tag.span(@title),
            icon_container
          ])
        end
      end

      def icon_container
        tag.span(class: "relative ml-6 flex h-5 w-5 items-center justify-center") do
          safe_join([
            collapsed_icon,
            expanded_icon
          ])
        end
      end

      def collapsed_icon
        tag.span(
          data: { collapsible_target: "collapsedIcon" },
          class: "absolute inset-0 flex items-center justify-center transition-opacity duration-200",
          style: "opacity: #{@open ? '0' : '1'};"
        ) do
          raw(plus_icon_svg)
        end
      end

      def expanded_icon
        tag.span(
          data: { collapsible_target: "expandedIcon" },
          class: "absolute inset-0 flex items-center justify-center transition-opacity duration-200",
          style: "opacity: #{@open ? '1' : '0'};"
        ) do
          raw(minus_icon_svg)
        end
      end

      def content_area
        tag.div(
          data: {
            collapsible_target: "content",
            state: @open ? "open" : "closed"
          },
          class: "overflow-hidden transition-all duration-300 ease-in-out",
          style: "max-height: #{@open ? 'none' : '0'}; opacity: #{@open ? '1' : '0'};"
        ) do
          tag.div(class: "pb-4 text-sm text-neutral-600 dark:text-neutral-400") do
            content
          end
        end
      end

      def plus_icon_svg
        '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/></svg>'
      end

      def minus_icon_svg
        '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4"/></svg>'
      end
    end
  end
end
