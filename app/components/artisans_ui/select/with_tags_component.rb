# frozen_string_literal: true

module ArtisansUi
  module Select
    # Select with External Tags Component
    # External tag display (above/below/custom container)
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Select::WithTagsComponent.new(
    #     options: [
    #       { label: "Option 1", value: "1" },
    #       { label: "Option 2", value: "2" }
    #     ],
    #     tags_position: "below"
    #   ) %>
    class WithTagsComponent < ArtisansUi::ApplicationViewComponent
      def initialize(options:, tags_position: "below", **html_options)
        @options = options
        @tags_position = tags_position
        @html_options = html_options
      end

      def call
        tag.div(class: "relative w-full max-w-xs", **@html_options) do
          safe_join([
            render_tags_container_if_above,
            render_select,
            render_tags_container_if_below
          ].compact)
        end
      end

      private

      def render_select
        tag.select(
          multiple: "multiple",
          class: "w-full rounded-lg border border-neutral-300 bg-white px-4 py-2.5 text-sm text-neutral-900 focus:border-primary-500 focus:outline-none focus:ring-2 focus:ring-primary-500/20",
          data: {
            controller: "artisans-ui--select",
            "artisans-ui--select-tags-position-value": @tags_position
          }
        ) do
          safe_join(@options.map { |opt| render_option(opt) })
        end
      end

      def render_tags_container_if_above
        return unless @tags_position == "above"

        tag.div(
          class: "mb-2 flex flex-wrap gap-2",
          data: { "artisans-ui--select-target": "tagsContainer" }
        ) do
          "" # Tags are generated dynamically by the Stimulus controller
        end
      end

      def render_tags_container_if_below
        return unless @tags_position == "below"

        tag.div(
          class: "mt-2 flex flex-wrap gap-2",
          data: { "artisans-ui--select-target": "tagsContainer" }
        ) do
          "" # Tags are generated dynamically by the Stimulus controller
        end
      end

      def render_option(opt)
        tag.option(opt[:label], value: opt[:value])
      end
    end
  end
end
