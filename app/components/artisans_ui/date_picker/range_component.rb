# frozen_string_literal: true

module ArtisansUi
  module DatePicker
    # Date Range Picker Component (Variant 3)
    # Select a date range with start and end dates
    # Exact RailsBlocks implementation
    class RangeComponent < ApplicationViewComponent
      def initialize(initial_dates: nil, show_today_button: false, show_clear_button: false, placeholder: "Select date range...", **html_options)
        @initial_dates = initial_dates
        @show_today_button = show_today_button
        @show_clear_button = show_clear_button
        @placeholder = placeholder
        @html_options = html_options
      end

      def call
        data_attrs = {
          controller: "date-picker",
          date_picker_range_value: true,
          date_picker_show_today_button_value: @show_today_button,
          date_picker_show_clear_button_value: @show_clear_button
        }
        data_attrs[:date_picker_initial_date_value] = @initial_dates.to_json if @initial_dates

        tag.div(data: data_attrs, class: "relative w-full max-w-sm") do
          safe_join([
            tag.input(
              class: "block w-full rounded-lg border-0 px-3 py-2 text-neutral-900 shadow-sm ring-1 ring-inset ring-neutral-300 placeholder:text-neutral-500 focus:ring-2 focus:ring-neutral-600 outline-hidden leading-6 dark:bg-neutral-700 dark:ring-neutral-600 dark:placeholder-neutral-300 dark:text-white dark:focus:ring-neutral-500 text-base sm:text-sm",
              readonly: true,
              data: { date_picker_target: "input" },
              placeholder: @placeholder,
              **@html_options
            ),
            tag.div(class: "pointer-events-none absolute inset-y-0 right-3 flex items-center justify-center opacity-80") do
              tag.svg(xmlns: "http://www.w3.org/2000/svg", class: "size-4", viewBox: "0 0 18 18") do
                tag.g(fill: "currentColor") do
                  safe_join([
                    tag.path(d: "M5.75,3.5c-.414,0-.75-.336-.75-.75V.75c0-.414,.336-.75,.75-.75s.75,.336,.75,.75V2.75c0,.414-.336,.75-.75,.75Z"),
                    tag.path(d: "M12.25,3.5c-.414,0-.75-.336-.75-.75V.75c0-.414,.336-.75,.75-.75s.75,.336,.75,.75V2.75c0,.414-.336,.75-.75,.75Z"),
                    tag.path(d: "M13.75,2H4.25c-1.517,0-2.75,1.233-2.75,2.75V13.25c0,1.517,1.233,2.75,2.75,2.75H13.75c1.517,0,2.75-1.233,2.75-2.75V4.75c0-1.517-1.233-2.75-2.75-2.75Zm0,12.5H4.25c-.689,0-1.25-.561-1.25-1.25V7H15v6.25c0,.689-.561,1.25-1.25,1.25Z")
                  ])
                end
              end
            end
          ])
        end
      end
    end
  end
end
