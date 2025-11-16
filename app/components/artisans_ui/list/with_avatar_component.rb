# frozen_string_literal: true

module ArtisansUi
  module List
    # List Item with Avatar Component
    # Horizontal row layout for displaying content with profile image/logo, title, and metadata
    # Designed for compact, full-width list views (not grid cards)
    # Reusable for job listings, team members, products, etc. in list format
    #
    # @example Basic list item with avatar
    #   <%= render ArtisansUi::List::WithAvatarComponent.new(
    #     avatar_url: "https://example.com/logo.png",
    #     avatar_alt: "Company Logo",
    #     title: "Senior Developer",
    #     subtitle: "Acme Corp"
    #   ) do %>
    #     <span class="text-sm text-neutral-600">Location, badges, etc.</span>
    #   <% end %>
    #
    # @example List item with fallback avatar
    #   <%= render ArtisansUi::List::WithAvatarComponent.new(
    #     avatar_fallback: "A",
    #     avatar_alt: "Acme Corp",
    #     title: "Product Manager",
    #     subtitle: "Acme Corp",
    #     url: "/jobs/123"
    #   ) do %>
    #     <div class="flex items-center gap-4">
    #       <span>Location</span>
    #       <span>Full-time</span>
    #     </div>
    #   <% end %>
    #
    # @example Highlighted list item with badge
    #   <%= render ArtisansUi::List::WithAvatarComponent.new(
    #     avatar_url: "https://example.com/logo.png",
    #     avatar_alt: "Company",
    #     title: "Senior Developer",
    #     subtitle: "Tech Company",
    #     variant: :highlighted,
    #     show_badge: true,
    #     badge_text: "NEW",
    #     url: "/jobs/123"
    #   ) do %>
    #     <div class="flex items-center gap-4 text-sm text-neutral-600">
    #       <span>San Francisco, CA</span>
    #       <span>Full-time</span>
    #     </div>
    #   <% end %>
    class WithAvatarComponent < ApplicationViewComponent
      VARIANTS = {
        default: "bg-neutral-50",
        highlighted: "bg-gradient-to-br from-yellow-50 to-amber-50"
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
        list_content = tag.div(
          class: "#{list_classes} flex items-center gap-3 sm:gap-4 py-3 sm:py-4 px-4 sm:px-6 relative mb-2 rounded-lg",
          **@html_options
        ) do
          safe_join([
            render_badge,
            render_avatar,
            render_content_section
          ].compact)
        end

        if @url
          tag.a(href: @url, class: "group block", target: "_top") do
            list_content
          end
        else
          list_content
        end
      end

      private

      def validate_params!
        raise ArgumentError, "Invalid variant: #{@variant}" unless VARIANTS.key?(@variant)
      end

      def list_classes
        base = "hover:bg-neutral-100 dark:hover:bg-neutral-800 transition-colors"
        "#{base} #{VARIANTS[@variant]} dark:bg-neutral-800"
      end

      def render_badge
        return unless @show_badge

        tag.div(class: "absolute top-0 right-0") do
          tag.div(class: "bg-yellow-500 text-white text-xs font-bold px-3 py-1 rounded-bl-lg") do
            @badge_text
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
            class: "w-12 h-12 sm:w-14 sm:h-14 rounded-lg object-cover flex-shrink-0"
          )
        elsif @avatar_fallback
          tag.div(class: "w-12 h-12 sm:w-14 sm:h-14 rounded-lg bg-neutral-100 dark:bg-neutral-700 flex items-center justify-center flex-shrink-0") do
            tag.span(class: "text-lg font-semibold text-neutral-500 dark:text-neutral-400") do
              @avatar_fallback
            end
          end
        end
      end

      def render_content_section
        tag.div(class: "flex-1 min-w-0") do
          safe_join([
            render_header,
            tag.div(class: "mt-1") { content }
          ].compact)
        end
      end

      def render_header
        tag.div(class: "flex items-baseline gap-2") do
          safe_join([
            render_title,
            render_subtitle
          ].compact)
        end
      end

      def render_title
        tag.h3(class: "text-base sm:text-lg font-semibold text-neutral-900 dark:text-white truncate group-hover:text-yellow-600 transition-colors") do
          @title
        end
      end

      def render_subtitle
        return unless @subtitle

        tag.span(class: "text-xs sm:text-sm text-neutral-600 dark:text-neutral-400 flex-shrink-0") do
          @subtitle
        end
      end
    end
  end
end
