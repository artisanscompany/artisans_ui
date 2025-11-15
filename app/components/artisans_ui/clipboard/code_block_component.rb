# frozen_string_literal: true

module ArtisansUi
  module Clipboard
    # Code block with positioned copy button
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Clipboard::CodeBlockComponent.new(
    #     code: "npm install railsblocks",
    #     success_message: "Code copied!"
    #   ) %>
    class CodeBlockComponent < ApplicationViewComponent
      def initialize(code:, success_message: "Code copied!", **html_options)
        @code = code
        @success_message = success_message
        @html_options = html_options
      end

      def call
        tag.div(class: "relative max-w-lg w-full", **@html_options) do
          safe_join([
            render_code_block,
            render_copy_button
          ])
        end
      end

      private

      def render_code_block
        tag.pre(class: "bg-neutral-900 text-neutral-100 p-4 rounded-lg overflow-x-auto text-sm") do
          tag.code(@code)
        end
      end

      def render_copy_button
        tag.button(
          class: "absolute top-2 right-4 flex items-center gap-1.5 rounded-lg px-3.5 py-2 text-sm font-medium shadow-xs focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600 bg-neutral-800/50 text-neutral-50 hover:bg-neutral-700/50 dark:focus-visible:outline-neutral-200 border border-neutral-700",
          data: {
            controller: "clipboard",
            clipboard_text: @code,
            clipboard_success_message_value: @success_message,
            clipboard_show_tooltip_value: true
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
          safe_join([
            clipboard_icon,
            tag.span("Copy")
          ])
        end
      end

      def render_copied_content
        tag.div(data: { clipboard_target: "copiedContent" }, class: "hidden flex items-center gap-1.5") do
          safe_join([
            check_icon,
            tag.span("Copied!")
          ])
        end
      end

      def clipboard_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          class: "size-3.5",
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
          class: "size-3.5",
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
