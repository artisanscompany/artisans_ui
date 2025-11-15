# frozen_string_literal: true

module ArtisansUi
  module Button
    # Fancy Button Component (Variant 2)
    # Enhanced button with skeumorphic design and advanced shadows
    # Features gradient overlays, complex shadow effects, and smooth transitions
    # Exact RailsBlocks implementation
    #
    # @example Neutral fancy button
    #   <%= render ArtisansUi::Button::FancyComponent.new do %>
    #     Neutral Button
    #   <% end %>
    #
    # @example Colored fancy button
    #   <%= render ArtisansUi::Button::FancyComponent.new(variant: :colored) do %>
    #     Colored Button
    #   <% end %>
    #
    # @example Small fancy button
    #   <%= render ArtisansUi::Button::FancyComponent.new(size: :small) do %>
    #     Small Button
    #   <% end %>
    class FancyComponent < ApplicationViewComponent
      VARIANTS = {
        neutral: {
          base: "bg-neutral-900 text-white",
          shadow: "shadow-[0_4px_12px_0_rgb(from_theme(colors.neutral.900)_r_g_b_/_0.15),0_2px_4px_0_rgb(from_theme(colors.neutral.950)_r_g_b_/_0.2),0_0_0_1px_theme(colors.neutral.900),inset_0_1px_0_0_rgb(from_theme(colors.white)_r_g_b_/_0.15),inset_0_0_0_1px_rgb(from_theme(colors.white)_r_g_b_/_0.03)]",
          hover: "hover:bg-neutral-800 hover:shadow-[0_4px_12px_0_rgb(from_theme(colors.neutral.900)_r_g_b_/_0.15),0_2px_4px_0_rgb(from_theme(colors.neutral.950)_r_g_b_/_0.2),0_0_0_1px_theme(colors.neutral.900),inset_0_1px_0_0_rgb(from_theme(colors.white)_r_g_b_/_0.25),inset_0_0_0_1px_rgb(from_theme(colors.white)_r_g_b_/_0.03)]",
          dark: "dark:bg-neutral-100 dark:text-neutral-900 dark:shadow-[0_4px_12px_0_rgb(from_theme(colors.neutral.900)_r_g_b_/_0.15),0_2px_4px_0_rgb(from_theme(colors.black)_r_g_b_/_0.08),0_0_0_1px_theme(colors.neutral.200),inset_0_1px_0_0_rgb(from_theme(colors.white)_r_g_b_/_0.8)] dark:before:from-white/20 dark:hover:bg-white dark:hover:shadow-[0_4px_12px_0_rgb(from_theme(colors.black)_r_g_b_/_0.2),0_2px_4px_0_rgb(from_theme(colors.black)_r_g_b_/_0.1),0_0_0_1px_theme(colors.white),inset_0_1px_0_0_rgb(from_theme(colors.white)_r_g_b_/_0.9)]"
        },
        colored: {
          base: "bg-blue-600 text-white",
          shadow: "shadow-[0_4px_12px_0_rgb(from_theme(colors.neutral.900)_r_g_b_/_0.15),0_2px_4px_0_rgb(from_theme(colors.zinc.950)_r_g_b_/_0.2),0_0_0_1px_theme(colors.blue.600),inset_0_1px_0_0_rgb(from_theme(colors.white)_r_g_b_/_0.25),inset_0_0_0_1px_rgb(from_theme(colors.white)_r_g_b_/_0.03)]",
          hover: "hover:bg-blue-500 hover:shadow-[0_4px_12px_0_rgb(from_theme(colors.neutral.900)_r_g_b_/_0.15),0_2px_4px_0_rgb(from_theme(colors.zinc.950)_r_g_b_/_0.2),0_0_0_1px_theme(colors.blue.600),inset_0_1px_0_0_rgb(from_theme(colors.white)_r_g_b_/_0.25),inset_0_0_0_1px_rgb(from_theme(colors.white)_r_g_b_/_0.03)]",
          dark: "dark:before:from-white/20"
        },
        secondary: {
          base: "bg-white text-neutral-800",
          shadow: "shadow-[0_4px_12px_0_rgb(from_theme(colors.neutral.900)_r_g_b_/_0.08),0_2px_4px_0_rgb(from_theme(colors.black)_r_g_b_/_0.06),0_0_0_1px_rgb(from_theme(colors.black)_r_g_b_/_0.1),inset_0_1px_0_0_rgb(from_theme(colors.white)_r_g_b_/_0.8),inset_0_0_0_1px_rgb(from_theme(colors.white)_r_g_b_/_0.03)]",
          hover: "hover:bg-neutral-50 hover:shadow-[0_4px_12px_0_rgb(from_theme(colors.neutral.900)_r_g_b_/_0.08),0_2px_4px_0_rgb(from_theme(colors.black)_r_g_b_/_0.08),0_0_0_1px_rgb(from_theme(colors.black)_r_g_b_/_0.12),inset_0_1px_0_0_rgb(from_theme(colors.white)_r_g_b_/_0.9),inset_0_0_0_1px_rgb(from_theme(colors.white)_r_g_b_/_0.03)]",
          dark: "dark:bg-neutral-950 dark:text-neutral-100 dark:shadow-[0_4px_12px_0_rgb(from_theme(colors.black)_r_g_b_/_0.25),0_2px_4px_0_rgb(from_theme(colors.black)_r_g_b_/_0.3),0_0_0_1px_theme(colors.neutral.950),inset_0_1px_0_0_rgb(from_theme(colors.white)_r_g_b_/_0.17),inset_0_0_0_1px_rgb(from_theme(colors.white)_r_g_b_/_0.01)] dark:before:from-white/10 dark:before:to-white/5 dark:hover:bg-neutral-900 dark:hover:shadow-[0_4px_12px_0_rgb(from_theme(colors.black)_r_g_b_/_0.45),0_2px_4px_0_rgb(from_theme(colors.black)_r_g_b_/_0.3),0_0_0_1px_theme(colors.neutral.950),inset_0_1px_0_0_rgb(from_theme(colors.white)_r_g_b_/_0.20),inset_0_0_0_1px_rgb(from_theme(colors.white)_r_g_b_/_0.02)]"
        },
        danger: {
          base: "bg-red-600 text-white",
          shadow: "shadow-[0_4px_12px_0_rgb(from_theme(colors.neutral.900)_r_g_b_/_0.15),0_2px_4px_0_rgb(from_theme(colors.zinc.950)_r_g_b_/_0.2),0_0_0_1px_theme(colors.red.600),inset_0_1px_0_0_rgb(from_theme(colors.white)_r_g_b_/_0.25),inset_0_0_0_1px_rgb(from_theme(colors.white)_r_g_b_/_0.03)]",
          hover: "hover:bg-red-500 hover:shadow-[0_4px_12px_0_rgb(from_theme(colors.neutral.900)_r_g_b_/_0.15),0_2px_4px_0_rgb(from_theme(colors.zinc.950)_r_g_b_/_0.2),0_0_0_1px_theme(colors.red.600),inset_0_1px_0_0_rgb(from_theme(colors.white)_r_g_b_/_0.25),inset_0_0_0_1px_rgb(from_theme(colors.white)_r_g_b_/_0.03)]",
          dark: "dark:before:from-white/20"
        }
      }.freeze

      SIZES = {
        regular: "px-3.5 py-2 text-sm",
        small: "px-3 py-2 text-xs"
      }.freeze

      def initialize(variant: :neutral, size: :regular, disabled: false, **html_options)
        @variant = variant.to_sym
        @size = size.to_sym
        @disabled = disabled
        @html_options = html_options

        validate_params!
      end

      def call
        tag.button(
          content,
          type: "button",
          disabled: @disabled,
          class: button_classes,
          **@html_options
        )
      end

      private

      def validate_params!
        raise ArgumentError, "Invalid variant: #{@variant}" unless VARIANTS.key?(@variant)
        raise ArgumentError, "Invalid size: #{@size}" unless SIZES.key?(@size)
      end

      def button_classes
        variant = VARIANTS[@variant]
        [
          base_classes,
          SIZES[@size],
          variant[:base],
          variant[:shadow],
          variant[:hover],
          variant[:dark]
        ].compact.join(" ")
      end

      def base_classes
        "relative flex items-center justify-center gap-1.5 rounded-lg font-medium whitespace-nowrap transition-all duration-200 ease-out select-none before:pointer-events-none before:absolute before:inset-0 before:z-10 before:rounded-[inherit] before:bg-gradient-to-b before:from-white/25 before:via-white/5 before:to-transparent before:p-px before:[mask:linear-gradient(#fff_0_0)_content-box,linear-gradient(#fff_0_0)] focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600 disabled:cursor-not-allowed disabled:opacity-50 dark:focus-visible:outline-neutral-200"
      end
    end
  end
end
