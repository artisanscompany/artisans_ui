# frozen_string_literal: true

module ArtisansUi
  module Password
    # Basic Password Component (Variant 1)
    # Simple password input with show/hide toggle button
    # Exact RailsBlocks implementation
    #
    # @example Basic password
    #   <%= render ArtisansUi::Password::BasicComponent.new %>
    #
    # @example With custom attributes
    #   <%= render ArtisansUi::Password::BasicComponent.new(
    #     name: "user[password]",
    #     placeholder: "Enter your password"
    #   ) %>
    class BasicComponent < ApplicationViewComponent
      def initialize(name: "password", placeholder: "Enter your password", **html_options)
        @name = name
        @placeholder = placeholder
        @html_options = html_options
      end

      def call
        tag.div(class: "space-y-2") do
          safe_join([
            label_tag,
            input_container
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
        tag.div(class: "relative", data: { controller: "artisans-ui--password" }) do
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
          data: { "artisans-ui--password-target": "input" },
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
    end
  end
end
