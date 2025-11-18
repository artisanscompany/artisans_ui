# frozen_string_literal: true

module ArtisansUi
  module Checkbox
    # Checkbox with Description Component
    # Checkbox with label and description text for additional context
    # Uses flex layout with top-aligned checkbox
    #
    # @example Basic checkbox with description
    #   <%= render ArtisansUi::Checkbox::WithDescriptionComponent.new(
    #     label: "Email notifications",
    #     description: "Receive email updates about your account activity",
    #     name: "notifications",
    #     value: "email"
    #   ) %>
    #
    # @example Checked checkbox with description
    #   <%= render ArtisansUi::Checkbox::WithDescriptionComponent.new(
    #     label: "Marketing emails",
    #     description: "Get the latest news, updates, and special offers",
    #     name: "notifications",
    #     value: "marketing",
    #     checked: true
    #   ) %>
    #
    # @example Disabled checkbox with description
    #   <%= render ArtisansUi::Checkbox::WithDescriptionComponent.new(
    #     label: "SMS notifications",
    #     description: "This feature is not available in your region",
    #     name: "notifications",
    #     value: "sms",
    #     disabled: true
    #   ) %>
    class WithDescriptionComponent < ApplicationViewComponent
      def initialize(label:, description:, name:, value: nil, checked: false, disabled: false, id: nil, **html_options)
        @label = label
        @description = description
        @name = name
        @value = value
        @checked = checked
        @disabled = disabled
        @id = id || generate_id
        @html_options = html_options
      end

      def call
        tag.div(class: "flex items-start gap-3") do
          safe_join([
            checkbox_input,
            content_block
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
          class: "mt-1",
          **@html_options
        )
      end

      def content_block
        tag.div do
          safe_join([
            label_tag,
            description_tag
          ])
        end
      end

      def label_tag
        tag.label(
          @label,
          for: @id,
          class: "block text-sm font-medium text-neutral-700"
        )
      end

      def description_tag
        tag.div(
          @description,
          class: "text-xs text-neutral-500 mt-1"
        )
      end

      def generate_id
        "checkbox_#{SecureRandom.hex(4)}"
      end
    end
  end
end
