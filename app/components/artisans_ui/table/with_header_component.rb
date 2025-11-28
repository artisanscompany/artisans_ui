# frozen_string_literal: true

module ArtisansUi
  module Table
    # Table with Header Component
    # A table component with a header section that supports a title and optional action link/button
    #
    # @example Basic usage with header action
    #   <%= render ArtisansUi::Table::WithHeaderComponent.new(
    #     title: "Compliance Requirements",
    #     headers: ["Name"],
    #     rows: @compliance_types.map { |ct| [ct.name] }
    #   ) do |table| %>
    #     <% table.with_header_action do %>
    #       <%= link_to "View all", path, class: "text-sm font-medium text-blue-600 hover:text-blue-900" %>
    #     <% end %>
    #   <% end %>
    #
    # @example Without header action
    #   <%= render ArtisansUi::Table::WithHeaderComponent.new(
    #     title: "Users",
    #     headers: ["Name", "Email"],
    #     rows: @users.map { |u| [u.name, u.email] }
    #   ) %>
    class WithHeaderComponent < ApplicationViewComponent
      renders_one :header_action
      renders_one :search

      def initialize(title:, headers: [], rows: [], align: [], hover: true, variant: :basic, **html_options)
        @title = title
        @headers = headers
        @rows = rows
        @align = align
        @hover = hover
        @variant = variant
        @html_options = html_options
      end

      def call
        if @variant == :clean
          tag.div do
            safe_join([
              render_clean_header_section,
              render_table
            ].compact)
          end
        else
          tag.div(class: "space-y-3") do
            safe_join([
              render_header_section,
              render_table
            ].compact)
          end
        end
      end

      private

      def render_header_section
        tag.div(class: "flex items-center justify-between gap-4 px-6 pb-3") do
          safe_join([
            tag.h3(@title, class: "text-xs font-medium text-gray-500 uppercase tracking-wider flex-shrink-0"),
            header_action
          ].compact)
        end
      end

      def render_clean_header_section
        content_tag(:div, class: "bg-gray-50/50 dark:bg-gray-800/30 border-b border-gray-200 dark:border-gray-700") do
          safe_join([
            # Title and action row
            content_tag(:div, class: "flex items-center justify-between gap-4 py-4") do
              safe_join([
                content_tag(:h2, @title, class: "text-lg font-semibold text-gray-900 dark:text-white flex-shrink-0"),
                header_action
              ].compact)
            end,
            # Optional search row - max width constraint
            search? ? content_tag(:div, class: "pb-4") do
              content_tag(:div, search, class: "max-w-xs")
            end : nil
          ].compact)
        end
      end

      def render_table
        table_component = @variant == :clean ? ArtisansUi::Table::CleanComponent : ArtisansUi::Table::BasicComponent

        if @variant == :clean
          render table_component.new(
            headers: @headers,
            rows: @rows,
            hover: @hover,
            **@html_options
          )
        else
          render table_component.new(
            headers: @headers,
            rows: @rows,
            align: @align,
            hover: @hover,
            **@html_options
          )
        end
      end
    end
  end
end
