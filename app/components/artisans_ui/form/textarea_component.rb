# frozen_string_literal: true

module ArtisansUi
  module Form
    # Textarea Component
    # Standalone textarea field for long-form text input
    #
    # @example Basic textarea
    #   <%= render ArtisansUi::Form::TextareaComponent.new(
    #     name: :message,
    #     placeholder: "Enter your message"
    #   ) %>
    #
    # @example With rows
    #   <%= render ArtisansUi::Form::TextareaComponent.new(
    #     name: :description,
    #     rows: 6,
    #     placeholder: "Enter description"
    #   ) %>
    #
    # @example With maxlength
    #   <%= render ArtisansUi::Form::TextareaComponent.new(
    #     name: :bio,
    #     rows: 4,
    #     maxlength: 500,
    #     placeholder: "Tell us about yourself (max 500 chars)"
    #   ) %>
    #
    # @example With content block
    #   <%= render ArtisansUi::Form::TextareaComponent.new(
    #     name: :content,
    #     rows: 8
    #   ) do %>
    #     Default textarea content here
    #   <% end %>
    class TextareaComponent < ApplicationViewComponent
      def initialize(rows: 4, **html_options)
        @rows = rows
        @html_options = html_options
      end

      def call
        tag.textarea(content, rows: @rows, **merged_options)
      end

      private

      def default_classes
        "w-full px-4 py-2.5 text-sm border border-neutral-300 dark:border-neutral-700 rounded-lg bg-white dark:bg-neutral-900 text-neutral-900 dark:text-white placeholder-neutral-500 dark:placeholder-neutral-400 focus:outline-none focus:ring-2 focus:ring-neutral-400 dark:focus:ring-neutral-600 focus:border-transparent transition-colors resize-vertical"
      end

      def merged_options
        custom_class = @html_options.delete(:class)
        @html_options.merge(class: [default_classes, custom_class].compact.join(" "))
      end
    end
  end
end
