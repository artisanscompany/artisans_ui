# frozen_string_literal: true

module ArtisansUi
  module Modal
    # Basic Modal Component
    # Reusable modal dialog with backdrop, header, body, and footer sections
    # Integrates with Stimulus modal controller for open/close functionality
    #
    # @example Basic modal
    #   <%= render ArtisansUi::Modal::BasicComponent.new(
    #     id: "my-modal",
    #     title: "Modal Title",
    #     subtitle: "Optional subtitle text"
    #   ) do %>
    #     <p>Modal body content goes here</p>
    #   <% end %>
    #
    # @example With custom size
    #   <%= render ArtisansUi::Modal::BasicComponent.new(
    #     id: "large-modal",
    #     title: "Large Modal",
    #     size: :lg
    #   ) do %>
    #     <p>Content for a larger modal</p>
    #   <% end %>
    #
    # @example With footer actions
    #   <%= render ArtisansUi::Modal::BasicComponent.new(
    #     id: "confirm-modal",
    #     title: "Confirm Action"
    #   ) do |modal| %>
    #     <p>Are you sure?</p>
    #     <%= modal.footer do %>
    #       <button data-action="click->modal#close">Cancel</button>
    #       <button type="submit">Confirm</button>
    #     <% end %>
    #   <% end %>
    class BasicComponent < ApplicationViewComponent
      attr_reader :id, :title, :subtitle, :size

      renders_one :footer

      def initialize(id:, title:, subtitle: nil, size: :md, **html_options)
        @id = id
        @title = title
        @subtitle = subtitle
        @size = size
        @html_options = html_options
      end

      def call
        tag.div(**modal_wrapper_options) do
          safe_join([
            backdrop,
            modal_container
          ])
        end
      end

      private

      def modal_wrapper_options
        custom_class = @html_options.delete(:class)
        data = @html_options.delete(:data) || {}

        {
          id: @id,
          class: ["hidden fixed inset-0 z-50 overflow-y-auto", custom_class].compact.join(" "),
          data: {
            controller: [data[:controller], "modal"].compact.join(" "),
            **data.except(:controller)
          }.compact,
          **@html_options
        }
      end

      def backdrop
        tag.div(
          class: "fixed inset-0 bg-black/30 backdrop-blur-sm transition-opacity",
          data: { action: "click->modal#closeOnBackdrop" }
        )
      end

      def modal_container
        tag.div(class: "flex min-h-screen items-center justify-center p-4") do
          tag.div(class: "relative w-full #{size_class} transform overflow-hidden rounded-lg bg-white shadow-xl transition-all") do
            safe_join([
              modal_header,
              modal_body,
              (modal_footer if footer?)
            ].compact)
          end
        end
      end

      def modal_header
        tag.div(class: "border-b border-gray-200 px-6 py-4") do
          tag.div(class: "flex items-center justify-between") do
            safe_join([
              tag.div do
                safe_join([
                  tag.h3(@title, class: "text-lg font-semibold text-gray-900"),
                  (@subtitle ? tag.p(@subtitle, class: "mt-1 text-sm text-gray-600") : nil)
                ].compact)
              end,
              close_button
            ])
          end
        end
      end

      def close_button
        tag.button(
          type: "button",
          class: "rounded-md text-gray-400 hover:text-gray-500 focus:outline-none transition-colors",
          data: { action: "click->modal#close" },
          aria: { label: "Close" }
        ) do
          tag.svg(
            class: "h-6 w-6",
            fill: "none",
            stroke: "currentColor",
            viewBox: "0 0 24 24"
          ) do
            tag.path(
              stroke_linecap: "round",
              stroke_linejoin: "round",
              stroke_width: "2",
              d: "M6 18L18 6M6 6l12 12"
            )
          end
        end
      end

      def modal_body
        tag.div(content, class: "px-6 py-4")
      end

      def modal_footer
        tag.div(footer, class: "px-6 py-4 border-t border-gray-100")
      end

      def size_class
        case @size
        when :sm then "max-w-sm"
        when :md then "max-w-md"
        when :lg then "max-w-lg"
        when :xl then "max-w-xl"
        when :xxl then "max-w-2xl"
        else "max-w-md"
        end
      end
    end
  end
end
