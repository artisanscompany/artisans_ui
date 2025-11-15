# frozen_string_literal: true

module ArtisansUi
  module Card
    # Card with Footer Component (Variant 3)
    # Card with footer section for actions, links, or additional information
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Card::WithFooterComponent.new do |card| %>
    #     <% card.with_body do %>
    #       <h3 class="text-lg font-medium leading-6 text-neutral-900 dark:text-white mb-2">Card with Footer</h3>
    #       <p class="text-neutral-700 dark:text-neutral-300">Main content</p>
    #     <% end %>
    #     <% card.with_footer do %>
    #       <div class="text-sm">
    #         <a href="#" class="font-medium text-blue-600 dark:text-blue-400 hover:text-blue-500">View details</a>
    #       </div>
    #     <% end %>
    #   <% end %>
    class WithFooterComponent < ApplicationViewComponent
      renders_one :body
      renders_one :footer

      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.div(
          class: "bg-white dark:bg-neutral-800 border border-black/10 dark:border-white/10 rounded-xl shadow-xs overflow-hidden",
          **@html_options
        ) do
          safe_join([
            render_body,
            render_footer
          ].compact)
        end
      end

      private

      def render_body
        return unless body?

        content_tag(:div, body, class: "px-4 py-5 sm:p-6")
      end

      def render_footer
        return unless footer?

        content_tag(:div, footer, class: "bg-neutral-50 dark:bg-neutral-900/50 px-4 py-4 sm:px-6 border-t border-black/10 dark:border-white/10")
      end
    end
  end
end
