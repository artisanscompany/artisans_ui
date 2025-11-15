# frozen_string_literal: true

module ArtisansUi
  module Carousel
    # Basic Carousel Component (Variant 1)
    # Simple carousel with navigation buttons and dot indicators
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Carousel::BasicComponent.new(
    #     slides: [
    #       { image_url: "https://placehold.co/800x600/blue/white?text=Slide+1", alt: "Slide 1" },
    #       { image_url: "https://placehold.co/800x600/red/white?text=Slide+2", alt: "Slide 2" },
    #       { image_url: "https://placehold.co/800x600/green/white?text=Slide+3", alt: "Slide 3" }
    #     ]
    #   ) %>
    class BasicComponent < ApplicationViewComponent
      def initialize(slides:, **html_options)
        @slides = slides
        @html_options = html_options
      end

      def call
        tag.div(
          class: "mx-auto max-w-screen-md",
          **@html_options
        ) do
          tag.div(
            class: "relative overflow-hidden rounded-3xl",
            data: {
              controller: "artisans-ui--carousel",
              "artisans-ui--carousel-dots-value": true,
              "artisans-ui--carousel-buttons-value": true
            }
          ) do
            safe_join([
              render_viewport,
              render_prev_button,
              render_next_button,
              render_dots_container
            ])
          end
        end
      end

      private

      def render_viewport
        tag.div(
          class: "overflow-hidden",
          data: { "artisans-ui--carousel-target": "viewport" }
        ) do
          tag.div(
            class: "flex touch-pan-y touch-pinch-zoom [backface-visibility:hidden]",
            data: { "artisans-ui--carousel-target": "container" }
          ) do
            safe_join(
              @slides.map { |slide| render_slide(slide) }
            )
          end
        end
      end

      def render_slide(slide)
        tag.div(
          class: "flex min-w-0 shrink-0 grow-0 basis-full items-center justify-center"
        ) do
          tag.img(
            src: slide[:image_url],
            alt: slide[:alt],
            class: "max-h-[500px] w-full object-cover",
            loading: "lazy"
          )
        end
      end

      def render_prev_button
        tag.button(
          type: "button",
          class: "absolute left-4 top-1/2 z-10 hidden size-12 -translate-y-1/2 items-center justify-center rounded-full border border-white/20 bg-white/10 text-white backdrop-blur transition-all hover:bg-white/20 disabled:opacity-30 sm:flex",
          data: {
            "artisans-ui--carousel-target": "prevButton",
            action: "click->artisans-ui--carousel#scrollPrev"
          },
          aria: { label: "Previous slide" }
        ) do
          tag.svg(
            xmlns: "http://www.w3.org/2000/svg",
            width: "24",
            height: "24",
            viewBox: "0 0 24 24",
            fill: "none",
            stroke: "currentColor",
            stroke_width: "2",
            stroke_linecap: "round",
            stroke_linejoin: "round",
            class: "size-6"
          ) do
            tag.path(d: "m15 18-6-6 6-6")
          end
        end
      end

      def render_next_button
        tag.button(
          type: "button",
          class: "absolute right-4 top-1/2 z-10 hidden size-12 -translate-y-1/2 items-center justify-center rounded-full border border-white/20 bg-white/10 text-white backdrop-blur transition-all hover:bg-white/20 disabled:opacity-30 sm:flex",
          data: {
            "artisans-ui--carousel-target": "nextButton",
            action: "click->artisans-ui--carousel#scrollNext"
          },
          aria: { label: "Next slide" }
        ) do
          tag.svg(
            xmlns: "http://www.w3.org/2000/svg",
            width: "24",
            height: "24",
            viewBox: "0 0 24 24",
            fill: "none",
            stroke: "currentColor",
            stroke_width: "2",
            stroke_linecap: "round",
            stroke_linejoin: "round",
            class: "size-6"
          ) do
            tag.path(d: "m9 18 6-6-6-6")
          end
        end
      end

      def render_dots_container
        tag.div(
          class: "absolute bottom-6 left-1/2 z-10 flex -translate-x-1/2 gap-2",
          data: { "artisans-ui--carousel-target": "dotsContainer" }
        ) do
          "" # Dots are generated dynamically by the Stimulus controller
        end
      end
    end
  end
end
