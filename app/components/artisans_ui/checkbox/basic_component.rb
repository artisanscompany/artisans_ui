# frozen_string_literal: true

module ArtisansUi
  module Checkbox
    # Basic Checkbox Component (Variant 1)
    # Simple checkbox input with label
    # Uses existing application.css checkbox styles
    # Exact RailsBlocks implementation
    #
    # @example Basic checkbox
    #   <%= render ArtisansUi::Checkbox::BasicComponent.new(
    #     label: "I agree to the terms and conditions",
    #     name: "options",
    #     value: "option1"
    #   ) %>
    #
    # @example Checked checkbox
    #   <%= render ArtisansUi::Checkbox::BasicComponent.new(
    #     label: "Subscribe to newsletter",
    #     name: "options",
    #     value: "option2",
    #     checked: true
    #   ) %>
    #
    # @example Disabled checkbox
    #   <%= render ArtisansUi::Checkbox::BasicComponent.new(
    #     label: "Disabled option",
    #     name: "options",
    #     value: "option3",
    #     disabled: true
    #   ) %>
    class BasicComponent < ApplicationViewComponent
      def initialize(label:, name:, value: nil, checked: false, disabled: false, id: nil, **html_options)
        @label = label
        @name = name
        @value = value
        @checked = checked
        @disabled = disabled
        @id = id || generate_id
        @html_options = html_options
      end

      def call
        tag.div(class: "flex items-center gap-2") do
          safe_join([
            checkbox_input,
            label_tag
          ])
        end
      end

      private

      def checkbox_input
        tag.input(
          type: "checkbox",
          id: @id,
          name: @name,
          value: @value,
          checked: @checked,
          disabled: @disabled,
          **@html_options
        )
      end

      def label_tag
        tag.label(
          @label,
          for: @id,
          class: label_classes
        )
      end

      def label_classes
        if @disabled
          "text-sm font-medium text-neutral-400 cursor-not-allowed opacity-50"
        else
          "text-sm font-medium text-neutral-700"
        end
      end

      def generate_id
        "checkbox_#{SecureRandom.hex(4)}"
      end
    end
  end
end
