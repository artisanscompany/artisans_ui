# frozen_string_literal: true

module ArtisansUi
  module Ui
    # IconText Component
    # Universal component for displaying icon + text patterns
    # Useful for metadata, features, stats, contact info, etc.
    #
    # @example Default with icon
    #   <%= render ArtisansUi::Ui::IconTextComponent.new(
    #     icon: "map-marker-alt",
    #     text: "Vienna, Austria"
    #   ) %>
    #
    # @example Emphasis variant
    #   <%= render ArtisansUi::Ui::IconTextComponent.new(
    #     icon: "dollar-sign",
    #     text: "$50,000 - $70,000",
    #     variant: :emphasis
    #   ) %>
    #
    # @example Without icon
    #   <%= render ArtisansUi::Ui::IconTextComponent.new(
    #     text: "Full-time position"
    #   ) %>
    #
    # @example With custom icon classes
    #   <%= render ArtisansUi::Ui::IconTextComponent.new(
    #     icon: "check-circle",
    #     text: "Verified",
    #     variant: :success,
    #     icon_class: "text-xl"
    #   ) %>
    class IconTextComponent < ApplicationViewComponent
      VARIANTS = {
        default: "text-neutral-600",
        emphasis: "text-neutral-900 font-medium",
        success: "text-green-600",
        warning: "text-yellow-600",
        error: "text-red-600",
        info: "text-blue-600"
      }.freeze

      def initialize(text:, icon: nil, variant: :default, icon_class: nil, **html_options)
        @text = text
        @icon = icon
        @variant = variant&.to_sym
        @icon_class = icon_class
        @html_options = html_options

        validate_params!
      end

      def call
        tag.span(**merged_options) do
          safe_join([icon_tag, text_tag].compact, " ")
        end
      end

      private

      def validate_params!
        if @variant && !VARIANTS.key?(@variant)
          raise ArgumentError, "Invalid variant: #{@variant}"
        end

        if @text.blank?
          raise ArgumentError, "text parameter is required"
        end
      end

      def merged_options
        custom_class = @html_options.delete(:class)
        @html_options.merge(class: [base_classes, custom_class].compact.join(" "))
      end

      def base_classes
        "inline-flex items-center gap-2 #{VARIANTS[@variant]}"
      end

      def icon_tag
        return nil unless @icon

        tag.i(class: icon_classes)
      end

      def icon_classes
        base = "fas fa-#{@icon}"
        [@icon_class, base].compact.join(" ")
      end

      def text_tag
        tag.span(@text)
      end
    end
  end
end
