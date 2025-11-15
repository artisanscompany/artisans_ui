# frozen_string_literal: true

module ArtisansUi
  module Select
    # Select with Infinite Scroll Component
    # Virtual scroll or infinite scroll for large datasets
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Select::WithInfiniteScrollComponent.new(
    #     options: [
    #       { label: "Option 1", value: "1" },
    #       { label: "Option 2", value: "2" }
    #     ],
    #     virtual_scroll: true
    #   ) %>
    class WithInfiniteScrollComponent < ArtisansUi::ApplicationViewComponent
      def initialize(options:, virtual_scroll: true, **html_options)
        @options = options
        @virtual_scroll = virtual_scroll
        @html_options = html_options
      end

      def call
        tag.div(class: "relative w-full max-w-xs", **@html_options) do
          tag.select(
            class: "w-full rounded-lg border border-neutral-300 bg-white px-4 py-2.5 text-sm text-neutral-900 focus:border-primary-500 focus:outline-none focus:ring-2 focus:ring-primary-500/20",
            data: {
              controller: "artisans-ui--select",
              "artisans-ui--select-virtual-scroll-value": @virtual_scroll
            }
          ) do
            safe_join(@options.map { |opt| render_option(opt) })
          end
        end
      end

      private

      def render_option(opt)
        tag.option(opt[:label], value: opt[:value])
      end
    end
  end
end
