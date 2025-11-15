# frozen_string_literal: true

module ArtisansUi
  module Kbd
    # Basic KBD component for displaying keyboard shortcuts
    #
    # @example Single key
    #   <%= render ArtisansUi::Kbd::BasicComponent.new do %>
    #     A
    #   <% end %>
    #
    # @example Multiple keys
    #   <div class="flex items-center gap-1">
    #     <%= render ArtisansUi::Kbd::BasicComponent.new do %>
    #       Ctrl
    #     <% end %>
    #     <span>+</span>
    #     <%= render ArtisansUi::Kbd::BasicComponent.new do %>
    #       A
    #     <% end %>
    #   </div>
    class BasicComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.kbd(**@html_options) do
          content
        end
      end
    end
  end
end
