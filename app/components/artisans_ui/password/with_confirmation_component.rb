# frozen_string_literal: true

module ArtisansUi
  module Password
    # Password with Confirmation Component (Variant 3)
    # Password and confirm password fields with matching validation
    # Exact RailsBlocks implementation
    #
    # @example Password with confirmation
    #   <%= render ArtisansUi::Password::WithConfirmationComponent.new %>
    #
    # @example With custom attributes
    #   <%= render ArtisansUi::Password::WithConfirmationComponent.new(
    #     name: "user[password]",
    #     confirm_name: "user[password_confirmation]"
    #   ) %>
    class WithConfirmationComponent < ApplicationViewComponent
      def initialize(name: "password", confirm_name: "password_confirmation", placeholder: "Enter your password", confirm_placeholder: "Confirm your password", **html_options)
        @name = name
        @confirm_name = confirm_name
        @placeholder = placeholder
        @confirm_placeholder = confirm_placeholder
        @html_options = html_options
      end

      def call
        tag.div(
          class: "space-y-4",
          data: {
            controller: "artisans-ui--password",
            "artisans-ui--password-confirm-value": "true"
          }
        ) do
          safe_join([
            password_field,
            confirm_field,
            match_indicator
          ])
        end
      end

      private

      def password_field
        tag.div(class: "space-y-2") do
          safe_join([
            tag.label(
              "Password",
              class: "block text-sm font-medium text-neutral-700 dark:text-neutral-300"
            ),
            password_input_container
          ])
        end
      end

      def password_input_container
        tag.div(class: "relative") do
          safe_join([
            password_input,
            password_toggle_button
          ])
        end
      end

      def password_input
        tag.input(
          type: "password",
          name: @name,
          placeholder: @placeholder,
          class: "w-full px-3 py-2 pr-10 border border-neutral-300 dark:border-neutral-600 rounded-lg bg-white dark:bg-neutral-800 text-neutral-900 dark:text-neutral-100 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400",
          data: {
            "artisans-ui--password-target": "input",
            action: "input->artisans-ui--password#checkMatch"
          },
          **@html_options
        )
      end

      def password_toggle_button
        tag.button(
          type: "button",
          class: "absolute inset-y-0 right-0 flex items-center pr-3 text-neutral-400 hover:text-neutral-600 dark:hover:text-neutral-300",
          data: { action: "click->artisans-ui--password#toggle" }
        ) do
          eye_icon("toggleIcon")
        end
      end

      def confirm_field
        tag.div(class: "space-y-2") do
          safe_join([
            tag.label(
              "Confirm Password",
              class: "block text-sm font-medium text-neutral-700 dark:text-neutral-300"
            ),
            confirm_input_container
          ])
        end
      end

      def confirm_input_container
        tag.div(class: "relative") do
          safe_join([
            confirm_input,
            confirm_toggle_button
          ])
        end
      end

      def confirm_input
        tag.input(
          type: "password",
          name: @confirm_name,
          placeholder: @confirm_placeholder,
          class: "w-full px-3 py-2 pr-10 border border-neutral-300 dark:border-neutral-600 rounded-lg bg-white dark:bg-neutral-800 text-neutral-900 dark:text-neutral-100 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400",
          data: {
            "artisans-ui--password-target": "confirm",
            action: "input->artisans-ui--password#checkMatch"
          }
        )
      end

      def confirm_toggle_button
        tag.button(
          type: "button",
          class: "absolute inset-y-0 right-0 flex items-center pr-3 text-neutral-400 hover:text-neutral-600 dark:hover:text-neutral-300",
          data: { action: "click->artisans-ui--password#toggle" }
        ) do
          eye_icon("confirmToggleIcon")
        end
      end

      def match_indicator
        tag.div(
          class: "hidden",
          data: { "artisans-ui--password-target": "matchIndicator" }
        ) do
          tag.p(
            "",
            class: "text-sm",
            data: { "artisans-ui--password-target": "matchText" }
          )
        end
      end

      def eye_icon(target)
        tag.svg(
          class: "w-5 h-5",
          fill: "none",
          stroke: "currentColor",
          "stroke-width": "2",
          viewBox: "0 0 24 24",
          data: { "artisans-ui--password-target": target }
        ) do
          safe_join([
            tag.path(d: "M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z"),
            tag.path(d: "M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7Z")
          ])
        end
      end
    end
  end
end
