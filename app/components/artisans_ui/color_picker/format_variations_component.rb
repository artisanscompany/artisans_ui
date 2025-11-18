# frozen_string_literal: true

module ArtisansUi
  module ColorPicker
    # Color Format Variations Component (Variant 5)
    # Color pickers configured for different color format outputs: HEX, RGB, HSL, and HSV
    # Demonstrates format flexibility for different use cases
    # Requires Shoelace library (see installation instructions)
    # Exact RailsBlocks implementation
    #
    # @example All format variations
    #   <%= render ArtisansUi::ColorPicker::FormatVariationsComponent.new %>
    #
    # @example Custom initial values
    #   <%= render ArtisansUi::ColorPicker::FormatVariationsComponent.new(
    #     hex_value: "#4a90e2",
    #     rgb_value: "rgb(80, 227, 194)",
    #     hsl_value: "hsl(290, 87%, 47%)",
    #     hsv_value: "hsv(55, 89%, 97%)"
    #   ) %>
    class FormatVariationsComponent < ApplicationViewComponent
      def initialize(
        hex_value: "#4a90e2",
        rgb_value: "rgb(80, 227, 194)",
        hsl_value: "hsl(290, 87%, 47%)",
        hsv_value: "hsv(55, 89%, 97%)",
        id_prefix: nil
      )
        @hex_value = hex_value
        @rgb_value = rgb_value
        @hsl_value = hsl_value
        @hsv_value = hsv_value
        @id_prefix = id_prefix || generate_id_prefix
      end

      def call
        tag.div(class: "space-y-6") do
          safe_join([
            description_text,
            format_grid,
            script_tag
          ])
        end
      end

      private

      def description_text
        tag.p(
          "Choose the output format that best suits your needs",
          class: "text-sm text-neutral-500 text-center"
        )
      end

      def format_grid
        tag.div(class: "grid grid-cols-1 md:grid-cols-2 gap-6") do
          safe_join([
            format_picker("hex", "HEX Format", @hex_value, "hex"),
            format_picker("rgb", "RGB Format", @rgb_value, "rgb"),
            format_picker("hsl", "HSL Format", @hsl_value, "hsl"),
            format_picker("hsv", "HSV Format", @hsv_value, "hsv")
          ])
        end
      end

      def format_picker(format, label, value, picker_format)
        tag.div(class: "space-y-3") do
          safe_join([
            picker_container(format, label, value, picker_format),
            output_display(format, value)
          ])
        end
      end

      def picker_container(format, label, value, picker_format)
        tag.div(class: "flex flex-col items-center") do
          tag.send(:"sl-color-picker",
            label: label,
            format: picker_format,
            value: value,
            size: "small",
            id: "#{@id_prefix}-#{format}-picker"
          )
        end
      end

      def output_display(format, value)
        tag.div(class: "text-center") do
          safe_join([
            tag.div("Output:", class: "text-xs text-neutral-500 mb-1"),
            tag.code(
              value,
              class: "px-2 py-1 bg-neutral-100 rounded font-mono text-xs text-neutral-700",
              id: "#{@id_prefix}-#{format}-output"
            )
          ])
        end
      end

      def script_tag
        tag.script do
          <<~JS
            // Update output displays for each format with Turbo support
            document.addEventListener('turbo:load', function() {
              ['hex', 'rgb', 'hsl', 'hsv'].forEach(format => {
                const picker = document.getElementById('#{@id_prefix}-' + format + '-picker');
                const output = document.getElementById('#{@id_prefix}-' + format + '-output');

                if (picker && output) {
                  picker.addEventListener('sl-change', function(e) {
                    output.textContent = e.target.value;
                  });
                }
              });
            });
          JS
        end
      end

      def generate_id_prefix
        "format_variations_#{SecureRandom.hex(4)}"
      end
    end
  end
end
