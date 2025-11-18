# frozen_string_literal: true

module ArtisansUi
  module Card
    # Card with Header Component (Variant 2)
    # Card with distinct header section separated by divider
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Card::WithHeaderComponent.new do |card| %>
    #     <% card.with_header do %>
    #       <h3 class="text-lg leading-6 font-medium text-neutral-900">Card with Header</h3>
    #       <p class="mt-1 text-sm text-neutral-600">This card has a header section</p>
    #     <% end %>
    #     <% card.with_body do %>
    #       <p class="text-neutral-700">Main content goes here.</p>
    #     <% end %>
    #   <% end %>
    class WithHeaderComponent < ApplicationViewComponent
      renders_one :header
      renders_one :body

      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.div(
          class: "bg-white border border-black/10 rounded-xl shadow-xs overflow-hidden divide-y divide-black/10",
          **@html_options
        ) do
          safe_join([
            render_header,
            render_body
          ].compact)
        end
      end

      private

      def render_header
        return unless header?

        content_tag(:div, header, class: "px-4 py-5 sm:px-6")
      end

      def render_body
        return unless body?

        content_tag(:div, body, class: "px-4 py-5 sm:p-6")
      end
    end
  end
end
