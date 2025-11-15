# frozen_string_literal: true

module ArtisansUi
  module Checkbox
    # Custom Checkbox Component
    # Custom styled checkbox with animated checkmark icon
    # Uses peer classes and hidden input for advanced styling
    #
    # @example Basic custom checkbox
    #   <%= render ArtisansUi::Checkbox::CustomComponent.new(
    #     label: "I agree to the terms",
    #     name: "agreement",
    #     value: "terms"
    #   ) %>
    #
    # @example Checked custom checkbox
    #   <%= render ArtisansUi::Checkbox::CustomComponent.new(
    #     label: "Subscribe to newsletter",
    #     name: "subscription",
    #     value: "newsletter",
    #     checked: true
    #   ) %>
    #
    # @example Custom checkbox with custom ID
    #   <%= render ArtisansUi::Checkbox::CustomComponent.new(
    #     label: "Enable notifications",
    #     name: "settings",
    #     value: "notifications",
    #     id: "notify-toggle"
    #   ) %>
    class CustomComponent < ApplicationViewComponent
      def initialize(label:, name:, value: nil, checked: false, id: nil)
        @label = label
        @name = name
        @value = value
        @checked = checked
        @id = id || generate_id
      end

      def call
        tag.label(for: @id, class: label_classes) do
          safe_join([
            checkbox_input,
            animated_icon,
            label_text
          ])
        end
      end

      private

      def checkbox_input
        tag.input(
          type: "checkbox",
          id: @id,
          name: @name,
          value: @value,
          checked: @checked,
          class: "peer hidden"
        )
      end

      def animated_icon
        tag.span(class: icon_classes) do
          checkmark_svg
        end
      end

      def checkmark_svg
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          class: "size-2.5 shrink-0",
          width: "12",
          height: "12",
          viewBox: "0 0 12 12"
        ) do
          tag.g(
            fill: "none",
            stroke_linecap: "round",
            stroke_linejoin: "round",
            stroke_width: "1.8",
            stroke: "currentColor"
          ) do
            tag.path(
              d: "m1.75,6c1.047,1.048,1.803,2.153,2.461,3.579,1.524-3.076,3.659-5.397,6.039-7.158"
            )
          end
        end
      end

      def label_text
        tag.span(@label, class: "block")
      end

      def label_classes
        "relative py-2 px-2.5 flex items-center font-medium bg-white text-neutral-800 rounded-xl cursor-pointer ring-1 ring-neutral-200 has-[:checked]:ring-2 has-[:checked]:ring-neutral-400 dark:bg-neutral-700/50 dark:text-neutral-200 dark:ring-neutral-700 dark:has-[:checked]:ring-neutral-400 has-[:checked]:bg-neutral-100 has-[:checked]:text-neutral-900 dark:has-[:checked]:bg-neutral-600/60 dark:has-[:checked]:text-white"
      end

      def icon_classes
        "flex size-0 shrink-0 items-center justify-center rounded-full bg-neutral-700 text-transparent transition-all duration-200 peer-checked:me-1.5 peer-checked:size-4 peer-checked:text-white dark:bg-neutral-50 dark:peer-checked:text-neutral-800"
      end

      def generate_id
        "checkbox_#{SecureRandom.hex(4)}"
      end
    end
  end
end
