# frozen_string_literal: true

module ArtisansUi
  module Table
    # Basic Table Component
    # A flexible table component with support for headers, rows, and custom styling
    #
    # @example Basic usage
    #   <%= render ArtisansUi::Table::BasicComponent.new(
    #     headers: ["Name", "Email", "Role"],
    #     rows: [
    #       ["John Doe", "john@example.com", "Admin"],
    #       ["Jane Smith", "jane@example.com", "User"]
    #     ]
    #   ) %>
    #
    # @example With custom column alignment
    #   <%= render ArtisansUi::Table::BasicComponent.new(
    #     headers: ["Product", "Price", "Stock"],
    #     rows: data,
    #     align: [:left, :right, :center]
    #   ) %>
    class BasicComponent < ApplicationViewComponent
      def initialize(headers: [], rows: [], align: [], hover: true, **html_options)
        @headers = headers
        @rows = rows
        @align = align
        @hover = hover
        @html_options = html_options
      end

      def call
        tag.div(class: class_names("bg-white border border-gray-200 rounded-lg overflow-hidden", @html_options[:class]), **@html_options.except(:class)) do
          tag.div(class: "overflow-x-auto") do
            tag.table(class: "min-w-full divide-y divide-gray-200") do
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

        tag.thead(class: "bg-gray-50") do
          tag.tr do
            safe_join(
              @headers.each_with_index.map do |header, index|
                alignment = column_alignment(index)
                tag.th(
                  header,
                  class: "px-6 py-3 text-#{alignment} text-xs font-medium text-gray-500 uppercase tracking-wider"
                )
              end
            )
          end
        end
      end

      def render_tbody
        return unless @rows.any?

        tag.tbody(class: "bg-white divide-y divide-gray-200") do
          safe_join(
            @rows.map do |row|
              render_row(row)
            end
          )
        end
      end

      def render_row(row)
        row_classes = "#{@hover ? 'hover:bg-gray-50' : ''}"
        
        tag.tr(class: row_classes) do
          safe_join(
            row.each_with_index.map do |cell, index|
              render_cell(cell, index)
            end
          )
        end
      end

      def render_cell(cell, index)
        alignment = column_alignment(index)
        
        tag.td(class: "px-6 py-4 text-sm text-gray-900 text-#{alignment}") do
          if cell.is_a?(Hash)
            render_custom_cell(cell)
          else
            cell
          end
        end
      end

      def render_custom_cell(cell_data)
        content = cell_data[:content] || cell_data[:value] || ""
        classes = cell_data[:class] || ""
        
        if classes.present?
          tag.span(content, class: classes)
        else
          content
        end
      end

      def column_alignment(index)
        @align[index]&.to_s || "left"
      end
    end
  end
end
