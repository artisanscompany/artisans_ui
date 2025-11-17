# frozen_string_literal: true

module ArtisansUi
  module List
    # List Item with Icon Component
    # Compact horizontal row layout for displaying content with an icon
    # More compact than WithAvatarComponent, designed for simple list items
    # Perfect for documents, settings, features, etc.
    #
    # @example Basic list item with icon
    #   <%= render ArtisansUi::List::WithIconComponent.new(
    #     title: "My Resume.pdf",
    #     icon: :document,
    #     url: "/resumes/1"
    #   ) %>
    #
    # @example List item with custom content
    #   <%= render ArtisansUi::List::WithIconComponent.new(
    #     title: "Project Proposal",
    #     icon: :folder,
    #     url: "/projects/1"
    #   ) do %>
    #     <span class="text-sm text-neutral-600">Last modified 2 days ago</span>
    #   <% end %>
    #
    # @example List item with badge
    #   <%= render ArtisansUi::List::WithIconComponent.new(
    #     title: "Cover Letter",
    #     icon: :mail,
    #     url: "/cover-letters/1"
    #   ) do %>
    #     <%= render ArtisansUi::Badge::BasicComponent.new(text: "New", variant: :success) %>
    #   <% end %>
    class WithIconComponent < ApplicationViewComponent
      ICONS = {
        document: '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path></svg>',
        folder: '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-6l-2-2H5a2 2 0 00-2 2z"></path></svg>',
        mail: '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path></svg>',
        briefcase: '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path></svg>'
      }.freeze

      def initialize(
        title:,
        icon: :document,
        url: nil,
        **html_options
      )
        @title = title
        @icon = icon.to_sym
        @url = url
        @html_options = html_options

        validate_params!
      end

      def call
        list_content = tag.div(
          class: list_classes,
          **@html_options
        ) do
          safe_join([
            render_icon,
            render_content_section
          ].compact)
        end

        if @url
          tag.a(href: @url, class: "group block") do
            list_content
          end
        else
          list_content
        end
      end

      private

      def validate_params!
        raise ArgumentError, "Invalid icon: #{@icon}. Available icons: #{ICONS.keys.join(', ')}" unless ICONS.key?(@icon)
      end

      def list_classes
        "flex items-center gap-3 py-3 px-4 rounded-lg bg-neutral-50 dark:bg-neutral-800 hover:bg-neutral-100 dark:hover:bg-neutral-700 transition-colors mb-2"
      end

      def render_icon
        tag.div(class: "w-10 h-10 rounded-lg bg-yellow-100 dark:bg-yellow-900/30 flex items-center justify-center flex-shrink-0 text-yellow-600 dark:text-yellow-500") do
          ICONS[@icon].html_safe
        end
      end

      def render_content_section
        tag.div(class: "flex-1 min-w-0 flex items-center justify-between gap-4") do
          safe_join([
            render_title,
            tag.div(class: "flex items-center gap-2 flex-shrink-0") { content }
          ].compact)
        end
      end

      def render_title
        tag.h3(class: "text-sm font-medium text-neutral-900 dark:text-white truncate group-hover:text-yellow-600 dark:group-hover:text-yellow-500 transition-colors") do
          @title
        end
      end
    end
  end
end
