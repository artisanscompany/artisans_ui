# frozen_string_literal: true

module ArtisansUi
  module Testimonial
    class WithBackgroundImageComponent < ViewComponent::Base
      def initialize(quote:, author_name:, author_title:, author_image:, background_image:, **html_options)
        @quote = quote
        @author_name = author_name
        @author_title = author_title
        @author_image = author_image
        @background_image = background_image
        @html_options = html_options
        @html_options[:class] = class_names(
          "relative max-w-xl mx-auto rounded-xl overflow-hidden",
          html_options[:class]
        )
      end

      attr_reader :quote, :author_name, :author_title, :author_image, :background_image, :html_options

      def quote_icon_svg
        <<~SVG.html_safe
          <path d="M14.017 21v-7.391c0-5.704 3.731-9.57 8.983-10.609l.995 2.151c-2.432.917-3.995 3.638-3.995 5.849h4v10h-9.983zm-14.017 0v-7.391c0-5.704 3.748-9.57 9-10.609l.996 2.151c-2.433.917-3.996 3.638-3.996 5.849h4v10h-10z"/>
        SVG
      end
    end
  end
end
