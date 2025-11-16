# frozen_string_literal: true

module ArtisansUi
  module Form
    # Select Component
    # Standalone select dropdown field inspired by RailsBlocks
    # Supports basic native selects and can be enhanced with Stimulus for advanced features
    #
    # @example Basic select with content block
    #   <%= render ArtisansUi::Form::SelectComponent.new(name: :country) do %>
    #     <option value="">Select country</option>
    #     <option value="us">United States</option>
    #     <option value="uk">United Kingdom</option>
    #   <% end %>
    #
    # @example With multiple selection
    #   <%= render ArtisansUi::Form::SelectComponent.new(
    #     name: :tags,
    #     multiple: true
    #   ) do %>
    #     <option value="ruby">Ruby</option>
    #     <option value="rails">Rails</option>
    #     <option value="js">JavaScript</option>
    #   <% end %>
    #
    # @example With Stimulus controller for enhanced features (search, remote data, etc.)
    #   <%= render ArtisansUi::Form::SelectComponent.new(
    #     name: :user_id,
    #     data: {
    #       controller: "select",
    #       select_url_value: "/api/users",
    #       select_label_field_value: "name"
    #     }
    #   ) do %>
    #     <option value="">Select user</option>
    #   <% end %>
    class SelectComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.select(content, **merged_options)
      end

      private

      def merged_options
        custom_class = @html_options.delete(:class)
        @html_options.merge(class: [default_classes, custom_class].compact.join(" "))
      end

      def default_classes
        "w-full px-4 py-2.5 text-sm border border-neutral-200 dark:border-neutral-800 rounded-lg bg-white dark:bg-neutral-900 text-neutral-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-neutral-400 dark:focus:ring-neutral-600 focus:border-transparent transition-colors"
      end
    end
  end
end
