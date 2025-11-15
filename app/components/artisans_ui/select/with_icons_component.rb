# frozen_string_literal: true

module ArtisansUi
  module Select
    # Select with Icons Component
    # Options with icons or images
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Select::WithIconsComponent.new(
    #     options: [
    #       { label: "Option 1", value: "1", icon: "https://placehold.co/24x24" },
    #       { label: "Option 2", value: "2", icon: "https://placehold.co/24x24" }
    #     ]
    #   ) %>
    class WithIconsComponent < ArtisansUi::ApplicationViewComponent
      def initialize(options:, **html_options)
        @options = options
        @html_options = html_options
      end

      def call
        tag.div(class: "relative w-full max-w-xs", **@html_options) do
          tag.select(
            class: "w-full rounded-lg border border-neutral-300 bg-white px-4 py-2.5 text-sm text-neutral-900 focus:border-primary-500 focus:outline-none focus:ring-2 focus:ring-primary-500/20",
            data: {
              controller: "artisans-ui--select",
              "artisans-ui--select-icons-value": true
            }
          ) do
            safe_join(@options.map { |opt| render_option(opt) })
          end
        end
      end

      private

      def render_option(opt)
        option_data = {
          label: opt[:label],
          value: opt[:value]
        }
        option_data[:icon] = opt[:icon] if opt[:icon]

        tag.option(
          opt[:label],
          value: opt[:value],
          data: { icon: opt[:icon] }.compact
        )
      end
    end
  end
end
