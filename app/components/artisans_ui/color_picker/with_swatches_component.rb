# frozen_string_literal: true

module ArtisansUi
  module ColorPicker
    # Color Picker with Swatches Component (Variant 2)
    # HTML5 color input with predefined color swatches using datalist
    # Users can pick from swatches or choose custom colors
    # Exact RailsBlocks implementation
    #
    # @example Basic with swatches
    #   <%= render ArtisansUi::ColorPicker::WithSwatchesComponent.new(
    #     label: "Theme Color",
    #     name: "theme_color",
    #     value: "#8b5cf6",
    #     swatches: {
    #       "Violet 100" => "#ede9fe",
    #       "Violet 500" => "#8b5cf6",
    #       "Violet 900" => "#4c1d95"
    #     }
    #   ) %>
    #
    # @example With default violet swatches
    #   <%= render ArtisansUi::ColorPicker::WithSwatchesComponent.new(
    #     label: "Brand Color",
    #     name: "brand_color"
    #   ) %>
    class WithSwatchesComponent < ApplicationViewComponent
      DEFAULT_SWATCHES = {
        "Violet 100" => "#ede9fe",
        "Violet 200" => "#ddd6fe",
        "Violet 300" => "#c4b5fd",
        "Violet 400" => "#a78bfa",
        "Violet 500" => "#8b5cf6",
        "Violet 600" => "#7c3aed",
        "Violet 700" => "#6d28d9",
        "Violet 800" => "#5b21b6",
        "Violet 900" => "#4c1d95"
      }.freeze

      def initialize(label:, name:, value: "#8b5cf6", swatches: DEFAULT_SWATCHES, id: nil, **html_options)
        @label = label
        @name = name
        @value = value
        @swatches = swatches
        @id = id || generate_id
        @datalist_id = "#{@id}-colors"
        @html_options = html_options
      end

      def call
        tag.div(class: "space-y-4") do
          safe_join([
            input_section,
            quick_select_section,
            style_tag,
            script_tag
          ])
        end
      end

      private

      def input_section
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            label_tag,
            input_container
          ])
        end
      end

      def label_tag
        tag.label(
          @label,
          for: @id,
          class: "block text-sm font-medium text-neutral-700 dark:text-neutral-300 mb-1"
        )
      end

      def input_container
        tag.div(class: "flex items-center gap-3") do
          safe_join([
            color_input,
            datalist_tag,
            description_text
          ])
        end
      end

      def color_input
        tag.input(
          type: "color",
          name: @name,
          id: @id,
          list: @datalist_id,
          value: @value,
          class: "h-12 w-12 rounded-lg outline-1 -outline-offset-1 outline-black/15 dark:outline-white/20 cursor-pointer hover:scale-105 transition-transform",
          **@html_options
        )
      end

      def datalist_tag
        tag.datalist(id: @datalist_id) do
          safe_join(
            @swatches.map do |name, color|
              tag.option(value: color) { name }
            end
          )
        end
      end

      def description_text
        tag.div(class: "text-sm") do
          safe_join([
            tag.p("Pick from predefined colors or choose custom", class: "text-neutral-600 dark:text-neutral-400"),
            tag.p(@value, class: "font-mono text-xs text-neutral-500", id: "#{@id}-value")
          ])
        end
      end

      def quick_select_section
        tag.div(class: "space-y-2") do
          safe_join([
            tag.p("Quick select:", class: "text-sm font-medium text-neutral-700 dark:text-neutral-300"),
            swatch_buttons
          ])
        end
      end

      def swatch_buttons
        tag.div(class: "flex gap-2 flex-wrap justify-center") do
          safe_join(
            @swatches.values.map do |color|
              swatch_button(color)
            end
          )
        end
      end

      def swatch_button(color)
        tag.button(
          type: "button",
          data: { color: color },
          class: "swatch-#{@id} h-8 w-8 rounded-md border border-black/15 dark:border-white/20 hover:scale-110 transition-transform focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600 dark:focus-visible:outline-neutral-200",
          style: "background-color: #{color}"
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
              padding: 0;
            }

            input[type="color"]::-webkit-color-swatch-wrapper {
              padding: 0;
            }

            input[type="color"]::-webkit-color-swatch {
              border: none;
              border-radius: 0.5rem;
            }
          CSS
        end
      end

      def script_tag
        tag.script do
          <<~JS
            // Update value display with Turbo support
            document.addEventListener('turbo:load', function() {
              const colorInput = document.getElementById('#{@id}');
              const valueDisplay = document.getElementById('#{@id}-value');
              const swatches = document.querySelectorAll('.swatch-#{@id}');

              if (colorInput && valueDisplay) {
                colorInput.addEventListener('change', function(e) {
                  valueDisplay.textContent = e.target.value;
                  updateSwatchSelection(e.target.value);
                });
              }

              // Handle swatch clicks
              swatches.forEach(swatch => {
                swatch.addEventListener('click', function() {
                  const color = this.dataset.color;
                  colorInput.value = color;
                  valueDisplay.textContent = color;
                  updateSwatchSelection(color);
                });
              });

              // Function to update swatch selection visual feedback
              function updateSwatchSelection(selectedColor) {
                swatches.forEach(swatch => {
                  if (swatch.dataset.color.toLowerCase() === selectedColor.toLowerCase()) {
                    swatch.classList.add('ring-2', 'ring-offset-2', 'ring-neutral-500', 'dark:ring-neutral-400');
                  } else {
                    swatch.classList.remove('ring-2', 'ring-offset-2', 'ring-neutral-500', 'dark:ring-neutral-400');
                  }
                });
              }

              // Set initial selection
              if (colorInput) {
                updateSwatchSelection(colorInput.value);
              }
            });
          JS
        end
      end

      def generate_id
        "color_picker_swatches_#{SecureRandom.hex(4)}"
      end
    end
  end
end
