# frozen_string_literal: true

module ArtisansUi
  module Card
    # Well Card Component (Variant 6)
    # Subtle container with background color and no shadow
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Card::WellComponent.new do %>
    #     <h3 class="text-lg font-medium leading-6 text-neutral-900 dark:text-white mb-2">Well Card</h3>
    #     <p class="text-neutral-700 dark:text-neutral-300">A simple container with subtle background.</p>
    #   <% end %>
    class WellComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.div(
          class: "bg-neutral-50 dark:bg-neutral-900/50 rounded-xl px-6 py-5 border border-black/10 dark:border-white/10",
          **@html_options
        ) do
          content
        end
      end
    end
  end
end
