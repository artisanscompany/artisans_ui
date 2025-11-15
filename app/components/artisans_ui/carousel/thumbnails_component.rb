# frozen_string_literal: true

module ArtisansUi
  module Carousel
    # Thumbnails Carousel Component (Variant 6)
    # Main carousel with synchronized thumbnail navigation
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Carousel::ThumbnailsComponent.new(
    #     slides: [
    #       { image_url: "https://placehold.co/800x600/blue/white?text=Slide+1", alt: "Slide 1" },
    #       { image_url: "https://placehold.co/800x600/red/white?text=Slide+2", alt: "Slide 2" },
    #       { image_url: "https://placehold.co/800x600/green/white?text=Slide+3", alt: "Slide 3" }
    #     ],
    #     main_carousel_id: "main-carousel",
    #     thumbnail_carousel_id: "thumbnail-carousel"
    #   ) %>
    class ThumbnailsComponent < ApplicationViewComponent
      def initialize(slides:, main_carousel_id: "main-carousel", thumbnail_carousel_id: "thumbnail-carousel", **html_options)
        @slides = slides
        @main_carousel_id = main_carousel_id
        @thumbnail_carousel_id = thumbnail_carousel_id
        @html_options = html_options
      end

      def call
        tag.div(
          class: "mx-auto max-w-screen-md space-y-4",
          **@html_options
        ) do
          safe_join([
            render_main_carousel,
            render_thumbnail_carousel
          ])
        end
      end

      private

      def render_main_carousel
        tag.div(
          id: @main_carousel_id,
          class: "relative overflow-hidden rounded-3xl",
          data: {
            controller: "artisans-ui--carousel",
            "artisans-ui--carousel-loop-value": true,
            "artisans-ui--carousel-dots-value": false,
            "artisans-ui--carousel-buttons-value": true
          }
        ) do
          safe_join([
            render_main_viewport,
            render_main_prev_button,
            render_main_next_button
          ])
        end
      end

      def render_main_viewport
        tag.div(
          class: "overflow-hidden",
          data: { "artisans-ui--carousel-target": "viewport" }
        ) do
          tag.div(
            class: "flex touch-pan-y touch-pinch-zoom [backface-visibility:hidden]",
            data: { "artisans-ui--carousel-target": "container" }
          ) do
            safe_join(
              @slides.map { |slide| render_main_slide(slide) }
            )
          end
        end
      end

      def render_main_slide(slide)
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

      def render_main_prev_button
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

      def render_main_next_button
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

      def render_thumbnail_carousel
        tag.div(
          id: @thumbnail_carousel_id,
          class: "overflow-hidden",
          data: {
            controller: "artisans-ui--carousel",
            "artisans-ui--carousel-main-carousel-value": @main_carousel_id,
            "artisans-ui--carousel-dots-value": false,
            "artisans-ui--carousel-buttons-value": false
          }
        ) do
          render_thumbnail_viewport
        end
      end

      def render_thumbnail_viewport
        tag.div(
          class: "overflow-hidden",
          data: { "artisans-ui--carousel-target": "viewport" }
        ) do
          tag.div(
            class: "flex touch-pan-y touch-pinch-zoom gap-4 [backface-visibility:hidden]",
            data: { "artisans-ui--carousel-target": "container" }
          ) do
            safe_join(
              @slides.map.with_index { |slide, index| render_thumbnail_slide(slide, index) }
            )
          end
        end
      end

      def render_thumbnail_slide(slide, index)
        tag.button(
          type: "button",
          class: "min-w-0 shrink-0 grow-0 basis-1/4 cursor-pointer overflow-hidden rounded-xl border-2 border-transparent opacity-40 transition-all hover:opacity-70",
          data: {
            "artisans-ui--carousel-target": "thumbnailButton",
            action: "click->artisans-ui--carousel#onThumbnailClick",
            index: index
          }
        ) do
          tag.img(
            src: slide[:image_url],
            alt: slide[:alt],
            class: "h-20 w-full object-cover",
            loading: "lazy"
          )
        end
      end
    end
  end
end
