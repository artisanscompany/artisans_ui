# frozen_string_literal: true

module ArtisansUi
  module Sidebar
    # Navigation Section Component for Sidebar
    # Renders a divider with optional heading to separate groups of navigation items
    #
    # @example Section divider without heading
    #   <%= render ArtisansUi::Sidebar::NavSectionComponent.new %>
    #
    # @example Section divider with heading
    #   <%= render ArtisansUi::Sidebar::NavSectionComponent.new(heading: "Settings") %>
    class NavSectionComponent < ApplicationViewComponent
      # Creates a new navigation section divider
      #
      # @param heading [String, nil] Optional heading text for the section
      # @param html_options [Hash] Additional HTML attributes
      def initialize(heading: nil, **html_options)
        @heading = heading
        @html_options = html_options
      end

      def call
        if @heading.present?
          tag.div(class: "px-2 pt-4 pb-2 #{divider_class}", **@html_options) do
            tag.h3(@heading, class: "text-xs font-semibold text-neutral-500 uppercase tracking-wider px-2")
          end
        else
          tag.div(class: "border-t border-neutral-200 my-2", **@html_options)
        end
      end

      private

      def divider_class
        @heading.present? ? "border-t border-neutral-200" : ""
      end
    end
  end
end
