# frozen_string_literal: true

module ArtisansUi
  module ColorPicker
    # Basic HTML5 Color Picker Component (Variant 1)
    # Native HTML5 color input with minimal styling
    # Zero dependencies, works in all modern browsers
    # Exact RailsBlocks implementation
    #
    # @example Basic color picker
    #   <%= render ArtisansUi::ColorPicker::BasicComponent.new(
    #     name: "color",
    #     value: "#3b82f6"
    #   ) %>
    #
    # @example With label
    #   <%= render ArtisansUi::ColorPicker::BasicComponent.new(
    #     label: "Choose a color",
    #     name: "theme_color",
    #     value: "#8b5cf6"
    #   ) %>
    #
    # @example With custom ID
    #   <%= render ArtisansUi::ColorPicker::BasicComponent.new(
    #     label: "Brand color",
    #     name: "brand_color",
    #     value: "#10b981",
    #     id: "brand-color-picker"
    #   ) %>
    class BasicComponent < ApplicationViewComponent
      def initialize(name:, value: "#3b82f6", label: nil, id: nil, **html_options)
        @name = name
        @value = value
        @label = label
        @id = id || generate_id
        @html_options = html_options
      end

      def call
        tag.div(class: "flex flex-col items-center gap-2") do
          safe_join([
            label_tag,
            color_input,
            style_tag
          ].compact)
        end
      end

      private

      def label_tag
        return unless @label

        tag.label(
          @label,
          for: @id,
          class: "block text-sm font-medium text-neutral-700 dark:text-neutral-300 mb-1"
        )
      end

      def color_input
        tag.input(
          type: "color",
          name: @name,
          id: @id,
          value: @value,
          class: "size-10 rounded-lg outline-1 -outline-offset-1 outline-black/15 dark:outline-white/20 cursor-pointer hover:scale-105 transition-transform focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600 dark:focus-visible:outline-neutral-200",
          **@html_options
        )
      end

      def style_tag
        tag.style do
          <<~CSS
            /* Custom styling for the color input */
            input[type="color"] {
              -webkit-appearance: none;
              -moz-appearance: none;
              appearance: none;
              border: none;
            }

            input[type="color"]::-webkit-color-swatch {
              border: none;
              border-radius: 0.5rem;
            }
          CSS
        end
      end

      def generate_id
        "color_picker_#{SecureRandom.hex(4)}"
      end
    end
  end
end
