# frozen_string_literal: true

module ArtisansUi
  module Card
    # Complete Card Component (Variant 4)
    # Card with header, body, and footer sections
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Card::CompleteComponent.new do |card| %>
    #     <% card.with_header do %>
    #       <h3 class="text-lg leading-6 font-medium text-neutral-900">Complete Card</h3>
    #       <p class="mt-1 text-sm text-neutral-600">Header, body, and footer sections</p>
    #     <% end %>
    #     <% card.with_body do %>
    #       <p class="text-neutral-700">Main content area</p>
    #     <% end %>
    #     <% card.with_footer do %>
    #       <div class="flex justify-between">
    #         <button type="button" class="...">Cancel</button>
    #         <button type="button" class="...">Save Changes</button>
    #       </div>
    #     <% end %>
    #   <% end %>
    class CompleteComponent < ApplicationViewComponent
      renders_one :header
      renders_one :body
      renders_one :footer

      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.div(
          class: "bg-white border border-black/10 rounded-xl shadow-xs overflow-hidden",
          **@html_options
        ) do
          safe_join([
            render_header,
            render_body,
            render_footer
          ].compact)
        end
      end

      private

      def render_header
        return unless header?

        content_tag(:div, header, class: "bg-neutral-50 px-4 py-5 sm:px-6 border-b border-black/10")
      end

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
