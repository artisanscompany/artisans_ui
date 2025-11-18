# frozen_string_literal: true

module ArtisansUi
  module Autogrow
    # Single Line Autogrow Component (Variant 2)
    # Compact autogrow textarea that starts as a single line
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Autogrow::SingleLineComponent.new(
    #     label: "Quick Note:",
    #     id: "single-line-autogrow",
    #     placeholder: "Write a quick note..."
    #   ) %>
    class SingleLineComponent < ApplicationViewComponent
      def initialize(label:, id:, placeholder: nil, **html_options)
        @label = label
        @id = id
        @placeholder = placeholder
        @html_options = html_options
      end

      def call
        tag.div(class: "w-full max-w-md") do
          safe_join([
            tag.label(
              @label,
              for: @id,
              class: "block text-sm font-medium text-neutral-700 mb-2"
            ),
            tag.textarea(
              "",
              id: @id,
              rows: 1,
              class: "form-control min-h-10 max-h-52 resize-none small-scrollbar",
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
