# frozen_string_literal: true

module ArtisansUi
  module Form
    # File Input Component
    # Standalone file upload input field with custom styling
    #
    # @example Basic file input
    #   <%= render ArtisansUi::Form::FileInputComponent.new(
    #     name: :avatar
    #   ) %>
    #
    # @example With accept types
    #   <%= render ArtisansUi::Form::FileInputComponent.new(
    #     name: :document,
    #     accept: "application/pdf,.doc,.docx"
    #   ) %>
    #
    # @example Multiple files
    #   <%= render ArtisansUi::Form::FileInputComponent.new(
    #     name: :attachments,
    #     multiple: true,
    #     accept: "image/*"
    #   ) %>
    #
    # @example With custom classes
    #   <%= render ArtisansUi::Form::FileInputComponent.new(
    #     name: :upload,
    #     class: "!cursor-pointer",
    #     required: true
    #   ) %>
    class FileInputComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.input(type: "file", **merged_options)
      end

      private

      def default_classes
        "w-full px-4 py-2.5 text-sm border border-neutral-300 dark:border-neutral-700 rounded-lg bg-white dark:bg-neutral-900 text-neutral-900 dark:text-white file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-medium file:bg-neutral-100 dark:file:bg-neutral-800 file:text-neutral-900 dark:file:text-white hover:file:bg-neutral-200 dark:hover:file:bg-neutral-700 focus:outline-none focus:ring-2 focus:ring-neutral-900 dark:focus:ring-neutral-100 focus:border-transparent transition-colors"
      end

      def merged_options
        custom_class = @html_options.delete(:class)
        @html_options.merge(class: [default_classes, custom_class].compact.join(" "))
      end
    end
  end
end
