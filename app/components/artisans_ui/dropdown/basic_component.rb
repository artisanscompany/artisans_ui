# frozen_string_literal: true

module ArtisansUi
  module Dropdown
    # Renders a dropdown menu using the popover controller
    #
    # @example Basic usage
    #   <%= render ArtisansUi::Dropdown::BasicComponent.new do |dropdown| %>
    #     <% dropdown.with_trigger do %>
    #       <button>Click me</button>
    #     <% end %>
    #     <% dropdown.with_menu do %>
    #       <a href="#">Menu Item 1</a>
    #       <a href="#">Menu Item 2</a>
    #     <% end %>
    #   <% end %>
    #
    # @param placement [String] Dropdown position (default: "bottom-end")
    # @param trigger [String] Trigger type - "click" or "hover" (default: "click")
    # @param interactive [Boolean] Allow interaction with dropdown (default: true)
    # @param html_options [Hash] Additional HTML attributes for wrapper
    class BasicComponent < ApplicationViewComponent
      renders_one :trigger
      renders_one :menu

      def initialize(placement: "bottom-end", trigger: "click", interactive: true, **html_options)
        @placement = placement
        @trigger = trigger
        @interactive = interactive
        @html_options = html_options
      end

      def call
        tag.div(**wrapper_attributes) do
          safe_join([
            trigger_content,
            menu_template
          ])
        end
      end

      private

      def wrapper_attributes
        {
          data: {
            controller: "popover",
            popover_trigger_value: @trigger,
            popover_interactive_value: @interactive,
            popover_placement_value: @placement
          },
          **@html_options
        }
      end

      def trigger_content
        tag.div(data: { popover_target: "button" }) do
          trigger
        end
      end

      def menu_template
        tag.template(data: { popover_target: "content" }) do
          tag.div(class: menu_classes) do
            menu
          end
        end
      end

      def menu_classes
        [
          "min-w-[200px]",
          "bg-white dark:bg-gray-800",
          "rounded-lg shadow-lg",
          "border border-gray-200 dark:border-gray-700",
          "py-1"
        ].join(" ")
      end
    end
  end
end
