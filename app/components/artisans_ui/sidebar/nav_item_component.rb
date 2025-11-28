# frozen_string_literal: true

module ArtisansUi
  module Sidebar
    # Navigation Item Component for Sidebar
    # Renders a single navigation link with icon, label, badge, and active state
    #
    # @example Basic nav item
    #   <%= render ArtisansUi::Sidebar::NavItemComponent.new(
    #     label: "Dashboard",
    #     href: "/"
    #   ) %>
    #
    # @example Nav item with icon (pass SVG as block)
    #   <%= render ArtisansUi::Sidebar::NavItemComponent.new(
    #     label: "Dashboard",
    #     href: "/",
    #     active: true
    #   ) do %>
    #     <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
    #       <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
    #     </svg>
    #   <% end %>
    #
    # @example Nav item with badge
    #   <%= render ArtisansUi::Sidebar::NavItemComponent.new(
    #     label: "Notifications",
    #     href: "/notifications",
    #     badge_text: "3",
    #     badge_color: "red"
    #   ) %>
    class NavItemComponent < ApplicationViewComponent
      BADGE_COLORS = {
        "yellow" => "bg-yellow-500 text-white",
        "red" => "bg-red-500 text-white",
        "green" => "bg-green-500 text-white",
        "blue" => "bg-blue-500 text-white",
        "neutral" => "bg-neutral-500 text-white"
      }.freeze

      # Creates a new navigation item
      #
      # @param label [String] The text label for the nav item
      # @param href [String] The URL the nav item links to
      # @param active [Boolean] Whether this nav item is currently active (default: false)
      # @param badge_text [String, nil] Optional badge text (e.g., notification count)
      # @param badge_color [String] Badge color variant (default: "yellow")
      # @param html_options [Hash] Additional HTML attributes for the link
      def initialize(label:, href:, active: false, badge_text: nil, badge_color: "yellow", **html_options)
        @label = label
        @href = href
        @active = active
        @badge_text = badge_text
        @badge_color = badge_color
        @html_options = html_options
      end

      def call
        tag.a(**link_attributes) do
          safe_join([
            icon_html,
            label_and_badge_html
          ].compact)
        end
      end

      private

      def link_attributes
        {
          href: @href,
          class: link_classes,
          **@html_options
        }
      end

      def link_classes
        base_classes = "group w-full flex items-center gap-2 rounded-md px-2 py-1.5 text-left text-sm focus:outline-hidden"

        if @active
          active_classes = "bg-gray-200 dark:bg-gray-800 text-gray-900 dark:text-gray-100"
        else
          inactive_classes = "text-neutral-700 dark:text-neutral-300 hover:bg-neutral-100 dark:hover:bg-neutral-800 focus-visible:bg-neutral-100 dark:focus-visible:bg-neutral-800"
        end

        [base_classes, (@active ? active_classes : inactive_classes), @html_options[:class]].compact.join(" ")
      end

      def icon_html
        return unless content.present?

        tag.span(class: "flex items-center justify-center") { content }
      end

      def label_and_badge_html
        tag.span(class: "flex min-w-0 grow items-center sidebar-nav-label transition-all duration-300") do
          safe_join([
            tag.span(@label, class: "truncate"),
            badge_html
          ].compact)
        end
      end

      def badge_html
        return unless @badge_text.present?

        badge_class = BADGE_COLORS[@badge_color] || BADGE_COLORS["yellow"]

        tag.span(
          @badge_text,
          class: "ml-auto px-1.5 py-0.5 text-xs font-medium rounded-full #{badge_class}"
        )
      end
    end
  end
end
