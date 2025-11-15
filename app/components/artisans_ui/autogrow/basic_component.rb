# frozen_string_literal: true

module ArtisansUi
  module Autogrow
    # Basic Autogrow Component (Variant 1)
    # Standard autogrow textarea that starts with 4 lines and expands as needed
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Autogrow::BasicComponent.new(
    #     label: "Your Message",
    #     id: "basic-autogrow",
    #     placeholder: "Start typing and watch the textarea grow..."
    #   ) %>
    class BasicComponent < ApplicationViewComponent
      def initialize(label:, id:, placeholder: nil, rows: 4, **html_options)
        @label = label
        @id = id
        @placeholder = placeholder
        @rows = rows
        @html_options = html_options
      end

      def call
        tag.div(class: "w-full max-w-md") do
          safe_join([
            tag.label(
              @label,
              for: @id,
              class: "block text-sm font-medium text-neutral-700 dark:text-neutral-300 mb-2"
            ),
            tag.textarea(
              "",
              id: @id,
              rows: @rows,
              class: "form-control min-h-16 max-h-52 small-scrollbar",
              placeholder: @placeholder,
              data: {
                controller: "artisans-ui--autogrow",
                action: "input->artisans-ui--autogrow#autogrow"
              },
              **@html_options
            )
          ])
        end
      end
    end
  end
end
