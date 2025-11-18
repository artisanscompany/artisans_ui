# frozen_string_literal: true

module ArtisansUi
  module Clipboard
    # Input field with attached copy button
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Clipboard::WithInputComponent.new(
    #     text: "https://railsblocks.com",
    #     input_id: "url-input",
    #     success_message: "Link copied to clipboard!"
    #   ) %>
    class WithInputComponent < ApplicationViewComponent
      def initialize(text:, input_id: "clipboard-input", success_message: "Copied!", **html_options)
        @text = text
        @input_id = input_id
        @success_message = success_message
        @html_options = html_options
      end

      def call
        tag.div(class: "flex max-w-md", **@html_options) do
          safe_join([
            render_input,
            render_button
          ])
        end
      end

      private

      def render_input
        tag.input(
          type: "text",
          id: @input_id,
          value: @text,
          readonly: true,
          class: "flex-1 rounded-l-lg border border-r-0 border-neutral-300 bg-neutral-50 px-3 py-2 text-sm text-neutral-600 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600"
        )
      end

      def render_button
        tag.button(
          class: "rounded-r-lg border border-l border-neutral-300 bg-white px-3 py-2 text-sm font-medium text-neutral-700 hover:bg-neutral-50 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600",
          data: {
            controller: "clipboard",
            clipboard_text: @text,
            clipboard_success_message_value: @success_message
          }
        ) do
          safe_join([
            render_copy_content,
            render_copied_content
          ])
        end
      end

      def render_copy_content
        tag.div(data: { clipboard_target: "copyContent" }, class: "flex items-center gap-1.5") do
          clipboard_icon
        end
      end

      def render_copied_content
        tag.div(data: { clipboard_target: "copiedContent" }, class: "hidden flex items-center gap-1.5") do
          check_icon
        end
      end

      def clipboard_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          class: "size-4",
          width: "18",
          height: "18",
          viewBox: "0 0 18 18"
        ) do
          tag.g(fill: "currentColor") do
            tag.path(d: "M12.75,2h-.275c-.123-.846-.845-1.5-1.725-1.5h-3.5c-.879,0-1.602,.654-1.725,1.5h-.275c-1.517,0-2.75,1.233-2.75,2.75V14.25c0,1.517,1.233,2.75,2.75,2.75h7.5c1.517,0,2.75-1.233,2.75-2.75V4.75c0-1.517-1.233-2.75-2.75-2.75Zm-5.75,.25c0-.138,.112-.25,.25-.25h3.5c.138,0,.25,.112,.25,.25v1c0,.138-.112,.25-.25,.25h-3.5c-.138,0-.25-.112-.25-.25v-1Zm4.75,10.25H6.25c-.414,0-.75-.336-.75-.75s.336-.75,.75-.75h5.5c.414,0,.75,.336,.75,.75s-.336,.75-.75,.75Zm0-3H6.25c-.414,0-.75-.336-.75-.75s.336-.75,.75-.75h5.5c.414,0,.75,.336,.75,.75s-.336,.75-.75,.75Z")
          end
        end
      end

      def check_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          class: "size-4",
          width: "18",
          height: "18",
          viewBox: "0 0 18 18"
        ) do
          tag.g(fill: "currentColor") do
            tag.path(d: "M6.75,15h-.002c-.227,0-.442-.104-.583-.281L2.165,9.719c-.259-.324-.207-.795,.117-1.054,.325-.259,.796-.206,1.054,.117l3.418,4.272L14.667,3.278c.261-.322,.732-.373,1.055-.111,.322,.261,.372,.733,.111,1.055L7.333,14.722c-.143,.176-.357,.278-.583,.278Z")
          end
        end
      end
    end
  end
end
