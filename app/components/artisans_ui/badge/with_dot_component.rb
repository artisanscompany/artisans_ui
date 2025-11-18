# frozen_string_literal: true

module ArtisansUi
  module Badge
    # Badge with Indicator Dot Component (Variant 5)
    # Badge displaying a small dot indicator before text
    # Useful for status indicators (online, offline, busy, etc.)
    # Supports animated pulse effect
    # Exact RailsBlocks implementation
    #
    # @example Static dot badge
    #   <%= render ArtisansUi::Badge::WithDotComponent.new(
    #     text: "Online",
    #     variant: :success
    #   ) %>
    #
    # @example Pulsing dot badge
    #   <%= render ArtisansUi::Badge::WithDotComponent.new(
    #     text: "Live",
    #     variant: :error,
    #     pulse: true
    #   ) %>
    #
    # @example Busy status
    #   <%= render ArtisansUi::Badge::WithDotComponent.new(
    #     text: "Busy",
    #     variant: :warning,
    #     pulse: false
    #   ) %>
    class WithDotComponent < ApplicationViewComponent
      VARIANTS = {
        neutral: {
          badge: "bg-neutral-100 text-neutral-700",
          dot: "bg-neutral-500"
        },
        primary: {
          badge: "bg-blue-100 text-blue-700",
          dot: "bg-blue-500"
        },
        success: {
          badge: "bg-green-100 text-green-700",
          dot: "bg-green-500"
        },
        error: {
          badge: "bg-red-100 text-red-700",
          dot: "bg-red-500"
        },
        warning: {
          badge: "bg-yellow-100 text-yellow-700",
          dot: "bg-yellow-500"
        },
        info: {
          badge: "bg-cyan-100 text-cyan-700",
          dot: "bg-cyan-500"
        }
      }.freeze

      def initialize(text:, variant: :neutral, pulse: false, **html_options)
        @text = text
        @variant = variant.to_sym
        @pulse = pulse
        @html_options = html_options

        raise ArgumentError, "Invalid variant: #{@variant}" unless VARIANTS.key?(@variant)
      end

      def call
        tag.span(
          class: "inline-flex items-center gap-1.5 rounded-md px-2 py-1 text-xs font-medium #{badge_classes}",
          **@html_options
        ) do
          safe_join([
            dot_element,
            tag.span(@text)
          ])
        end
      end

      private

      def badge_classes
        VARIANTS[@variant][:badge]
      end

      def dot_classes
        classes = ["size-1.5 rounded-full shrink-0", VARIANTS[@variant][:dot]]
        classes << "animate-pulse" if @pulse
        classes.join(" ")
      end

      def dot_element
        if @pulse
          # Pulsing dot with ring effect
          tag.span(class: "relative flex size-2 shrink-0") do
            safe_join([
              tag.span(
                class: "animate-ping absolute inline-flex h-full w-full rounded-full opacity-75 #{VARIANTS[@variant][:dot]}"
              ),
              tag.span(
                class: "relative inline-flex rounded-full size-2 #{VARIANTS[@variant][:dot]}"
              )
            ])
          end
        else
          # Static dot
          tag.span(class: dot_classes)
        end
      end
    end
  end
end
