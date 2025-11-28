# frozen_string_literal: true

module ArtisansUi
  module SecondarySidebar
    class BasicComponent < ApplicationViewComponent
      renders_many :nav_items, NavItemComponent

      def initialize(**options)
        @options = options
      end

      def wrapper_classes
        base_classes = "hidden lg:block w-56"
        custom_classes = @options[:class]

        [base_classes, custom_classes].compact.join(" ")
      end
    end
  end
end
