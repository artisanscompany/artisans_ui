# frozen_string_literal: true

module ArtisansUi
  module Select
    # Async Loading Select Component
    # Remote data loading from API endpoint
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Select::AsyncLoadingComponent.new(
    #     url: "/api/items",
    #     placeholder: "Select an item..."
    #   ) %>
    class AsyncLoadingComponent < ArtisansUi::ApplicationViewComponent
      def initialize(url:, placeholder: "Select...", **html_options)
        @url = url
        @placeholder = placeholder
        @html_options = html_options
      end

      def call
        tag.div(class: "relative w-full max-w-xs", **@html_options) do
          tag.select(
            class: "w-full rounded-lg border border-neutral-300 bg-white px-4 py-2.5 text-sm text-neutral-900 focus:border-primary-500 focus:outline-none focus:ring-2 focus:ring-primary-500/20",
            data: {
              controller: "artisans-ui--select",
              "artisans-ui--select-url-value": @url
            }
          ) do
            tag.option(@placeholder, value: "", disabled: true, selected: true)
          end
        end
      end
    end
  end
end
