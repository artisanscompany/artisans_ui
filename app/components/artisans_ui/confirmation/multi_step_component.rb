# frozen_string_literal: true

module ArtisansUi
  module Confirmation
    # Multi-step confirmation component
    # Requires text input AND multiple checkbox confirmations
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Confirmation::MultiStepComponent.new(
    #     confirm_text: "TRANSFER",
    #     title: "Transfer Project Ownership",
    #     description: "Please type 'TRANSFER' AND select all checkboxes...",
    #     confirmations: [
    #       { id: "ownership", title: "I understand that ownership will be transferred immediately", description: "You will lose admin access to this project" },
    #       { id: "billing", title: "I understand billing responsibility will transfer", description: "All future charges will be billed to the new owner" },
    #       { id: "access", title: "I understand this action cannot be undone", description: "You will need to request access from the new owner" }
    #     ],
    #     button_text: "Transfer Ownership"
    #   ) %>
    class MultiStepComponent < ApplicationViewComponent
      def initialize(confirm_text:, title:, description:, confirmations:, button_text:, **html_options)
        @confirm_text = confirm_text
        @title = title
        @description = description
        @confirmations = confirmations
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
            confirmation_confirm_text_value: @confirm_text
          }
        ) do
          safe_join([
            render_input_field,
            render_checkboxes,
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
              id: "transfer-input",
              data: { confirmation_target: "input" },
              placeholder: "Type #{@confirm_text} to confirm",
              autocomplete: "off",
              class: "form-control"
            )
          ])
        end
      end

      def render_label
        tag.label(for: "transfer-input", class: "block text-sm font-medium text-neutral-900 dark:text-white mb-2") do
          safe_join([
            "Type ",
            tag.span(@confirm_text, class: "inline rounded-md border border-black/10 bg-white px-1 py-0.5 font-mono text-neutral-800 dark:border-white/10 dark:bg-neutral-900 dark:text-neutral-200"),
            " to confirm"
          ])
        end
      end

      def render_checkboxes
        tag.fieldset(class: "space-y-3 max-w-sm w-full mb-6") do
          safe_join([
            tag.legend("Confirm transfer consequences", class: "sr-only"),
            safe_join(
              @confirmations.map { |confirmation| render_checkbox(confirmation) }
            )
          ])
        end
      end

      def render_checkbox(confirmation)
        checkbox_id = "#{confirmation[:id]}-checkbox"

        tag.label(
          for: checkbox_id,
          class: "relative py-3 px-4 flex items-center font-medium bg-white text-neutral-800 rounded-xl cursor-pointer ring-1 ring-neutral-200 has-[:checked]:ring-2 has-[:checked]:ring-neutral-400 dark:bg-neutral-700/50 dark:text-neutral-200 dark:ring-neutral-700 dark:has-[:checked]:ring-neutral-400 has-[:checked]:bg-neutral-100 has-[:checked]:text-neutral-900 dark:has-[:checked]:bg-neutral-600/60 dark:has-[:checked]:text-white",
          data: { confirmation_item: confirmation[:id] },
          role: "checkbox",
          aria: { checked: "false" },
          tabindex: "0"
        ) do
          safe_join([
            tag.input(
              type: "checkbox",
              id: checkbox_id,
              class: "absolute left-4",
              data: { confirmation_target: "checkbox" }
            ),
            tag.div(class: "flex-1 ml-8") do
              tag.div(class: "flex items-center justify-between") do
                tag.div do
                  safe_join([
                    tag.h3(confirmation[:title], class: "text-sm font-semibold dark:text-neutral-100"),
                    tag.p(confirmation[:description], class: "text-xs text-neutral-500 dark:text-neutral-400")
                  ])
                end
              end
            end
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
          class: "flex items-center justify-center gap-1.5 rounded-lg border border-neutral-400/30 bg-neutral-800 px-3.5 py-2 text-sm font-medium whitespace-nowrap text-white shadow-sm transition-all duration-100 ease-in-out select-none hover:bg-neutral-700 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600 disabled:cursor-not-allowed disabled:opacity-50 dark:bg-white dark:text-neutral-800 dark:hover:bg-neutral-100 dark:focus-visible:outline-neutral-200 opacity-50 cursor-not-allowed"
        ) { @button_text }
      end
    end
  end
end
