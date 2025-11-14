# frozen_string_literal: true

module ArtisansUi
  module Ui
    # Card component with flexible layout supporting header, body, and footer slots.
    # Inspired by RailsBlocks card patterns with dark mode support.
    #
    # @example Basic card with body
    #   <%= render ArtisansUi::Ui::CardComponent.new do |card| %>
    #     <% card.with_body do %>
    #       <p>Content here</p>
    #     <% end %>
    #   <% end %>
    #
    # @example Card with all sections
    #   <%= render ArtisansUi::Ui::CardComponent.new do |card| %>
    #     <% card.with_header { "Title" } %>
    #     <% card.with_body { "Body content" } %>
    #     <% card.with_footer { "Footer actions" } %>
    #   <% end %>
    class CardComponent < ApplicationViewComponent
      renders_one :header
      renders_one :body
      renders_one :footer

      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.div(**card_attributes) do
          safe_join([
            render_header,
            render_body,
            render_footer
          ].compact)
        end
      end

      private

      def card_attributes
        {
          class: card_classes,
          **@html_options
        }
      end

      def card_classes
        base_classes = "bg-white dark:bg-neutral-800 border border-black/10 dark:border-white/10 rounded-xl shadow-xs overflow-hidden"

        # Add divide classes if we have multiple sections
        divide_classes = multiple_sections? ? "divide-y divide-black/10 dark:divide-white/10" : ""

        [base_classes, divide_classes, @html_options[:class]].compact.join(" ")
      end

      def multiple_sections?
        [header?, body?, footer?].count(true) > 1
      end

      def render_header
        return unless header?

        content_tag(:div, header, class: "px-4 py-5 sm:px-6")
      end

      def render_body
        return unless body?

        content_tag(:div, body, class: "px-4 py-5 sm:p-6")
      end

      def render_footer
        return unless footer?

        content_tag(:div, footer, class: "px-4 py-5 sm:px-6 bg-neutral-50 dark:bg-neutral-900/50")
      end
    end
  end
end
