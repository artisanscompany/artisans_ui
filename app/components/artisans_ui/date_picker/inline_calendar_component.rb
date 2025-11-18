# frozen_string_literal: true

module ArtisansUi
  module DatePicker
    # Inline Calendar Component (Variant 10)
    class InlineCalendarComponent < ApplicationViewComponent
      def initialize(initial_date: nil, range: false, show_today_button: false, show_clear_button: false, **html_options)
        @initial_date = initial_date
        @range = range
        @show_today_button = show_today_button
        @show_clear_button = show_clear_button
        @html_options = html_options
      end

      def call
        data_attrs = {
          controller: "date-picker",
          date_picker_inline_value: true,
          date_picker_show_today_button_value: @show_today_button,
          date_picker_show_clear_button_value: @show_clear_button
        }
        data_attrs[:date_picker_initial_date_value] = @initial_date if @initial_date
        data_attrs[:date_picker_range_value] = true if @range

        tag.div(data: data_attrs, class: "border border-neutral-200 rounded-lg p-4 w-full max-w-sm flex items-center flex-col justify-center text-center gap-2", **@html_options) do
          tag.input(data: { date_picker_target: "input" }, class: "hidden")
        end
      end
    end
  end
end
