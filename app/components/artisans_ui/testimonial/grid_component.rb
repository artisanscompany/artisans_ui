# frozen_string_literal: true

module ArtisansUi
  module Testimonial
    class GridComponent < ViewComponent::Base
      renders_many :testimonials, lambda { |quote:, author_name:, author_title:, author_image:|
        Testimonial.new(
          quote: quote,
          author_name: author_name,
          author_title: author_title,
          author_image: author_image
        )
      }

      def initialize(**html_options)
        @html_options = html_options
        @html_options[:class] = class_names(
          "grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6",
          html_options[:class]
        )
      end

      attr_reader :html_options

      class Testimonial < ViewComponent::Base
        def initialize(quote:, author_name:, author_title:, author_image:)
          @quote = quote
          @author_name = author_name
          @author_title = author_title
          @author_image = author_image
        end

        attr_reader :quote, :author_name, :author_title, :author_image
      end
    end
  end
end
