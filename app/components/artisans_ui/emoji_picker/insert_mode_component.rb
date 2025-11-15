# frozen_string_literal: true

module ArtisansUi
  module EmojiPicker
    # Emoji picker with insert mode - inserts emoji at cursor position
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::EmojiPicker::InsertModeComponent.new(
    #     target_selector: "#chat-message"
    #   ) %>
    class InsertModeComponent < ApplicationViewComponent
      def initialize(target_selector: "#chat-message", **html_options)
        @target_selector = target_selector
        @html_options = html_options
      end

      def call
        tag.div(class: "w-full max-w-lg") do
          tag.div(class: "w-full bg-white dark:bg-neutral-800 rounded-xl shadow-sm border border-neutral-200 dark:border-neutral-700 p-4") do
            render_emoji_picker_container
          end
        end
      end

      private

      def render_emoji_picker_container
        tag.div(
          data: {
            controller: "emoji-picker",
            emoji_picker_insert_mode_value: "true",
            emoji_picker_target_selector_value: @target_selector
          }
        ) do
          safe_join([
            render_textarea,
            render_controls,
            render_picker_container,
            render_hidden_input
          ])
        end
      end

      def render_textarea
        tag.textarea(
          id: @target_selector.delete("#"),
          rows: "4",
          class: "form-control w-full mb-3 min-h-24 max-h-48",
          placeholder: "Type your message here..."
        )
      end

      def render_controls
        tag.div(class: "flex items-center justify-between") do
          safe_join([
            render_emoji_button_container,
            render_send_button
          ])
        end
      end

      def render_emoji_button_container
        tag.div(class: "flex items-center gap-2") do
          render_emoji_button
        end
      end

      def render_emoji_button
        tag.button(
          type: "button",
          class: "outline-hidden size-8 text-xl shrink-0 flex items-center justify-center rounded-md text-neutral-700 hover:bg-neutral-100 hover:text-neutral-800 focus:outline-hidden disabled:pointer-events-none disabled:opacity-50 dark:text-neutral-300 dark:hover:bg-neutral-700 dark:hover:text-neutral-200",
          data: {
            action: "click->emoji-picker#toggle",
            emoji_picker_target: "button"
          }
        ) do
          render_emoji_icon
        end
      end

      def render_emoji_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          class: "size-5",
          width: "18",
          height: "18",
          viewBox: "0 0 18 18"
        ) do
          tag.g(
            fill: "none",
            stroke_linecap: "round",
            stroke_linejoin: "round",
            stroke_width: "1.5",
            stroke: "currentColor"
          ) do
            safe_join([
              tag.circle(cx: "9", cy: "9", r: "7.25"),
              tag.circle(cx: "6", cy: "8", r: "1", fill: "currentColor", data: { stroke: "none" }, stroke: "none"),
              tag.circle(cx: "12", cy: "8", r: "1", fill: "currentColor", data: { stroke: "none" }, stroke: "none"),
              tag.path(
                d: "M11.897,10.757c-.154-.154-.366-.221-.583-.189h0c-1.532,.239-3.112,.238-4.638-.001-.214-.032-.421,.035-.572,.185-.154,.153-.227,.376-.193,.598,.23,1.511,1.558,2.651,3.089,2.651s2.86-1.141,3.089-2.654c.033-.216-.039-.436-.192-.589Z",
                fill: "currentColor",
                data: { stroke: "none" },
                stroke: "none"
              )
            ])
          end
        end
      end

      def render_send_button
        tag.button(
          type: "button",
          class: "flex items-center justify-center gap-1.5 rounded-lg border border-neutral-400/30 bg-neutral-800 px-4 py-2 text-sm font-medium whitespace-nowrap text-white shadow-sm transition-all duration-100 ease-in-out select-none hover:bg-neutral-700 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600 disabled:cursor-not-allowed disabled:opacity-50 dark:bg-white dark:text-neutral-800 dark:hover:bg-neutral-100 dark:focus-visible:outline-neutral-200"
        ) do
          "Send"
        end
      end

      def render_picker_container
        tag.div(
          data: { emoji_picker_target: "pickerContainer" },
          class: "hidden absolute z-50 mt-2 flex justify-center inset-x-0 *:w-full"
        )
      end

      def render_hidden_input
        tag.input(
          type: "text",
          name: "emoji",
          class: "form-control !hidden",
          data: { emoji_picker_target: "input" }
        )
      end
    end
  end
end
