# frozen_string_literal: true

module ArtisansUi
  module Button
    # Link Button Component
    # Button-styled link (anchor tag) for navigation
    # Supports all standard button variants, sizes, and optional icons
    # Use this when you need button styling on a link instead of a button element
    #
    # @example Basic link button
    #   <%= render ArtisansUi::Button::LinkComponent.new(href: "/dashboard") do %>
    #     Go to Dashboard
    #   <% end %>
    #
    # @example Warning variant link button
    #   <%= render ArtisansUi::Button::LinkComponent.new(
    #     href: "/apply",
    #     variant: :warning
    #   ) do %>
    #     Apply Now
    #   <% end %>
    #
    # @example Link button with icon
    #   <%= render ArtisansUi::Button::LinkComponent.new(
    #     href: "/next",
    #     variant: :colored,
    #     icon: '<svg class="w-4 h-4">...</svg>',
    #     icon_position: :right
    #   ) do %>
    #     Continue
    #   <% end %>
    #
    # @example Small link button
    #   <%= render ArtisansUi::Button::LinkComponent.new(
    #     href: "/delete",
    #     variant: :danger,
    #     size: :small
    #   ) do %>
    #     Delete
    #   <% end %>
    #
    # @example Custom styling with nil variant
    #   <%= render ArtisansUi::Button::LinkComponent.new(
    #     href: "/custom",
    #     variant: nil,
    #     class: "bg-green-100 text-green-800 hover:bg-green-200"
    #   ) do %>
    #     Custom Style
    #   <% end %>
    class LinkComponent < ApplicationViewComponent
      VARIANTS = {
        neutral: "border-neutral-400 bg-neutral-800 text-white hover:bg-neutral-700 focus-visible:outline-neutral-600",
        colored: "border-blue-400 bg-blue-600 text-white hover:bg-blue-500 focus-visible:outline-neutral-600",
        secondary: "border-neutral-200 bg-white text-neutral-800 shadow-xs hover:bg-neutral-50 focus-visible:outline-neutral-600",
        danger: "border-red-300 bg-red-600 text-white hover:bg-red-500 focus-visible:outline-neutral-600",
        warning: "border-yellow-500 bg-yellow-500 text-white hover:bg-yellow-600 focus-visible:outline-yellow-600"
      }.freeze

      SIZES = {
        regular: "px-3 py-2 text-sm",
        small: "px-3 py-2 text-xs"
      }.freeze

      ICON_POSITIONS = [:left, :right].freeze

      def initialize(href:, variant: :neutral, size: :regular, icon: nil, icon_position: :left, **html_options)
        @href = href
        @variant = variant&.to_sym
        @size = size.to_sym
        @icon = icon
        @icon_position = icon_position.to_sym
        @html_options = html_options

        validate_params!
      end

      def call
        tag.a(
          href: @href,
          class: link_classes,
          **@html_options
        ) do
          if @icon
            link_content_with_icon
          else
            content
          end
        end
      end

      private

      def validate_params!
        if @variant && !VARIANTS.key?(@variant)
          raise ArgumentError, "Invalid variant: #{@variant}"
        end
        raise ArgumentError, "Invalid size: #{@size}" unless SIZES.key?(@size)
        if @icon && !ICON_POSITIONS.include?(@icon_position)
          raise ArgumentError, "Invalid icon_position: #{@icon_position}"
        end
      end

      def link_content_with_icon
        text_content = content
        if @icon_position == :left
          safe_join([icon_html, text_content], " ")
        else
          safe_join([text_content, icon_html], " ")
        end
      end

      def icon_html
        @icon.html_safe
      end

      def link_classes
        custom_class = @html_options.delete(:class)
        classes = [base_classes, SIZES[@size]]
        classes << VARIANTS[@variant] if @variant
        classes << custom_class if custom_class
        classes.compact.join(" ")
      end

      def base_classes
        "flex items-center justify-center gap-1.5 rounded-lg border shadow-sm transition-all duration-100 ease-in-out select-none font-medium whitespace-nowrap focus-visible:outline-2 focus-visible:outline-offset-2"
      end
    end
  end
end
