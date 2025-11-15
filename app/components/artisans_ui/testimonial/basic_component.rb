# frozen_string_literal: true

module ArtisansUi
  module Testimonial
    class BasicComponent < ViewComponent::Base
      def initialize(quote:, author_name:, author_title:, author_image: nil, **html_options)
        @quote = quote
        @author_name = author_name
        @author_title = author_title
        @author_image = author_image
        @html_options = html_options
        @html_options[:class] = class_names(
          "max-w-2xl mx-auto text-center",
          html_options[:class]
        )
      end

      attr_reader :quote, :author_name, :author_title, :author_image, :html_options
    end
  end
end
