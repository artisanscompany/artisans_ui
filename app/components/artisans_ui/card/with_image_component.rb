# frozen_string_literal: true

module ArtisansUi
  module Card
    # Card with Image Component (Variant 7)
    # Content card with featured image
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Card::WithImageComponent.new(
    #     image_url: "https://images.unsplash.com/...",
    #     image_alt: "Card image",
    #     badge_text: "Article",
    #     badge_color: "blue",
    #     meta_text: "5 min read",
    #     title: "Card with Featured Image",
    #     description: "This card includes a featured image...",
    #     author_name: "John Doe",
    #     author_image: "https://images.unsplash.com/...",
    #     author_date: "September 16, 2025"
    #   ) %>
    class WithImageComponent < ApplicationViewComponent
      def initialize(
        image_url:,
        image_alt:,
        title:,
        description:,
        badge_text: nil,
        badge_color: "blue",
        meta_text: nil,
        author_name: nil,
        author_image: nil,
        author_date: nil,
        **html_options
      )
        @image_url = image_url
        @image_alt = image_alt
        @title = title
        @description = description
        @badge_text = badge_text
        @badge_color = badge_color
        @meta_text = meta_text
        @author_name = author_name
        @author_image = author_image
        @author_date = author_date
        @html_options = html_options
      end

      def call
        tag.div(
          class: "bg-white rounded-xl shadow-xs overflow-hidden border border-black/10",
          **@html_options
        ) do
          safe_join([
            render_image,
            render_content,
            render_footer
          ].compact)
        end
      end

      private

      def render_image
        tag.div(class: "aspect-w-16 aspect-h-9 bg-neutral-200") do
          tag.img(
            src: @image_url,
            alt: @image_alt,
            class: "w-full h-full object-center object-cover"
          )
        end
      end

      def render_content
        tag.div(class: "px-6 py-4") do
          content = []

          if @badge_text || @meta_text
            content << tag.div(class: "flex items-center mb-2") do
              badge_and_meta = []
              if @badge_text
                badge_and_meta << tag.span(
                  class: "inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-#{@badge_color}-100 text-#{@badge_color}-800"
                ) { @badge_text }
              end
              if @meta_text
                badge_and_meta << tag.span(class: "ml-2 text-sm text-neutral-500") { @meta_text }
              end
              safe_join(badge_and_meta)
            end
          end

          content << tag.h3(class: "text-xl font-semibold text-neutral-900 mb-2") { @title }
          content << tag.p(class: "text-neutral-700 text-sm") { @description }

          safe_join(content)
        end
      end

      def render_footer
        return unless @author_name

        tag.div(class: "px-6 py-4 bg-neutral-50 border-t border-black/10") do
          tag.div(class: "flex items-center justify-between") do
            safe_join([
              tag.div(class: "flex items-center") do
                author_content = []
                if @author_image
                  author_content << tag.img(class: "h-10 w-10 rounded-full", src: @author_image, alt: @author_name)
                end
                author_content << tag.div(class: "ml-3") do
                  safe_join([
                    tag.p(class: "text-sm font-medium text-neutral-900") { @author_name },
                    @author_date ? tag.p(class: "text-xs text-neutral-500") { @author_date } : nil
                  ].compact)
                end
                safe_join(author_content)
              end,
              tag.button(type: "button", class: "text-neutral-400 hover:text-neutral-500") do
                tag.svg(class: "h-5 w-5", fill: "currentColor", viewBox: "0 0 20 20") do
                  tag.path(d: "M15 8a3 3 0 10-2.977-2.63l-4.94 2.47a3 3 0 100 4.319l4.94 2.47a3 3 0 10.895-1.789l-4.94-2.47a3.027 3.027 0 000-.74l4.94-2.47C13.456 7.68 14.19 8 15 8z")
                end
              end
            ])
          end
        end
      end
    end
  end
end
