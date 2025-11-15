# frozen_string_literal: true

module ArtisansUi
  module Confirmation
    # Case-sensitive text confirmation component
    # User must type exact text (case-sensitive) to confirm
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Confirmation::CaseSensitiveComponent.new(
    #     confirm_text: "rails-blocks-production",
    #     title: "Reset Database",
    #     description: "This will permanently delete all data...",
    #     button_text: "Reset Database"
    #   ) %>
    class CaseSensitiveComponent < ApplicationViewComponent
      def initialize(confirm_text:, title:, description:, button_text:, **html_options)
        @confirm_text = confirm_text
        @title = title
        @description = description
        @button_text = button_text
        @html_options = html_options
      end

      def call
        tag.div(
          class: "max-w-md bg-white dark:bg-neutral-800 border border-black/10 dark:border-white/10 rounded-xl shadow-xs overflow-hidden px-4 py-5 sm:p-6",
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
            tag.h3(@title, class: "text-lg font-semibold text-neutral-900 dark:text-white mb-2"),
            tag.p(@description, class: "text-sm text-neutral-600 dark:text-neutral-400")
          ])
        end
      end

      def render_form
        tag.form(
          data: {
            controller: "confirmation",
            confirmation_confirm_text_value: @confirm_text,
            confirmation_case_sensitive_value: true
          }
        ) do
          safe_join([
            render_input_field,
            render_warning,
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
              id: "project-name",
              data: { confirmation_target: "input" },
              class: "form-control",
              autocomplete: "off",
              placeholder: "Enter project name exactly as shown"
            )
          ])
        end
      end

      def render_label
        tag.label(for: "project-name", class: "block text-sm font-medium text-neutral-700 dark:text-neutral-300 mb-2") do
          safe_join([
            "Type ",
            tag.span(@confirm_text, class: "inline rounded-md border border-black/10 bg-white px-1 py-0.5 font-mono text-neutral-800 dark:border-white/10 dark:bg-neutral-900 dark:text-neutral-200"),
            " to confirm:"
          ])
        end
      end

      def render_warning
        tag.div(class: "mb-4 rounded-xl border border-yellow-200 bg-yellow-50 p-4 dark:border-yellow-800 dark:bg-yellow-900/20") do
          tag.div(class: "grid grid-cols-[auto_1fr] gap-2 items-start") do
            safe_join([
              render_warning_icon,
              tag.h3("Warning", class: "text-sm font-medium text-amber-800 dark:text-amber-200"),
              tag.div,
              tag.div("This action is case-sensitive and cannot be undone.", class: "text-sm text-amber-700 dark:text-amber-300")
            ])
          end
        end
      end

      def render_warning_icon
        tag.div(class: "flex items-center h-full") do
          tag.svg(
            xmlns: "http://www.w3.org/2000/svg",
            class: "text-yellow-500 dark:text-yellow-400",
            width: "18",
            height: "18",
            viewBox: "0 0 18 18"
          ) do
            tag.g(fill: "none", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.5", stroke: "currentColor") do
              safe_join([
                tag.path(d: "M7.63796 3.48996L2.21295 12.89C1.60795 13.9399 2.36395 15.25 3.57495 15.25H14.425C15.636 15.25 16.392 13.9399 15.787 12.89L10.362 3.48996C9.75696 2.44996 8.24296 2.44996 7.63796 3.48996Z"),
                tag.path(d: "M9 6.75V9.75"),
                tag.path(d: "M9 13.5C8.448 13.5 8 13.05 8 12.5C8 11.95 8.448 11.5 9 11.5C9.552 11.5 10 11.9501 10 12.5C10 13.0499 9.552 13.5 9 13.5Z", fill: "currentColor", data: { stroke: "none" }, stroke: "none")
              ])
            end
          end
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
          class: "flex items-center justify-center gap-1.5 rounded-lg border border-red-300/30 bg-red-600 px-3.5 py-2 text-sm font-medium whitespace-nowrap text-white shadow-sm transition-all duration-100 ease-in-out select-none hover:bg-red-500 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600 disabled:cursor-not-allowed disabled:opacity-50 dark:focus-visible:outline-neutral-200"
        ) { @button_text }
      end
    end
  end
end
