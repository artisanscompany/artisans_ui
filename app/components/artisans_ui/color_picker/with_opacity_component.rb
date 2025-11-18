# frozen_string_literal: true

module ArtisansUi
  module ColorPicker
    # Color Picker with Opacity Component (Variant 4)
    # Advanced color picker with alpha channel support for transparency control
    # Includes HEX (with alpha) and RGBA display with transparency preview
    # Requires Shoelace library (see installation instructions)
    # Exact RailsBlocks implementation
    #
    # @example Basic with opacity
    #   <%= render ArtisansUi::ColorPicker::WithOpacityComponent.new(
    #     label: "Background Color",
    #     value: "#f5a623ff"
    #   ) %>
    #
    # @example Custom initial color
    #   <%= render ArtisansUi::ColorPicker::WithOpacityComponent.new(
    #     label: "Overlay Color",
    #     value: "#3b82f680"
    #   ) %>
    class WithOpacityComponent < ApplicationViewComponent
      def initialize(label: "Background Color", value: "#f5a623ff", id: nil)
        @label = label
        @value = value
        @id = id || generate_id
      end

      def call
        tag.div(class: "space-y-4") do
          safe_join([
            picker_section,
            value_displays,
            preview_section,
            style_tag,
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
            opacity: true,
            format: "hex",
            "no-format-toggle": true,
            size: "medium",
            id: @id
          )
        end
      end

      def value_displays
        tag.div(class: "flex flex-col gap-2") do
          safe_join([
            hex_alpha_display,
            rgba_display
          ])
        end
      end

      def hex_alpha_display
        tag.div(class: "flex items-center gap-3 text-sm") do
          safe_join([
            tag.span("Hex (with alpha):", class: "text-neutral-600"),
            tag.code(@value, class: "px-2 py-1 bg-neutral-100 rounded font-mono text-xs", id: "#{@id}-hex-alpha")
          ])
        end
      end

      def rgba_display
        # Calculate initial RGBA values
        initial_rgba = hex_to_rgba(@value)

        tag.div(class: "flex items-center gap-3 text-sm") do
          safe_join([
            tag.span("RGBA:", class: "text-neutral-600"),
            tag.code(initial_rgba, class: "px-2 py-1 bg-neutral-100 rounded font-mono text-xs", id: "#{@id}-rgba")
          ])
        end
      end

      def preview_section
        tag.div(class: "space-y-2") do
          safe_join([
            tag.p("Preview:", class: "text-sm font-medium text-neutral-700 text-center"),
            preview_container
          ])
        end
      end

      def preview_container
        tag.div(class: "relative h-24 rounded-lg overflow-hidden outline-1 -outline-offset-1 outline-black/15") do
          safe_join([
            checkerboard_background,
            color_overlay
          ])
        end
      end

      def checkerboard_background
        tag.div(class: "absolute inset-0 checkerboard-bg opacity-20")
      end

      def color_overlay
        tag.div(
          class: "absolute inset-0",
          id: "#{@id}-preview",
          style: "background-color: #{@value}"
        )
      end

      def style_tag
        tag.style do
          <<~CSS
            /* Checkerboard pattern for transparency background */
            .checkerboard-bg {
              background-image:
                linear-gradient(45deg, #e5e7eb 25%, transparent 25%),
                linear-gradient(-45deg, #e5e7eb 25%, transparent 25%),
                linear-gradient(45deg, transparent 75%, #e5e7eb 75%),
                linear-gradient(-45deg, transparent 75%, #e5e7eb 75%);
              background-size: 20px 20px;
              background-position: 0 0, 0 10px, 10px -10px, -10px 0px;
            }

            /* Dark mode checkerboard */
            .dark .checkerboard-bg {
              background-image:
                linear-gradient(45deg, #374151 25%, transparent 25%),
                linear-gradient(-45deg, #374151 25%, transparent 25%),
                linear-gradient(45deg, transparent 75%, #374151 75%),
                linear-gradient(-45deg, transparent 75%, #374151 75%);
            }
          CSS
        end
      end

      def script_tag
        tag.script do
          <<~JS
            // Handle opacity picker changes with Turbo support
            document.addEventListener('turbo:load', function() {
              const opacityPicker = document.getElementById('#{@id}');
              const hexAlphaValue = document.getElementById('#{@id}-hex-alpha');
              const rgbaValue = document.getElementById('#{@id}-rgba');
              const colorPreview = document.getElementById('#{@id}-preview');

              if (opacityPicker) {
                opacityPicker.addEventListener('sl-change', function(e) {
                  const color = e.target.value;
                  hexAlphaValue.textContent = color;

                  // Convert to RGBA for display
                  const r = parseInt(color.slice(1, 3), 16);
                  const g = parseInt(color.slice(3, 5), 16);
                  const b = parseInt(color.slice(5, 7), 16);
                  const a = color.length > 7 ? (parseInt(color.slice(7, 9), 16) / 255).toFixed(2) : '1';

                  rgbaValue.textContent = `rgba(\${r}, \${g}, \${b}, \${a})`;
                  colorPreview.style.backgroundColor = color;
                });
              }
            });
          JS
        end
      end

      def hex_to_rgba(hex)
        r = hex[1..2].to_i(16)
        g = hex[3..4].to_i(16)
        b = hex[5..6].to_i(16)
        a = hex.length > 7 ? (hex[7..8].to_i(16) / 255.0).round(2) : 1
        "rgba(#{r}, #{g}, #{b}, #{a})"
      end

      def generate_id
        "opacity_picker_#{SecureRandom.hex(4)}"
      end
    end
  end
end
