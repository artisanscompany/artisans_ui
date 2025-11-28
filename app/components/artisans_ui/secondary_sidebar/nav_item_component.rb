# frozen_string_literal: true

module ArtisansUi
  module SecondarySidebar
    class NavItemComponent < ApplicationViewComponent
      def initialize(label:, href:, active: false, icon: nil, **options)
        @label = label
        @href = href
        @active = active
        @icon = icon
        @options = options
      end

      def call
        link_to @href, class: link_classes, **@options do
          safe_join([icon_content, label_content].compact)
        end
      end

      private

      def link_classes
        base_classes = "flex items-center gap-2 px-3 py-2 text-sm font-medium rounded-lg transition-colors"

        if @active
          active_classes = "bg-gray-100 text-gray-900 dark:bg-gray-700 dark:text-white"
          "#{base_classes} #{active_classes}"
        else
          inactive_classes = "text-gray-700 hover:bg-gray-50 hover:text-gray-900 dark:text-gray-300 dark:hover:bg-gray-700 dark:hover:text-white"
          "#{base_classes} #{inactive_classes}"
        end
      end

      def icon_content
        return unless @icon || content?

        content_tag(:span, class: "flex-shrink-0 w-4 h-4") do
          if content?
            content
          else
            raw(@icon)
          end
        end
      end

      def label_content
        content_tag(:span, @label)
      end
    end
  end
end
