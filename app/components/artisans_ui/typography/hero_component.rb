# frozen_string_literal: true

module ArtisansUi
  module Typography
    # Hero Component
    # Combined heading and subheading for hero sections
    # Automatically renders both with proper spacing
    #
    # @example Simple hero
    #   <%= render ArtisansUi::Typography::HeroComponent.new(
    #     heading: "Find your next role",
    #     subheading: "Search jobs using natural language"
    #   ) %>
    #
    # @example Custom variants
    #   <%= render ArtisansUi::Typography::HeroComponent.new(
    #     heading: "Find your next role",
    #     heading_variant: :display,
    #     subheading: "Search jobs using natural language",
    #     subheading_variant: :large
    #   ) %>
    #
    # @example With additional content block
    #   <%= render ArtisansUi::Typography::HeroComponent.new(
    #     heading: "Find your next role",
    #     subheading: "Search jobs using natural language"
    #   ) do %>
    #     <!-- Search form or other content -->
    #   <% end %>
    #
    # @example Custom heading level
    #   <%= render ArtisansUi::Typography::HeroComponent.new(
    #     heading: "Section Title",
    #     heading_level: :h2,
    #     subheading: "Section description"
    #   ) %>
    class HeroComponent < ApplicationViewComponent
      def initialize(
        heading:,
        subheading:,
        heading_level: :h1,
        heading_variant: :title,
        subheading_variant: :regular,
        **html_options
      )
        @heading = heading
        @subheading = subheading
        @heading_level = heading_level
        @heading_variant = heading_variant
        @subheading_variant = subheading_variant
        @html_options = html_options
      end

      def call
        tag.div(**@html_options) do
          parts = [render_heading, render_subheading]
          parts << content_tag(:div, content) if content?
          safe_join(parts)
        end
      end

      private

      def render_heading
        render ArtisansUi::Typography::HeadingComponent.new(
          level: @heading_level,
          variant: @heading_variant,
          class: "mb-3"
        ) do
          @heading
        end
      end

      def render_subheading
        render ArtisansUi::Typography::SubheadingComponent.new(
          variant: @subheading_variant,
          class: content? ? "mb-6" : nil
        ) do
          @subheading
        end
      end
    end
  end
end
