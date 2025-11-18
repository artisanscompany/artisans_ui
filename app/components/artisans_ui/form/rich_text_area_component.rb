# frozen_string_literal: true

module ArtisansUi
  module Form
    # Rich Text Area Component
    # Trix editor for rich text input with formatting capabilities
    # Requires ActionText to be configured in the Rails application
    #
    # @example Basic rich text area
    #   <%= render ArtisansUi::Form::RichTextAreaComponent.new(
    #     attribute: :content,
    #     form: form
    #   ) %>
    #
    # @example With placeholder
    #   <%= render ArtisansUi::Form::RichTextAreaComponent.new(
    #     attribute: :description,
    #     form: form,
    #     placeholder: "Enter your description here..."
    #   ) %>
    #
    # @example With custom styling
    #   <%= render ArtisansUi::Form::RichTextAreaComponent.new(
    #     attribute: :content,
    #     form: form,
    #     class: "min-h-96"
    #   ) %>
    class RichTextAreaComponent < ApplicationViewComponent
      def initialize(attribute:, form:, **html_options)
        @attribute = attribute
        @form = form
        @html_options = html_options
      end

      def call
        @form.rich_text_area(@attribute, **merged_options)
      end

      private

      def default_classes
        "trix-content block w-full border border-neutral-200 rounded-lg bg-white text-neutral-900 focus:outline-none focus:ring-2 focus:ring-neutral-300 focus:border-transparent transition-colors"
      end

      def merged_options
        custom_class = @html_options.delete(:class)
        @html_options.merge(class: [default_classes, custom_class].compact.join(" "))
      end
    end
  end
end
