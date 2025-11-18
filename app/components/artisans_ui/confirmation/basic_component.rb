# frozen_string_literal: true

module ArtisansUi
  module Confirmation
    # Basic text confirmation component
    # User must type specific text to confirm destructive actions
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Confirmation::BasicComponent.new(
    #     confirm_text: "DELETE",
    #     title: "Delete Account",
    #     description: "This action cannot be undone...",
    #     button_text: "Delete Account"
    #   ) %>
    class BasicComponent < ApplicationViewComponent
      def initialize(confirm_text:, title:, description:, button_text:, **html_options)
        @confirm_text = confirm_text
        @title = title
        @description = description
        @button_text = button_text
        @html_options = html_options
      end

      def call
        tag.div(
          class: "max-w-md bg-white border border-black/10 rounded-xl shadow-xs overflow-hidden px-4 py-5 sm:p-6",
          **@html_options
        ) do
          safe_join([
            render_header,
            render_form
          ])
        end
      end

      private

      def render_header
        tag.div(class: "mb-4") do
          safe_join([
            tag.h3(@title, class: "text-lg font-semibold text-neutral-900 mb-2"),
            tag.p(@description, class: "text-sm text-neutral-600")
          ])
        end
      end

      def render_form
        tag.form(
          data: {
            controller: "confirmation",
            confirmation_confirm_text_value: @confirm_text
          }
        ) do
          safe_join([
            render_input_field,
            render_actions
          ])
        end
      end

      def render_input_field
        tag.div(class: "mb-4") do
          safe_join([
            render_label,
            tag.input(
              type: "text",
              id: "confirm-delete",
              data: { confirmation_target: "input" },
              class: "form-control",
              autocomplete: "off",
              placeholder: "Type #{@confirm_text} to confirm"
            )
          ])
        end
      end

      def render_label
        tag.label(for: "confirm-delete", class: "block text-sm font-medium text-neutral-700 mb-2") do
          safe_join([
            "Type ",
            tag.span(@confirm_text, class: "inline rounded-md border border-black/10 bg-white px-1 py-0.5 font-mono text-neutral-800"),
            " to confirm:"
          ])
        end
      end

      def render_actions
        tag.div(class: "flex gap-3 justify-end") do
          safe_join([
            render_cancel_button,
            render_confirm_button
          ])
        end
      end

      def render_cancel_button
        tag.button(
          type: "button",
          data: { action: "click->confirmation#cancel" },
          class: "flex items-center justify-center gap-1.5 rounded-lg border border-neutral-200 bg-white/90 px-3.5 py-2 text-sm font-medium whitespace-nowrap text-neutral-800 shadow-xs transition-all duration-100 ease-in-out select-none hover:bg-neutral-50 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600 disabled:cursor-not-allowed disabled:opacity-50"
        ) { "Cancel" }
      end

      def render_confirm_button
        tag.button(
          type: "button",
          data: {
            confirmation_target: "confirmButton",
            action: "click->confirmation#confirm"
          },
          disabled: true,
          class: "flex items-center justify-center gap-1.5 rounded-lg border border-red-300/30 bg-red-600 px-3.5 py-2 text-sm font-medium whitespace-nowrap text-white shadow-sm transition-all duration-100 ease-in-out select-none hover:bg-red-500 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600 disabled:cursor-not-allowed disabled:opacity-50"
        ) { @button_text }
      end
    end
  end
end
