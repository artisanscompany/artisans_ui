# frozen_string_literal: true

module ArtisansUi
  module Select
    # Select with Create Option Component
    # Allow creating new options dynamically
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Select::WithCreateOptionComponent.new(
    #     options: [
    #       { label: "Option 1", value: "1" },
    #       { label: "Option 2", value: "2" }
    #     ],
    #     allow_new: true
    #   ) %>
    class WithCreateOptionComponent < ArtisansUi::ApplicationViewComponent
      def initialize(options:, allow_new: true, **html_options)
        @options = options
        @allow_new = allow_new
        @html_options = html_options
      end

      def call
        tag.div(class: "relative w-full max-w-xs", **@html_options) do
          tag.select(
            class: "w-full rounded-lg border border-neutral-300 bg-white px-4 py-2.5 text-sm text-neutral-900 focus:border-primary-500 focus:outline-none focus:ring-2 focus:ring-primary-500/20",
            data: {
              controller: "artisans-ui--select",
              "artisans-ui--select-allow-new-value": @allow_new
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
