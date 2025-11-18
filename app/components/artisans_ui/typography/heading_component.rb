# frozen_string_literal: true

module ArtisansUi
  module Typography
    # Heading Component
    # Flexible heading tags (h1-h6) with consistent styling and variants
    # Supports semantic HTML with optional predefined style variants
    #
    # @example Basic h1 with variant
    #   <%= render ArtisansUi::Typography::HeadingComponent.new(level: :h1, variant: :display) do %>
    #     Find your next role
    #   <% end %>
    #
    # @example Custom styling with nil variant
    #   <%= render ArtisansUi::Typography::HeadingComponent.new(
    #     level: :h2,
    #     variant: nil,
    #     class: "text-3xl font-bold text-blue-600"
    #   ) do %>
    #     Custom Heading
    #   <% end %>
    #
    # @example With dark mode
    #   <%= render ArtisansUi::Typography::HeadingComponent.new(level: :h3, variant: :section) do %>
    #     Section Title
    #   <% end %>
    class HeadingComponent < ApplicationViewComponent
      LEVELS = [:h1, :h2, :h3, :h4, :h5, :h6].freeze

      VARIANTS = {
        display: "text-4xl sm:text-5xl lg:text-6xl font-bold text-neutral-900 tracking-tight",
        title: "text-2xl sm:text-3xl font-semibold text-neutral-900",
        subtitle: "text-xl sm:text-2xl font-medium text-neutral-900",
        section: "text-lg sm:text-xl font-semibold text-neutral-900"
      }.freeze

      def initialize(level: :h1, variant: :title, **html_options)
        @level = level.to_sym
        @variant = variant&.to_sym
        @html_options = html_options

        validate_params!
      end

      def call
        tag.public_send(@level, **merged_options) do
          content
        end
      end

      private

      def validate_params!
        raise ArgumentError, "Invalid level: #{@level}" unless LEVELS.include?(@level)

        if @variant && !VARIANTS.key?(@variant)
          raise ArgumentError, "Invalid variant: #{@variant}"
        end
      end

      def merged_options
        custom_class = @html_options.delete(:class)
        @html_options.merge(class: [heading_classes, custom_class].compact.join(" "))
      end

      def heading_classes
        VARIANTS[@variant] if @variant
      end
    end
  end
end
