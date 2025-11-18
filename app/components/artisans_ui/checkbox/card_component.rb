# frozen_string_literal: true

module ArtisansUi
  module Checkbox
    # Card Checkbox Component
    # Card-style checkbox for pricing plans, features, or selections
    # Uses modern CSS with :has() pseudo-class for interactive states
    #
    # @example Basic card checkbox
    #   <%= render ArtisansUi::Checkbox::CardComponent.new(
    #     title: "Basic Plan",
    #     name: "plan",
    #     value: "basic"
    #   ) %>
    #
    # @example Card with subtitle and price
    #   <%= render ArtisansUi::Checkbox::CardComponent.new(
    #     title: "Pro Plan",
    #     subtitle: "For growing teams",
    #     price: "$29/month",
    #     name: "plan",
    #     value: "pro"
    #   ) %>
    #
    # @example Checked card checkbox
    #   <%= render ArtisansUi::Checkbox::CardComponent.new(
    #     title: "Enterprise Plan",
    #     subtitle: "For large organizations",
    #     price: "$99/month",
    #     name: "plan",
    #     value: "enterprise",
    #     checked: true
    #   ) %>
    class CardComponent < ApplicationViewComponent
      def initialize(title:, name:, value:, subtitle: nil, price: nil, checked: false, id: nil)
        @title = title
        @subtitle = subtitle
        @price = price
        @name = name
        @value = value
        @checked = checked
        @id = id || generate_id
      end

      def call
        tag.label(for: @id, class: label_classes) do
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
          class: "absolute left-4"
        )
      end

      def content_block
        tag.div(class: "flex-1 ml-8") do
          safe_join([
            title_tag,
            subtitle_tag,
            price_tag
          ].compact)
        end
      end

      def title_tag
        tag.div(
          @title,
          class: "text-sm font-semibold text-neutral-900"
        )
      end

      def subtitle_tag
        return nil unless @subtitle

        tag.div(
          @subtitle,
          class: "text-xs text-neutral-500"
        )
      end

      def price_tag
        return nil unless @price

        tag.div(
          @price,
          class: "text-sm font-medium text-neutral-900"
        )
      end

      def label_classes
        "relative py-3 px-4 flex items-center font-medium bg-white text-neutral-800 rounded-xl cursor-pointer ring-1 ring-neutral-200 has-[:checked]:ring-2 has-[:checked]:ring-neutral-400 has-[:checked]:bg-neutral-100 has-[:checked]:text-neutral-900"
      end

      def generate_id
        "checkbox_#{SecureRandom.hex(4)}"
      end
    end
  end
end
