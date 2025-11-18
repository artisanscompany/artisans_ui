# frozen_string_literal: true

module ArtisansUi
  module Password
    # Password with Requirements Component (Variant 4)
    # Password with interactive checklist (length, lowercase, uppercase, number)
    # Exact RailsBlocks implementation
    #
    # @example Password with requirements
    #   <%= render ArtisansUi::Password::WithRequirementsComponent.new %>
    #
    # @example With custom attributes
    #   <%= render ArtisansUi::Password::WithRequirementsComponent.new(
    #     name: "user[password]",
    #     placeholder: "Create a secure password"
    #   ) %>
    class WithRequirementsComponent < ApplicationViewComponent
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
            requirements_list
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
            "artisans-ui--password-requirements-value": "true"
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

      def requirements_list
        tag.ul(class: "space-y-2 text-sm") do
          safe_join([
            requirement_item("At least 8 characters", "lengthCheck"),
            requirement_item("One lowercase letter", "lowercaseCheck"),
            requirement_item("One uppercase letter", "uppercaseCheck"),
            requirement_item("One number", "numberCheck")
          ])
        end
      end

      def requirement_item(text, target)
        tag.li(
          class: "flex items-center gap-2 text-neutral-600",
          data: { "artisans-ui--password-target": target }
        ) do
          safe_join([
            check_icons,
            tag.span(text)
          ])
        end
      end

      def check_icons
        safe_join([
          unchecked_icon,
          checked_icon
        ])
      end

      def unchecked_icon
        tag.svg(
          class: "w-5 h-5 text-neutral-400",
          fill: "none",
          stroke: "currentColor",
          "stroke-width": "2",
          viewBox: "0 0 24 24"
        ) do
          tag.circle(cx: "12", cy: "12", r: "10")
        end
      end

      def checked_icon
        tag.svg(
          class: "w-5 h-5 text-green-500 hidden",
          fill: "none",
          stroke: "currentColor",
          "stroke-width": "2",
          viewBox: "0 0 24 24"
        ) do
          safe_join([
            tag.path(d: "M22 11.08V12a10 10 0 1 1-5.93-9.14"),
            tag.path(d: "m9 11 3 3L22 4")
          ])
        end
      end
    end
  end
end
