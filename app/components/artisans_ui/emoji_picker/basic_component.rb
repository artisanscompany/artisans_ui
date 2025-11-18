# frozen_string_literal: true

module ArtisansUi
  module EmojiPicker
    # Basic emoji picker with button trigger and hidden input
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::EmojiPicker::BasicComponent.new(
    #     name: "emoji"
    #   ) %>
    class BasicComponent < ApplicationViewComponent
      def initialize(name:, value: nil, **html_options)
        @name = name
        @value = value
        @html_options = html_options
      end

      def call
        tag.div(data: { controller: "artisans-ui--emoji-picker" }, **@html_options) do
          safe_join([
            render_button_and_input,
            render_picker_container
          ])
        end
      end

      private

      def render_button_and_input
        tag.div(class: "flex items-center gap-2") do
          safe_join([
            render_button,
            render_input
          ])
        end
      end

      def render_button
        content = if @value.present?
          tag.span(@value, class: "size-6 text-xl shrink-0 flex items-center justify-center")
        else
          render_emoji_icon
        end

        tag.button(
          type: "button",
          class: "outline-hidden size-8 text-xl shrink-0 flex items-center justify-center rounded-md text-neutral-700 hover:bg-neutral-100 hover:text-neutral-800 focus:outline-hidden disabled:pointer-events-none disabled:opacity-50",
          data: {
            action: "click->artisans-ui--emoji-picker#toggle",
            "artisans-ui--emoji-picker-target": "button"
          }
        ) { content }
      end

      def render_emoji_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          class: "size-5",
          width: "18",
          height: "18",
          viewBox: "0 0 18 18"
        ) do
          tag.g(fill: "currentColor") do
            tag.path(d: "M9,1C4.589,1,1,4.589,1,9s3.589,8,8,8,8-3.589,8-8S13.411,1,9,1Zm-4,7c0-.552,.448-1,1-1s1,.448,1,1-.448,1-1,1-1-.448-1-1Zm4,6c-1.531,0-2.859-1.14-3.089-2.651-.034-.221,.039-.444,.193-.598,.151-.15,.358-.217,.572-.185,1.526,.24,3.106,.24,4.638,.001h0c.217-.032,.428,.036,.583,.189,.153,.153,.225,.373,.192,.589-.229,1.513-1.557,2.654-3.089,2.654Zm3-5c-.552,0-1-.448-1-1s.448-1,1-1,1,.448,1,1-.448,1-1,1Z")
          end
        end
      end

      def render_input
        tag.input(
          type: "text",
          name: @name,
          value: @value,
          class: "hidden",
          data: { "artisans-ui--emoji-picker-target": "input" }
        )
      end

      def render_picker_container
        tag.div(
          class: "hidden absolute z-50 mt-2 flex justify-center inset-x-0",
          data: { "artisans-ui--emoji-picker-target": "pickerContainer" }
        )
      end
    end
  end
end
