# frozen_string_literal: true

module ArtisansUi
  module Radio
    # Basic Radio Component (Variant 1)
    # Simple radio group with legend and 4 options (1 checked, 1 disabled)
    # Uses existing application.css radio styles
    # Exact RailsBlocks implementation
    #
    # @example Basic radio group
    #   <%= render ArtisansUi::Radio::BasicComponent.new %>
    class BasicComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.fieldset(class: "flex flex-col gap-2") do
          safe_join([
            tag.legend("Choose your favorite framework", class: "text-sm font-semibold mb-2"),
            radio_option("React", "react", checked: true),
            radio_option("Vue", "vue"),
            radio_option("Svelte", "svelte", disabled: true),
            radio_option("Angular", "angular")
          ])
        end
      end

      private

      def radio_option(label, value, checked: false, disabled: false)
        input_id = "framework_#{value}"

        tag.div(class: "flex items-center gap-2") do
          safe_join([
            tag.input(
              type: "radio",
              id: input_id,
              name: "framework",
              value: value,
              checked: checked || nil,
              disabled: disabled || nil
            ),
            tag.label(
              label,
              for: input_id,
              class: disabled ? "text-sm font-medium text-neutral-400 dark:text-neutral-500 cursor-not-allowed opacity-50" : "text-sm font-medium text-neutral-700 dark:text-neutral-300"
            )
          ])
        end
      end
    end
  end
end
