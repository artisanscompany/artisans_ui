# frozen_string_literal: true

module ArtisansUi
  module Form
    # Datalist with labels and inputs
    # Exact RailsBlocks implementation - HTML5 datalist for autocomplete
    # Note: Requires custom CSS classes (form-control, replace-default-datalist-arrow, etc.)
    #
    # @example
    #   <%= render ArtisansUi::Form::DatalistComponent.new %>
    class DatalistComponent < ApplicationViewComponent
      def call
        tag.form(action: "#", class: "w-full max-w-sm space-y-6") do
          safe_join([
            render_text_datalist,
            render_date_datalist,
            render_time_datalist,
            render_datetime_datalist,
            render_month_datalist,
            render_week_datalist,
            render_email_datalist,
            render_url_datalist,
            render_number_datalist,
            render_search_datalist
          ])
        end
      end

      private

      def render_text_datalist
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("Fruits (Text with Datalist)", for: "fruits"),
            tag.input(
              type: "text",
              id: "fruits",
              list: "fruits-list",
              class: "form-control replace-default-datalist-arrow",
              placeholder: "Choose or type a fruit..."
            ),
            tag.datalist(id: "fruits-list") do
              safe_join([
                tag.option(value: "Apple"),
                tag.option(value: "Orange"),
                tag.option(value: "Peach"),
                tag.option(value: "Melon"),
                tag.option(value: "Strawberry"),
                tag.option(value: "Banana"),
                tag.option(value: "Grape"),
                tag.option(value: "Pineapple")
              ])
            end
          ])
        end
      end

      def render_date_datalist
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("Important Date (Date with Datalist)", for: "important-date"),
            tag.input(
              type: "date",
              id: "important-date",
              list: "date-list",
              class: "form-control"
            ),
            tag.datalist(id: "date-list") do
              safe_join([
                tag.option(value: "2025-01-01", label: "New Year's Day"),
                tag.option(value: "2025-07-04", label: "Independence Day"),
                tag.option(value: "2025-12-25", label: "Christmas Day"),
                tag.option(value: "2025-10-31", label: "Halloween"),
                tag.option(value: "2025-02-14", label: "Valentine's Day")
              ])
            end
          ])
        end
      end

      def render_time_datalist
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("Meeting Time (Time with Datalist)", for: "meeting-time"),
            tag.input(
              type: "time",
              id: "meeting-time",
              list: "time-list",
              class: "form-control"
            ),
            tag.datalist(id: "time-list") do
              safe_join([
                tag.option(value: "09:00", label: "Morning Start"),
                tag.option(value: "12:00", label: "Lunch Time"),
                tag.option(value: "14:00", label: "Afternoon"),
                tag.option(value: "17:00", label: "End of Day"),
                tag.option(value: "19:00", label: "Evening")
              ])
            end
          ])
        end
      end

      def render_datetime_datalist
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("Event DateTime (DateTime-Local with Datalist)", for: "event-datetime"),
            tag.input(
              type: "datetime-local",
              id: "event-datetime",
              list: "datetime-list",
              class: "form-control"
            ),
            tag.datalist(id: "datetime-list") do
              safe_join([
                tag.option(value: "2025-12-24T18:00", label: "Christmas Eve Dinner"),
                tag.option(value: "2025-12-31T23:59", label: "New Year's Eve"),
                tag.option(value: "2025-01-01T00:00", label: "New Year's Day"),
                tag.option(value: "2025-07-04T12:00", label: "Independence Day")
              ])
            end
          ])
        end
      end

      def render_month_datalist
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("Birth Month (Month with Datalist)", for: "birth-month"),
            tag.input(
              type: "month",
              id: "birth-month",
              list: "month-list",
              class: "form-control"
            ),
            tag.datalist(id: "month-list") do
              safe_join([
                tag.option(value: "2025-01", label: "January 2025"),
                tag.option(value: "2025-06", label: "June 2025"),
                tag.option(value: "2025-12", label: "December 2025"),
                tag.option(value: "2026-01", label: "January 2026")
              ])
            end
          ])
        end
      end

      def render_week_datalist
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("Project Week (Week with Datalist)", for: "project-week"),
            tag.input(
              type: "week",
              id: "project-week",
              list: "week-list",
              class: "form-control"
            ),
            tag.datalist(id: "week-list") do
              safe_join([
                tag.option(value: "2025-W01", label: "First week of 2025"),
                tag.option(value: "2025-W26", label: "Mid-year week"),
                tag.option(value: "2025-W52", label: "Last week of 2025"),
                tag.option(value: "2025-W13", label: "Q1 End")
              ])
            end
          ])
        end
      end

      def render_email_datalist
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("Email (Email with Domain Suggestions)", for: "email-domain"),
            tag.input(
              type: "email",
              id: "email-domain",
              list: "email-list",
              class: "form-control replace-default-datalist-arrow",
              placeholder: "Enter your email..."
            ),
            tag.datalist(id: "email-list") do
              safe_join([
                tag.option(value: "user@gmail.com"),
                tag.option(value: "user@yahoo.com"),
                tag.option(value: "user@outlook.com"),
                tag.option(value: "user@company.com"),
                tag.option(value: "user@example.org")
              ])
            end
          ])
        end
      end

      def render_url_datalist
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("Website (URL with Datalist)", for: "website-url"),
            tag.input(
              type: "url",
              id: "website-url",
              list: "url-list",
              class: "form-control replace-default-datalist-arrow",
              placeholder: "Enter website URL..."
            ),
            tag.datalist(id: "url-list") do
              safe_join([
                tag.option(value: "https://github.com"),
                tag.option(value: "https://stackoverflow.com"),
                tag.option(value: "https://developer.mozilla.org"),
                tag.option(value: "https://tailwindcss.com"),
                tag.option(value: "https://rubyonrails.org")
              ])
            end
          ])
        end
      end

      def render_number_datalist
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("Age Range (Number with Datalist)", for: "age-range"),
            tag.input(
              type: "number",
              id: "age-range",
              min: "0",
              max: "120",
              list: "age-list",
              class: "form-control replace-default-datalist-arrow",
              placeholder: "Enter your age..."
            ),
            tag.datalist(id: "age-list") do
              safe_join([
                tag.option(value: "18", label: "Adult"),
                tag.option(value: "21", label: "Legal drinking age"),
                tag.option(value: "25", label: "Quarter century"),
                tag.option(value: "30", label: "Thirty"),
                tag.option(value: "40", label: "Forty"),
                tag.option(value: "50", label: "Half century"),
                tag.option(value: "65", label: "Retirement age")
              ])
            end
          ])
        end
      end

      def render_search_datalist
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("Search (Search with Datalist)", for: "search-terms"),
            tag.input(
              type: "search",
              id: "search-terms",
              list: "search-list",
              class: "form-control replace-default-datalist-arrow",
              placeholder: "Search for something..."
            ),
            tag.datalist(id: "search-list") do
              safe_join([
                tag.option(value: "JavaScript tutorials"),
                tag.option(value: "Ruby on Rails guide"),
                tag.option(value: "CSS flexbox"),
                tag.option(value: "HTML5 features"),
                tag.option(value: "Web accessibility"),
                tag.option(value: "Responsive design")
              ])
            end
          ])
        end
      end
    end
  end
end
