# frozen_string_literal: true

module ArtisansUi
  module Dropdown
    # Renders a dropdown menu item
    #
    # @param href [String] Link URL
    # @param method [Symbol] HTTP method for button_to
    # @param separator [Boolean] Render as separator instead of item
    # @param destructive [Boolean] Use destructive styling (red)
    # @param size [Symbol] Text size variant (:sm or :xs, default: :sm)
    # @param html_options [Hash] Additional HTML attributes
    class ItemComponent < ApplicationViewComponent
      def initialize(href: nil, method: nil, separator: false, destructive: false, size: :sm, **html_options)
        @href = href
        @method = method
        @separator = separator
        @destructive = destructive
        @size = size
        @html_options = html_options
      end

      def call
        return separator_element if @separator

        if @method
          button_to(@href, **button_attributes) { content }
        elsif @href
          link_to(@href, **link_attributes) { content }
        else
          tag.div(**div_attributes) { content }
        end
      end

      private

      def separator_element
        tag.div(class: "h-px bg-gray-200 dark:bg-gray-700 my-1")
      end

      def button_attributes
        {
          method: @method,
          class: item_classes,
          **@html_options
        }
      end

      def link_attributes
        {
          class: item_classes,
          **@html_options
        }
      end

      def div_attributes
        {
          class: item_classes,
          **@html_options
        }
      end

      def item_classes
        text_size = @size == :xs ? "text-xs" : "text-sm"
        padding = @size == :xs ? "px-3 py-1.5" : "px-4 py-2.5"
        
        base = [
          "flex items-center gap-2",
          padding,
          text_size,
          "font-medium",
          "transition-colors",
          "w-full text-left"
        ]

        if @destructive
          base + [
            "text-red-600 dark:text-red-400",
            "hover:bg-red-50 dark:hover:bg-red-900/20"
          ]
        else
          base + [
            "text-gray-700 dark:text-gray-300",
            "hover:bg-gray-100 dark:hover:bg-gray-700"
          ]
        end.join(" ")
      end
    end
  end
end
