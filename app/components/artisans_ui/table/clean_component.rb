# frozen_string_literal: true

module ArtisansUi
  module Table
    # Clean Table Component
    # A modern, minimal table component with clean design and subtle styling
    # Based on modern UI patterns with borderless rows and light backgrounds
    #
    # @example Basic usage
    #   <%= render ArtisansUi::Table::CleanComponent.new(
    #     headers: ["Name", "Members", "Roles"],
    #     rows: [
    #       ["Artisans", "1 member", "0 roles"],
    #       ["Build54", "2 members", "0 roles"]
    #     ]
    #   ) %>
    #
    # @example With custom cell content
    #   <%= render ArtisansUi::Table::CleanComponent.new(
    #     headers: ["Team", "Members"],
    #     rows: [
    #       [
    #         { content: "Artisans", class: "font-semibold" },
    #         { content: "1 member", class: "text-gray-600" }
    #       ]
    #     ]
    #   ) %>
    class CleanComponent < ApplicationViewComponent
      def initialize(headers: [], rows: [], hover: true, **html_options)
        @headers = headers
        @rows = rows
        @hover = hover
        @html_options = html_options
      end

      def call
        tag.div(class: class_names("overflow-hidden", @html_options[:class]), **@html_options.except(:class)) do
          tag.div(class: "overflow-x-auto") do
            tag.table(class: "min-w-full") do
              safe_join([
                render_thead,
                render_tbody
              ])
            end
          end
        end
      end

      private

      def render_thead
        return unless @headers.any?

        tag.thead(class: "bg-gray-50/50 dark:bg-gray-800/30 border-b border-gray-200 dark:border-gray-700") do
          tag.tr do
            safe_join(
              @headers.map do |header|
                tag.th(
                  header,
                  class: "px-6 py-3 text-left text-xs font-medium text-gray-600 dark:text-gray-400"
                )
              end
            )
          end
        end
      end

      def render_tbody
        return unless @rows.any?

        tag.tbody(class: "bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-800") do
          safe_join(
            @rows.map do |row|
              render_row(row)
            end
          )
        end
      end

      def render_row(row)
        row_classes = "transition-colors #{@hover ? 'hover:bg-gray-50 dark:hover:bg-gray-800/50' : ''}"

        tag.tr(class: row_classes) do
          safe_join(
            row.map do |cell|
              render_cell(cell)
            end
          )
        end
      end

      def render_cell(cell)
        tag.td(class: "px-6 py-4 text-sm") do
          if cell.is_a?(Hash)
            render_custom_cell(cell)
          else
            tag.span(cell, class: "text-gray-900 dark:text-white")
          end
        end
      end

      def render_custom_cell(cell_data)
        content = cell_data[:content] || cell_data[:value] || ""
        classes = cell_data[:class] || "text-gray-900 dark:text-white"

        tag.span(content, class: classes)
      end
    end
  end
end
