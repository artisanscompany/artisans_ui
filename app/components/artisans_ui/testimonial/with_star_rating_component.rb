# frozen_string_literal: true

module ArtisansUi
  module Testimonial
    class WithStarRatingComponent < ViewComponent::Base
      def initialize(quote:, author_name:, author_title:, author_image:, rating: 5, **html_options)
        @quote = quote
        @author_name = author_name
        @author_title = author_title
        @author_image = author_image
        @rating = rating
        @html_options = html_options
        @html_options[:class] = class_names(
          "max-w-2xl mx-auto",
          html_options[:class]
        )
      end

      attr_reader :quote, :author_name, :author_title, :author_image, :rating, :html_options

      def star_svg
        <<~SVG.html_safe
          <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
        SVG
      end

      def full_stars
        rating.floor
      end

      def has_half_star?
        rating % 1 >= 0.5
      end
    end
  end
end
