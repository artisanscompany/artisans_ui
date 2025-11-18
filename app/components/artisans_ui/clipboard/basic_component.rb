# frozen_string_literal: true

module ArtisansUi
  module Clipboard
    # Basic clipboard button
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Clipboard::BasicComponent.new(text: "Hello from Rails Blocks!") do %>
    #     Copy Text
    #   <% end %>
    class BasicComponent < ApplicationViewComponent
      def initialize(text:, **html_options)
        @text = text
        @html_options = html_options
      end

      def call
        tag.button(
          class: "flex items-center justify-center gap-1.5 rounded-lg border border-neutral-400/30 bg-neutral-800 px-3.5 py-2 text-sm font-medium whitespace-nowrap text-white shadow-sm transition-all duration-100 ease-in-out select-none hover:bg-neutral-700 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600 disabled:cursor-not-allowed disabled:opacity-50",
          data: {
            controller: "clipboard",
            clipboard_text: @text
          },
          **@html_options
        ) do
          content
        end
      end
    end
  end
end
