# frozen_string_literal: true

module ArtisansUi
  module LoadingIndicator
    # CircularSpinnerComponent - Classic rotating circular spinner
    # Pure CSS animation - no JavaScript required
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::LoadingIndicator::CircularSpinnerComponent.new %>
    #   <%= render ArtisansUi::LoadingIndicator::CircularSpinnerComponent.new(size: "size-12", color: "text-blue-600") %>
    class CircularSpinnerComponent < ApplicationViewComponent
      def initialize(size: "size-8", color: "text-neutral-800", **html_options)
        @size = size
        @color = color
        @html_options = html_options
      end

      def call
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          class: "rounded-full animate-spin #{@size} #{@color}",
          width: "18",
          height: "18",
          viewBox: "0 0 18 18",
          **@html_options
        ) do
          tag.g(fill: "currentColor") do
            safe_join([
              tag.path(d: "m9,17c-4.4111,0-8-3.5889-8-8S4.5889,1,9,1s8,3.5889,8,8-3.5889,8-8,8Zm0-14.5c-3.584,0-6.5,2.916-6.5,6.5s2.916,6.5,6.5,6.5,6.5-2.916,6.5-6.5-2.916-6.5-6.5-6.5Z", opacity: ".4", "stroke-width": "0"),
              tag.path(d: "m16.25,9.75c-.4141,0-.75-.3359-.75-.75,0-3.584-2.916-6.5-6.5-6.5-.4141,0-.75-.3359-.75-.75s.3359-.75.75-.75c4.4111,0,8,3.5889,8,8,0,.4141-.3359.75-.75.75Z", "stroke-width": "0")
            ])
          end
        end
      end
    end
  end
end
