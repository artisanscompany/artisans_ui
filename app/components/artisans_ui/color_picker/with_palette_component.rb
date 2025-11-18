# frozen_string_literal: true

module ArtisansUi
  module ColorPicker
    # Color Picker with Custom Palette Component (Variant 6)
    # Enhanced color picker with custom color palette for consistent brand colors
    # Includes neutral and accent color groups with visual swatch selection
    # Requires Shoelace library (see installation instructions)
    # Exact RailsBlocks implementation
    #
    # @example Default brand palette
    #   <%= render ArtisansUi::ColorPicker::WithPaletteComponent.new %>
    #
    # @example Custom palette
    #   <%= render ArtisansUi::ColorPicker::WithPaletteComponent.new(
    #     value: "#3b82f6",
    #     neutrals: ["#1a202c", "#2d3748", "#4a5568"],
    #     accents: ["#3b82f6", "#8b5cf6", "#10b981"]
    #   ) %>
    class WithPaletteComponent < ApplicationViewComponent
      DEFAULT_NEUTRALS = [
        "#1a202c", # Gray 900
        "#2d3748", # Gray 800
        "#4a5568", # Gray 700
        "#718096", # Gray 500
        "#a0aec0", # Gray 400
        "#cbd5e0", # Gray 300
        "#e2e8f0", # Gray 200
        "#f7fafc"  # Gray 50
      ].freeze

      DEFAULT_ACCENTS = [
        "#fed7d7", # Red 100
        "#feb2b2", # Red 200
        "#fc8181", # Red 300
        "#f56565", # Red 400
        "#e53e3e", # Red 500
        "#c53030", # Red 600
        "#9b2c2c", # Red 700
        "#742a2a"  # Red 800
      ].freeze

      NEUTRAL_TITLES = [
        "Gray 900", "Gray 800", "Gray 700", "Gray 500",
        "Gray 400", "Gray 300", "Gray 200", "Gray 50"
      ].freeze

      ACCENT_TITLES = [
        "Red 100", "Red 200", "Red 300", "Red 400",
        "Red 500", "Red 600", "Red 700", "Red 800"
      ].freeze

      def initialize(
        label: "Brand Color",
        value: "#4a5568",
        neutrals: DEFAULT_NEUTRALS,
        accents: DEFAULT_ACCENTS,
        id: nil
      )
        @label = label
        @value = value
        @neutrals = neutrals
        @accents = accents
        @id = id || generate_id
        @swatches = build_swatches_string
      end

      def call
        tag.div(class: "space-y-6") do
          safe_join([
            picker_section,
            palette_section,
            selected_color_section,
            script_tag
          ])
        end
      end

      private

      def picker_section
        tag.div(class: "flex flex-col items-center") do
          tag.send(:"sl-color-picker",
            label: @label,
            value: @value,
            swatches: @swatches,
            size: "medium",
            id: @id
          )
        end
      end

      def palette_section
        tag.div(class: "space-y-4") do
          safe_join([
            tag.p("Brand Palette", class: "text-sm font-medium text-neutral-600 text-center"),
            color_groups
          ])
        end
      end

      def color_groups
        tag.div(class: "space-y-4") do
          safe_join([
            color_group("Neutrals", @neutrals, NEUTRAL_TITLES),
            color_group("Accents", @accents, ACCENT_TITLES)
          ])
        end
      end

      def color_group(name, colors, titles)
        tag.div(class: "space-y-2") do
          safe_join([
            tag.p(name, class: "text-xs text-neutral-500 uppercase tracking-wide text-center"),
            swatch_grid(colors, titles)
          ])
        end
      end

      def swatch_grid(colors, titles)
        tag.div(class: "flex justify-center gap-2 flex-wrap") do
          safe_join(
            colors.each_with_index.map do |color, index|
              swatch_button(color, titles[index] || color)
            end
          )
        end
      end

      def swatch_button(color, title)
        tag.button(
          type: "button",
          data: { color: color },
          class: "brand-swatch-#{@id} h-8 w-8 rounded-md border border-black/15 hover:scale-110 transition-transform focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600",
          style: "background-color: #{color}",
          title: title
        )
      end

      def selected_color_section
        tag.div(class: "flex flex-col items-center gap-3 p-4 bg-neutral-50 rounded-lg border border-neutral-200") do
          safe_join([
            color_display,
            add_button
          ])
        end
      end

      def color_display
        tag.div(class: "text-sm text-center") do
          safe_join([
            tag.div("Selected Color:", class: "text-xs text-neutral-500 mb-1"),
            tag.code(
              @value,
              class: "px-2 py-1 bg-white rounded font-mono text-xs text-neutral-700",
              id: "#{@id}-value"
            )
          ])
        end
      end

      def add_button
        tag.button(
          type: "button",
          class: "px-3 py-1.5 text-xs bg-white hover:bg-neutral-50 rounded border border-neutral-300 text-neutral-600 transition-colors",
          id: "#{@id}-add-to-palette"
        ) { "Add to Palette" }
      end

      def script_tag
        tag.script do
          <<~JS
            // Handle brand picker and swatch interactions with Turbo support
            document.addEventListener('turbo:load', function() {
              const brandPicker = document.getElementById('#{@id}');
              const brandValue = document.getElementById('#{@id}-value');
              const brandSwatches = document.querySelectorAll('.brand-swatch-#{@id}');
              const addButton = document.getElementById('#{@id}-add-to-palette');

              if (brandPicker) {
                // Update value display
                brandPicker.addEventListener('sl-change', function(e) {
                  const color = e.target.value;
                  brandValue.textContent = color;
                  updateBrandSwatchSelection(color);
                });
              }

              // Handle brand swatch clicks
              brandSwatches.forEach(swatch => {
                swatch.addEventListener('click', function() {
                  const color = this.dataset.color;
                  brandPicker.value = color;
                  brandValue.textContent = color;
                  updateBrandSwatchSelection(color);
                });
              });

              function updateBrandSwatchSelection(selectedColor) {
                brandSwatches.forEach(swatch => {
                  if (swatch.dataset.color.toLowerCase() === selectedColor.toLowerCase()) {
                    swatch.classList.remove('ring-transparent');
                    swatch.classList.add('ring-2', 'ring-neutral-500');
                  } else {
                    swatch.classList.remove('ring-2', 'ring-neutral-500');
                    swatch.classList.add('ring-transparent');
                  }
                });
              }

              // Add to palette (example functionality)
              if (addButton) {
                addButton.addEventListener('click', function() {
                  const color = brandValue.textContent;
                  console.log('Adding to palette:', color);
                  this.textContent = 'Added!';
                  setTimeout(() => {
                    this.textContent = 'Add to Palette';
                  }, 2000);
                });
              }

              // Set initial selection
              if (brandPicker) {
                updateBrandSwatchSelection(brandPicker.value);
              }
            });
          JS
        end
      end

      def build_swatches_string
        (@neutrals + @accents).join("; ")
      end

      def generate_id
        "brand_picker_#{SecureRandom.hex(4)}"
      end
    end
  end
end
