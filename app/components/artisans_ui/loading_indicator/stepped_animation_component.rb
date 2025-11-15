# frozen_string_literal: true

module ArtisansUi
  module LoadingIndicator
    # SteppedAnimationComponent - Stepped rotation loader with 8 radial lines
    # Pure CSS animation - no JavaScript required
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::LoadingIndicator::SteppedAnimationComponent.new %>
    #   <%= render ArtisansUi::LoadingIndicator::SteppedAnimationComponent.new(size: "size-12") %>
    class SteppedAnimationComponent < ApplicationViewComponent
      def initialize(size: "size-8", **html_options)
        @size = size
        @html_options = html_options
      end

      def call
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          class: "#{@size} rounded-full animate-spin [animation-timing-function:steps(8)] [animation-duration:0.8s]",
          width: "18",
          height: "18",
          viewBox: "0 0 18 18",
          **@html_options
        ) do
          tag.g(fill: "none", "stroke-linecap": "round", "stroke-linejoin": "round", "stroke-width": "1.5", stroke: "currentColor") do
            safe_join([
              tag.line(x1: "9", y1: "1.75", x2: "9", y2: "4.25", opacity: ".13"),
              tag.line(x1: "14.127", y1: "3.873", x2: "12.359", y2: "5.641", opacity: ".25"),
              tag.line(x1: "16.25", y1: "9", x2: "13.75", y2: "9", opacity: ".38"),
              tag.line(x1: "14.127", y1: "14.127", x2: "12.359", y2: "12.359", opacity: ".5"),
              tag.line(x1: "9", y1: "16.25", x2: "9", y2: "13.75", opacity: ".63"),
              tag.line(x1: "3.873", y1: "14.127", x2: "5.641", y2: "12.359", opacity: ".75"),
              tag.line(x1: "1.75", y1: "9", x2: "4.25", y2: "9", opacity: ".88"),
              tag.line(x1: "3.873", y1: "3.873", x2: "5.641", y2: "5.641")
            ])
          end
        end
      end
    end
  end
end
