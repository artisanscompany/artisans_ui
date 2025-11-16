# frozen_string_literal: true

module ArtisansUi
  module Card
    # Card with Avatar Component
    # Universal card for displaying content with profile image/logo, title, metadata, and footer
    # Reusable for team members, job listings, products, articles with authors, etc.
    #
    # @example Basic card with avatar
    #   <%= render ArtisansUi::Card::WithAvatarComponent.new(
    #     avatar_url: "https://example.com/logo.png",
    #     avatar_alt: "Company Logo",
    #     title: "Senior Developer"
    #   ) %>
    #
    # @example Card with avatar fallback initial
    #   <%= render ArtisansUi::Card::WithAvatarComponent.new(
    #     avatar_fallback: "A",
    #     avatar_alt: "Acme Corp",
    #     title: "Product Manager",
    #     subtitle: "Acme Corp"
    #   ) %>
    #
    # @example Highlighted card with metadata and footer
    #   <%= render ArtisansUi::Card::WithAvatarComponent.new(
    #     avatar_url: "https://example.com/logo.png",
    #     avatar_alt: "Company",
    #     title: "Senior Developer",
    #     subtitle: "Tech Company",
    #     variant: :highlighted,
    #     show_badge: true,
    #     badge_text: "NEW",
    #     url: "/jobs/123"
    #   ) do |card| %>
    #     <% card.with_metadata do %>
    #       <div class="flex items-center text-sm text-neutral-600">
    #         <svg class="w-4 h-4 mr-2">...</svg>
    #         San Francisco, CA
    #       </div>
    #     <% end %>
    #     <% card.with_footer do %>
    #       <%= render ArtisansUi::Badge::BasicComponent.new(text: "Full-time", variant: :primary) %>
    #     <% end %>
    #   <% end %>
    class WithAvatarComponent < ApplicationViewComponent
      renders_one :metadata
      renders_one :footer

      VARIANTS = {
        default: "bg-white border-neutral-200",
        highlighted: "bg-gradient-to-br from-yellow-50 to-amber-50 border-yellow-300 shadow-md"
      }.freeze

      def initialize(
        title:,
        avatar_url: nil,
        avatar_fallback: nil,
        avatar_alt: "",
        subtitle: nil,
        url: nil,
        variant: :default,
        show_badge: false,
        badge_text: "NEW",
        **html_options
      )
        @title = title
        @avatar_url = avatar_url
        @avatar_fallback = avatar_fallback
        @avatar_alt = avatar_alt
        @subtitle = subtitle
        @url = url
        @variant = variant.to_sym
        @show_badge = show_badge
        @badge_text = badge_text
        @html_options = html_options

        validate_params!
      end

      def call
        card_content = tag.div(
          class: "#{card_classes} h-full flex flex-col relative",
          **@html_options
        ) do
          safe_join([
            render_badge,
            render_avatar_section,
            render_title,
            render_metadata,
            render_footer
          ].compact)
        end

        if @url
          tag.a(href: @url, class: "group block h-full", target: "_top") do
            card_content
          end
        else
          card_content
        end
      end

      private

      def validate_params!
        raise ArgumentError, "Invalid variant: #{@variant}" unless VARIANTS.key?(@variant)
      end

      def card_classes
        base = "rounded-lg border p-4 sm:p-6 hover:shadow-lg hover:border-yellow-400 transition-all duration-200"
        "#{base} #{VARIANTS[@variant]} dark:bg-neutral-800 dark:border-neutral-700"
      end

      def render_badge
        return unless @show_badge

        tag.div(class: "absolute top-0 right-0") do
          tag.div(class: "bg-yellow-500 text-white text-xs font-bold px-3 py-1 rounded-bl-lg") do
            @badge_text
          end
        end
      end

      def render_avatar_section
        tag.div(class: "mb-3 sm:mb-4") do
          tag.div(class: "flex items-center gap-2 sm:gap-3") do
            safe_join([
              render_avatar,
              render_subtitle
            ].compact)
          end
        end
      end

      def render_avatar
        if @avatar_url
          # Handle both string URLs and Active Storage attachments
          img_src = @avatar_url.respond_to?(:url) ? @avatar_url.url : @avatar_url
          tag.img(
            src: img_src,
            alt: @avatar_alt,
            class: "w-10 h-10 sm:w-12 sm:h-12 rounded-lg object-cover"
          )
        elsif @avatar_fallback
          tag.div(class: "w-10 h-10 sm:w-12 sm:h-12 rounded-lg bg-neutral-100 dark:bg-neutral-700 flex items-center justify-center") do
            tag.span(class: "text-sm sm:text-lg font-semibold text-neutral-500 dark:text-neutral-400") do
              @avatar_fallback
            end
          end
        end
      end

      def render_subtitle
        return unless @subtitle

        tag.div(class: "flex-1") do
          tag.p(class: "text-xs sm:text-sm font-semibold text-neutral-900 dark:text-white") do
            @subtitle
          end
        end
      end

      def render_title
        render ArtisansUi::Typography::HeadingComponent.new(
          level: :h3,
          variant: :section,
          class: "mb-2 sm:mb-3 line-clamp-2 group-hover:text-yellow-600 transition-colors"
        ) do
          @title
        end
      end

      def render_metadata
        return unless metadata?

        tag.div(class: "flex-1 space-y-1.5 sm:space-y-2") do
          metadata
        end
      end

      def render_footer
        return unless footer?

        tag.div(class: "flex flex-wrap gap-1.5 sm:gap-2 mt-3 sm:mt-4 pt-3 sm:pt-4 border-t border-neutral-100 dark:border-neutral-700") do
          footer
        end
      end
    end
  end
end
