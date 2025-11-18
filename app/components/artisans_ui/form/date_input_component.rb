# frozen_string_literal: true

module ArtisansUi
  module Form
    # Date Input Component
    # Standalone date input field with native date picker
    #
    # @example Basic date input
    #   <%= render ArtisansUi::Form::DateInputComponent.new(
    #     name: :birth_date,
    #     placeholder: "Select date"
    #   ) %>
    #
    # @example With min/max dates
    #   <%= render ArtisansUi::Form::DateInputComponent.new(
    #     name: :appointment,
    #     min: Date.today,
    #     max: Date.today + 30.days
    #   ) %>
    #
    # @example With value
    #   <%= render ArtisansUi::Form::DateInputComponent.new(
    #     name: :event_date,
    #     value: Date.today,
    #     required: true
    #   ) %>
    class DateInputComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.input(type: "date", **merged_options)
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
