# frozen_string_literal: true

module ArtisansUi
  module Form
    # Field Component
    # Wrapper component for label and error message display
    # Users compose their own input components inside the block
    #
    # @example With text input
    #   <%= render ArtisansUi::Form::FieldComponent.new(label: "Name") do %>
    #     <%= render ArtisansUi::Form::TextInputComponent.new(name: :name) %>
    #   <% end %>
    #
    # @example With error
    #   <%= render ArtisansUi::Form::FieldComponent.new(
    #     label: "Email",
    #     error: "Invalid email address"
    #   ) do %>
    #     <%= render ArtisansUi::Form::ErrorInputComponent.new(
    #       type: :email,
    #       name: :email,
    #       value: "bad@"
    #     ) %>
    #   <% end %>
    #
    # @example Without label
    #   <%= render ArtisansUi::Form::FieldComponent.new do %>
    #     <%= render ArtisansUi::Form::SearchInputComponent.new(name: :q) %>
    #   <% end %>
    class FieldComponent < ApplicationViewComponent
      def initialize(label: nil, error: nil, label_for: nil, **html_options)
        @label = label
        @error = error
        @label_for = label_for
        @html_options = html_options
      end

      def call
        tag.div(class: "relative gap-y-1.5", **@html_options) do
          safe_join([render_label, content, render_error].compact)
        end
      end

      private

      def render_label
        return unless @label

        tag.label(
          @label,
          for: @label_for,
          class: "block text-sm font-medium text-neutral-900 dark:text-white mb-3"
        )
      end

      def render_error
        return unless @error

        tag.p(@error, class: "mt-1.5 text-sm text-red-600 dark:text-red-400")
      end
    end
  end
end
