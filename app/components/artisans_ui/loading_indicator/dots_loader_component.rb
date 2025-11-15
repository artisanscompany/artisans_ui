# frozen_string_literal: true

module ArtisansUi
  module LoadingIndicator
    # DotsLoaderComponent - Three bouncing dots with staggered animation
    # Pure CSS animation - no JavaScript required
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::LoadingIndicator::DotsLoaderComponent.new %>
    #   <%= render ArtisansUi::LoadingIndicator::DotsLoaderComponent.new(size: "size-2", color: "bg-blue-600") %>
    class DotsLoaderComponent < ApplicationViewComponent
      def initialize(size: "size-1.5", color: "bg-neutral-800 dark:bg-neutral-200", **html_options)
        @size = size
        @color = color
        @html_options = html_options
      end

      def call
        tag.div(class: "flex space-x-1.5", **@html_options) do
          safe_join([
            tag.div(class: "#{@size} #{@color} rounded-full animate-bounce", style: "animation-delay: 0ms;"),
            tag.div(class: "#{@size} #{@color}/80 rounded-full animate-bounce", style: "animation-delay: 150ms;"),
            tag.div(class: "#{@size} #{@color}/60 rounded-full animate-bounce", style: "animation-delay: 300ms;")
          ])
        end
      end
    end
  end
end
