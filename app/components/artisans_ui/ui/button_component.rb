# frozen_string_literal: true

module ArtisansUi
  module Ui
    class ButtonComponent < ApplicationViewComponent
      VARIANTS = %w[primary secondary danger outline].freeze

      def initialize(variant: :primary, **html_options)
        @variant = variant.to_s
        @html_options = html_options
      end

      def call
        tag.button(content, **button_attributes)
      end

      private

      def button_attributes
        {
          class: button_classes,
          **@html_options
        }
      end

      def button_classes
        base_classes = "inline-flex items-center justify-center px-4 py-2 text-sm font-medium rounded-md transition-colors focus:outline-none focus:ring-2 focus:ring-offset-2"

        variant_classes = case @variant
        when "primary"
          "bg-blue-600 text-white hover:bg-blue-700 focus:ring-blue-500"
        when "secondary"
          "bg-gray-200 text-gray-900 hover:bg-gray-300 focus:ring-gray-500"
        when "danger"
          "bg-red-600 text-white hover:bg-red-700 focus:ring-red-500"
        when "outline"
          "border border-gray-300 bg-white text-gray-700 hover:bg-gray-50 focus:ring-blue-500"
        else
          "bg-blue-600 text-white hover:bg-blue-700 focus:ring-blue-500"
        end

        "#{base_classes} #{variant_classes}"
      end
    end
  end
end
