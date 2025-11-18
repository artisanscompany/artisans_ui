# frozen_string_literal: true

module ArtisansUi
  module Password
    # Password with Strength Indicator Component (Variant 2)
    # Password input with real-time strength bar and text feedback
    # Exact RailsBlocks implementation
    #
    # @example Password with strength indicator
    #   <%= render ArtisansUi::Password::WithStrengthIndicatorComponent.new %>
    #
    # @example With custom attributes
    #   <%= render ArtisansUi::Password::WithStrengthIndicatorComponent.new(
    #     name: "user[password]",
    #     placeholder: "Create a strong password"
    #   ) %>
    class WithStrengthIndicatorComponent < ApplicationViewComponent
      def initialize(name: "password", placeholder: "Enter your password", **html_options)
        @name = name
        @placeholder = placeholder
        @html_options = html_options
      end

      def call
        tag.div(class: "space-y-2") do
          safe_join([
            label_tag,
            input_container,
            strength_container
          ])
        end
      end

      private

      def label_tag
        tag.label(
          "Password",
          class: "block text-sm font-medium text-neutral-700"
        )
      end

      def input_container
        tag.div(
          class: "relative",
          data: {
            controller: "artisans-ui--password",
            "artisans-ui--password-strength-value": "true"
          }
        ) do
          safe_join([
            password_input,
            toggle_button
          ])
        end
      end

      def password_input
        tag.input(
          type: "password",
          name: @name,
          placeholder: @placeholder,
          class: "w-full px-3 py-2 pr-10 border border-neutral-300 rounded-lg bg-white text-neutral-900 focus:outline-none focus:ring-2 focus:ring-blue-500",
          data: {
            "artisans-ui--password-target": "input",
            action: "input->artisans-ui--password#handleInput"
          },
          **@html_options
        )
      end

      def toggle_button
        tag.button(
          type: "button",
          class: "absolute inset-y-0 right-0 flex items-center pr-3 text-neutral-400 hover:text-neutral-600",
          data: { action: "click->artisans-ui--password#toggle" }
        ) do
          eye_icon
        end
      end

      def eye_icon
        tag.svg(
          class: "w-5 h-5",
          fill: "none",
          stroke: "currentColor",
          "stroke-width": "2",
          viewBox: "0 0 24 24",
          data: { "artisans-ui--password-target": "toggleIcon" }
        ) do
          safe_join([
            tag.path(d: "M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z"),
            tag.path(d: "M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7Z")
          ])
        end
      end

      def strength_container
        tag.div(class: "space-y-1") do
          safe_join([
            strength_bar,
            strength_text
          ])
        end
      end

      def strength_bar
        tag.div(class: "h-2 bg-neutral-200 rounded-full overflow-hidden") do
          tag.div(
            class: "h-full bg-neutral-300 transition-all duration-300",
            style: "width: 0%",
            data: { "artisans-ui--password-target": "strengthBar" }
          )
        end
      end

      def strength_text
        tag.p(
          "Password strength: ",
          class: "text-xs text-neutral-500",
          data: { "artisans-ui--password-target": "strengthText" }
        )
      end
    end
  end
end
