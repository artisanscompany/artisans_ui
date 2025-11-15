# frozen_string_literal: true

module ArtisansUi
  module ColorPicker
    # Enhanced Shoelace Color Picker Component (Variant 3)
    # Shoelace color picker with modern interface and color format display
    # Requires Shoelace library (see installation instructions)
    # Exact RailsBlocks implementation
    #
    # Installation:
    # Add to your layout's <head> section:
    # <script type="module" src="https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.20.1/cdn/components/color-picker/color-picker.js"></script>
    # <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.20.1/cdn/themes/light.css" />
    # <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.20.1/cdn/themes/dark.css" />
    #
    # @example Basic enhanced picker
    #   <%= render ArtisansUi::ColorPicker::EnhancedComponent.new(
    #     label: "Brand Color",
    #     value: "#3b82f6"
    #   ) %>
    #
    # @example With custom format
    #   <%= render ArtisansUi::ColorPicker::EnhancedComponent.new(
    #     label: "Theme Color",
    #     value: "#8b5cf6",
    #     format: "rgb"
    #   ) %>
    class EnhancedComponent < ApplicationViewComponent
      def initialize(label: "Brand Color", value: "#3b82f6", format: "hex", size: "medium", id: nil)
        @label = label
        @value = value
        @format = format
        @size = size
        @id = id || generate_id
      end

      def call
        tag.div(class: "space-y-4") do
          safe_join([
            picker_section,
            value_display_section,
            script_tag
          ])
        end
      end

      private

      def picker_section
        tag.div(class: "flex flex-col items-center gap-2") do
          tag.send(:"sl-color-picker",
            label: @label,
            value: @value,
            format: @format,
            size: @size,
            id: @id
          )
        end
      end

      def value_display_section
        tag.div(class: "flex justify-center items-center gap-3 text-sm") do
          safe_join([
            tag.span("Current value:", class: "text-neutral-600 dark:text-neutral-400"),
            tag.code(@value, class: "px-2 py-1 bg-neutral-100 dark:bg-neutral-800 rounded font-mono text-xs", id: "#{@id}-value")
          ])
        end
      end

      def script_tag
        tag.script do
          <<~JS
            // Handle color picker changes with Turbo support
            document.addEventListener('turbo:load', function() {
              const enhancedPicker = document.getElementById('#{@id}');
              const enhancedValue = document.getElementById('#{@id}-value');

              if (enhancedPicker) {
                enhancedPicker.addEventListener('sl-change', function(e) {
                  enhancedValue.textContent = e.target.value;
                });
              }
            });
          JS
        end
      end

      def generate_id
        "enhanced_picker_#{SecureRandom.hex(4)}"
      end
    end
  end
end
