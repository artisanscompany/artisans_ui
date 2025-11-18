# frozen_string_literal: true

module ArtisansUi
  module Card
    # Edge-to-Edge Card Component (Variant 5)
    # Responsive card that extends to full width on mobile
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Card::EdgeToEdgeComponent.new do |card| %>
    #     <% card.with_body do %>
    #       <h3 class="text-lg font-medium leading-6 text-neutral-900 mb-2">Edge-to-Edge on Mobile</h3>
    #       <p class="text-neutral-700">Full width on mobile, standard on desktop</p>
    #     <% end %>
    #     <% card.with_footer do %>
    #       <div class="text-sm text-neutral-500">Resize to see behavior</div>
    #     <% end %>
    #   <% end %>
    class EdgeToEdgeComponent < ApplicationViewComponent
      renders_one :body
      renders_one :footer

      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.div(
          class: "bg-white border-y sm:border border-black/10 overflow-hidden shadow-xs sm:rounded-xl",
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

        content_tag(:div, footer, class: "bg-neutral-50 px-4 py-4 sm:px-6 border-t border-black/10")
      end
    end
  end
end
