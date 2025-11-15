# frozen_string_literal: true

module ArtisansUi
  module Card
    # Basic Card Component (Variant 1)
    # Simple card with shadow and rounded corners
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Card::BasicComponent.new do %>
    #     <h3 class="text-lg font-medium leading-6 text-neutral-900 dark:text-white">Basic Card</h3>
    #     <div class="mt-2 max-w-xl text-sm text-neutral-600 dark:text-neutral-400">
    #       <p>This is a basic card component.</p>
    #     </div>
    #   <% end %>
    class BasicComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.div(
          class: "bg-white dark:bg-neutral-800 border border-black/10 dark:border-white/10 rounded-xl shadow-xs overflow-hidden",
          **@html_options
        ) do
          tag.div(class: "px-4 py-5 sm:p-6") do
            content
          end
        end
      end
    end
  end
end
