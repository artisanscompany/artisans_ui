# frozen_string_literal: true

module ArtisansUi
  module Confirmation
    # Any text confirmation component
    # User can type any text to confirm (no specific text required)
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Confirmation::AnyTextComponent.new(
    #     title: "Create new project",
    #     label: "Enter the project name:",
    #     placeholder: "Type any text to confirm...",
    #     button_text: "Create Project"
    #   ) %>
    class AnyTextComponent < ApplicationViewComponent
      def initialize(title:, label:, placeholder:, button_text:, **html_options)
        @title = title
        @label = label
        @placeholder = placeholder
        @button_text = button_text
        @html_options = html_options
      end

      def call
        tag.div(
          class: "w-full max-w-md bg-white dark:bg-neutral-800 border border-black/10 dark:border-white/10 rounded-xl shadow-xs overflow-hidden px-4 py-5 sm:p-6",
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
          tag.h3(@title, class: "text-lg font-semibold text-neutral-900 dark:text-white mb-2")
        end
      end

      def render_form
        tag.form(
          data: {
            controller: "confirmation",
            confirmation_confirm_text_value: ""
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
            tag.label(@label, for: "project-name", class: "block text-sm font-medium text-neutral-700 dark:text-neutral-300 mb-2"),
            tag.input(
              type: "text",
              id: "project-name",
              data: { confirmation_target: "input" },
              class: "form-control",
              autocomplete: "off",
              placeholder: @placeholder
            )
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
          class: "flex items-center justify-center gap-1.5 rounded-lg border border-neutral-200 bg-white/90 px-3.5 py-2 text-sm font-medium whitespace-nowrap text-neutral-800 shadow-xs transition-all duration-100 ease-in-out select-none hover:bg-neutral-50 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600 disabled:cursor-not-allowed disabled:opacity-50 dark:border-neutral-700 dark:bg-neutral-800/50 dark:text-neutral-50 dark:hover:bg-neutral-700/50 dark:focus-visible:outline-neutral-200"
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
          class: "flex items-center justify-center gap-1.5 rounded-lg border border-neutral-400/30 bg-neutral-800 px-3.5 py-2 text-sm font-medium whitespace-nowrap text-white shadow-sm transition-all duration-100 ease-in-out select-none hover:bg-neutral-700 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600 disabled:cursor-not-allowed disabled:opacity-50 dark:bg-white dark:text-neutral-800 dark:hover:bg-neutral-100 dark:focus-visible:outline-neutral-200"
        ) { @button_text }
      end
    end
  end
end
