# frozen_string_literal: true

module ArtisansUi
  module Form
    # Time Input Component
    # Standalone time input field with native time picker
    #
    # @example Basic time input
    #   <%= render ArtisansUi::Form::TimeInputComponent.new(
    #     name: :appointment_time,
    #     placeholder: "Select time"
    #   ) %>
    #
    # @example With min/max times
    #   <%= render ArtisansUi::Form::TimeInputComponent.new(
    #     name: :meeting_time,
    #     min: "09:00",
    #     max: "17:00"
    #   ) %>
    #
    # @example With step (15 minute intervals)
    #   <%= render ArtisansUi::Form::TimeInputComponent.new(
    #     name: :schedule,
    #     step: 900,
    #     required: true
    #   ) %>
    class TimeInputComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.input(type: "time", **merged_options)
      end

      private

      def default_classes
        "w-full px-4 py-2.5 text-sm border border-neutral-200 rounded-lg bg-white text-neutral-900 placeholder-neutral-500 focus:outline-none focus:ring-2 focus:ring-neutral-300 focus:border-transparent transition-colors"
      end

      def merged_options
        custom_class = @html_options.delete(:class)
        @html_options.merge(class: [default_classes, custom_class].compact.join(" "))
      end
    end
  end
end
