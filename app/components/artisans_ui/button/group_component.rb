# frozen_string_literal: true

module ArtisansUi
  module Button
    # Button Group Component
    # Groups multiple buttons together with shared borders
    # Buttons in the group have special styling for first, middle, and last positions
    # Perfect for segmented controls, toolbars, and button clusters
    #
    # @example Basic button group
    #   <%= render ArtisansUi::Button::GroupComponent.new do |group| %>
    #     <% group.with_button do %>
    #       <%= render ArtisansUi::Button::BasicComponent.new { "First" } %>
    #     <% end %>
    #     <% group.with_button do %>
    #       <%= render ArtisansUi::Button::BasicComponent.new { "Second" } %>
    #     <% end %>
    #     <% group.with_button do %>
    #       <%= render ArtisansUi::Button::BasicComponent.new { "Third" } %>
    #     <% end %>
    #   <% end %>
    #
    # @example Mixed variant button group
    #   <%= render ArtisansUi::Button::GroupComponent.new do |group| %>
    #     <% group.with_button do %>
    #       <%= render ArtisansUi::Button::BasicComponent.new(variant: :secondary) { "Cancel" } %>
    #     <% end %>
    #     <% group.with_button do %>
    #       <%= render ArtisansUi::Button::BasicComponent.new(variant: :colored) { "Save" } %>
    #     <% end %>
    #   <% end %>
    #
    # @example Icon button group
    #   <%= render ArtisansUi::Button::GroupComponent.new do |group| %>
    #     <% group.with_button do %>
    #       <%= render ArtisansUi::Button::IconOnlyComponent.new do %>
    #         <svg class="size-4">...</svg>
    #       <% end %>
    #     <% end %>
    #     <% group.with_button do %>
    #       <%= render ArtisansUi::Button::IconOnlyComponent.new do %>
    #         <svg class="size-4">...</svg>
    #       <% end %>
    #     <% end %>
    #   <% end %>
    class GroupComponent < ApplicationViewComponent
      renders_many :buttons

      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.div(**group_attributes) do
          safe_join(buttons)
        end
      end

      private

      def group_attributes
        {
          class: group_classes,
          **@html_options
        }
      end

      def group_classes
        [
          "inline-flex",
          "-space-x-px",
          "rounded-lg",
          "shadow-sm",
          "[&>*:first-child]:rounded-l-lg",
          "[&>*:last-child]:rounded-r-lg",
          "[&>*:not(:first-child):not(:last-child)]:rounded-none",
          "[&>*]:rounded-none",
          "[&>*:first-child]:rounded-l-lg",
          "[&>*:last-child]:rounded-r-lg",
          @html_options[:class]
        ].compact.join(" ")
      end
    end
  end
end
