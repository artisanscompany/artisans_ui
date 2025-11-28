# frozen_string_literal: true

module ArtisansUi
  module Sidebar
    # Sidebar Component with Profile Dropdown at Top
    # Designed for dashboards where user profile dropdown should be prominently displayed in header
    #
    # @example With user profile dropdown
    #   <%= render ArtisansUi::Sidebar::ProfileDropdownTopComponent.new do |sidebar| %>
    #     <% sidebar.with_header do %>
    #       <%= render ArtisansUi::Sidebar::UserProfileButtonComponent.new(
    #         user: current_user,
    #         logout_path: destroy_user_session_path
    #       ) %>
    #     <% end %>
    #     <% sidebar.with_nav_item(label: "Dashboard", href: "/") %>
    #     <% sidebar.with_nav_item(label: "Settings", href: "/settings") %>
    #   <% end %>
    #
    # @example With custom breakpoint
    #   <%= render ArtisansUi::Sidebar::ProfileDropdownTopComponent.new(breakpoint: "lg") do |sidebar| %>
    #     <% sidebar.with_header do %>
    #       User profile dropdown here
    #     <% end %>
    #   <% end %>
    class ProfileDropdownTopComponent < ApplicationViewComponent
      renders_one :header
      renders_one :footer
      renders_one :secondary_sidebar
      renders_one :mobile_nav
      renders_many :nav_items, lambda { |**args, &block|
        if args[:heading] || args.empty?
          NavSectionComponent.new(**args)
        else
          NavItemComponent.new(**args, &block)
        end
      }

      # Creates a new sidebar with profile dropdown at top
      #
      # @param breakpoint [String] Responsive breakpoint for desktop visibility ("md" or "lg", default: "lg")
      # @param storage_key [String] localStorage key for collapse state persistence
      # @param html_options [Hash] Additional HTML attributes
      def initialize(breakpoint: "lg", storage_key: "sidebarOpen", **html_options)
        @breakpoint = breakpoint
        @storage_key = storage_key
        @html_options = html_options
      end

      attr_reader :breakpoint

      private

      def wrapper_attributes
        {
          class: "flex h-full w-full relative",
          data: {
            controller: "sidebar",
            sidebar_storage_key_value: @storage_key
          },
          **@html_options
        }
      end
    end
  end
end
