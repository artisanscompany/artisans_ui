# frozen_string_literal: true

module ArtisansUi
  module Layout
    class MainContentComponent < ArtisansUi::ApplicationViewComponent
      def initialize(max_width: "max-w-7xl", padding: "p-4 sm:p-6 lg:p-8", wrapper_tag: :div, **html_options)
        @max_width = max_width
        @padding = padding
        @wrapper_tag = wrapper_tag
        @html_options = html_options
      end

      def outer_classes
        [padding, html_options.delete(:class)].compact.join(" ")
      end

      def outer_attributes
        html_options
      end

      def inner_classes
        "#{max_width} mx-auto"
      end

      private

      attr_reader :max_width, :padding, :wrapper_tag, :html_options
    end
  end
end
