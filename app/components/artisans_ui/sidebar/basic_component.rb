# frozen_string_literal: true

module ArtisansUi
  module Sidebar
    # Sidebar Component - Responsive sidebar with header, navigation, and footer sections
    # Supports mobile slide-out and desktop persistent layouts with collapse functionality
    #
    # @example Basic sidebar
    #   <%= render ArtisansUi::Sidebar::BasicComponent.new do |sidebar| %>
    #     <% sidebar.with_header do %>
    #       <div class="flex items-center space-x-2">
    #         <%= image_tag "/logo.png", class: "h-8 w-8" %>
    #         <span class="text-lg font-bold">My App</span>
    #       </div>
    #     <% end %>
    #     <% sidebar.with_nav_item(label: "Dashboard", href: "/", icon_svg: home_icon_svg, active: true) %>
    #     <% sidebar.with_footer do %>
    #       <div>User info and logout</div>
    #     <% end %>
    #   <% end %>
    #
    # @example With section dividers
    #   <%= render ArtisansUi::Sidebar::BasicComponent.new do |sidebar| %>
    #     <% sidebar.with_nav_item(label: "Dashboard", href: "/") %>
    #     <% sidebar.with_nav_section(heading: "Settings") %>
    #     <% sidebar.with_nav_item(label: "Profile", href: "/profile") %>
    #   <% end %>
    class BasicComponent < ApplicationViewComponent
      renders_one :header
      renders_one :footer
      renders_many :nav_items, lambda { |**args, &block|
        if args[:heading]
          NavSectionComponent.new(**args)
        else
          NavItemComponent.new(**args, &block)
        end
      }

      # Creates a new sidebar component
      #
      # @param storage_key [String] localStorage key for collapse state persistence
      # @param html_options [Hash] Additional HTML attributes
      def initialize(storage_key: "sidebarOpen", **html_options)
        @storage_key = storage_key
        @html_options = html_options
      end

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
