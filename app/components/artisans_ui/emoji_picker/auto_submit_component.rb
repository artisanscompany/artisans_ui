# frozen_string_literal: true

module ArtisansUi
  module EmojiPicker
    # Emoji picker with auto-submit control
    # Exact RailsBlocks implementation - demonstrates auto-submit enabled vs disabled
    #
    # @example Auto-submit enabled
    #   <%= render ArtisansUi::EmojiPicker::AutoSubmitComponent.new(
    #     auto_submit: true
    #   ) %>
    #
    # @example Auto-submit disabled
    #   <%= render ArtisansUi::EmojiPicker::AutoSubmitComponent.new(
    #     auto_submit: false
    #   ) %>
    class AutoSubmitComponent < ApplicationViewComponent
      def initialize(auto_submit: false, name: "reaction", label: "Reaction", input_id: nil, **html_options)
        @auto_submit = auto_submit
        @name = name
        @label = label
        @input_id = input_id || "reaction_#{object_id}"
        @html_options = html_options
      end

      def call
        tag.div(class: "space-y-6") do
          safe_join([
            render_auto_submit_form,
            render_manual_submit_form
          ])
        end
      end

      private

      def render_auto_submit_form
        tag.div(class: "space-y-2") do
          safe_join([
            tag.h4("Auto-submit enabled (default)", class: "text-sm font-medium text-neutral-700"),
            tag.form(class: "p-4 border border-neutral-200 rounded-lg bg-neutral-50") do
              render_emoji_picker(
                auto_submit: true,
                input_id: "reaction_1",
                label_text: "Reaction (auto-submits)"
              )
            end
          ])
        end
      end

      def render_manual_submit_form
        tag.div(class: "space-y-2") do
          safe_join([
            tag.h4("Auto-submit disabled", class: "text-sm font-medium text-neutral-700"),
            tag.form(class: "p-4 border border-neutral-200 rounded-lg bg-neutral-50") do
              tag.div(class: "space-y-4") do
                safe_join([
                  render_emoji_picker(
                    auto_submit: false,
                    input_id: "reaction_2",
                    label_text: "Reaction (manual submit)",
                    container_class: "mb-4"
                  ),
                  render_submit_button
                ])
              end
            end
          ])
        end
      end

      def render_emoji_picker(auto_submit:, input_id:, label_text:, container_class: "")
        tag.div(
          class: "relative gap-y-1.5 #{container_class}",
          data: {
            controller: "emoji-picker",
            emoji_picker_auto_submit_value: auto_submit
          }
        ) do
          safe_join([
            render_label(input_id, label_text),
            render_button_and_input_group(input_id),
            render_picker_container
          ])
        end
      end

      def render_label(input_id, text)
        tag.label(
          text,
          for: input_id,
          class: "block text-sm font-medium text-neutral-700 mb-2"
        )
      end

      def render_button_and_input_group(input_id)
        tag.div(class: "flex items-center gap-2") do
          safe_join([
            render_emoji_button,
            render_text_input(input_id)
          ])
        end
      end

      def render_emoji_button
        tag.button(
          type: "button",
          class: "outline-hidden size-8 text-xl shrink-0 flex items-center justify-center rounded-md text-neutral-700 hover:bg-neutral-100 hover:text-neutral-800 focus:outline-hidden disabled:pointer-events-none disabled:opacity-50",
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
          class: "size-6",
          width: "18",
          height: "18",
          viewBox: "0 0 18 18"
        ) do
          tag.g(fill: "currentColor") do
            tag.path(d: "M9,1C4.589,1,1,4.589,1,9s3.589,8,8,8,8-3.589,8-8S13.411,1,9,1Zm-4,7c0-.552,.448-1,1-1s1,.448,1,1-.448,1-1,1-1-.448-1-1Zm4,6c-1.531,0-2.859-1.14-3.089-2.651-.034-.221,.039-.444,.193-.598,.151-.15,.358-.217,.572-.185,1.526,.24,3.106,.24,4.638,.001h0c.217-.032,.428,.036,.583,.189,.153,.153,.225,.373,.192,.589-.229,1.513-1.557,2.654-3.089,2.654Zm3-5c-.552,0-1-.448-1-1s.448-1,1-1,1,.448,1,1-.448,1-1,1Z")
          end
        end
      end

      def render_text_input(input_id)
        tag.input(
          type: "text",
          id: input_id,
          name: @name,
          autocomplete: "off",
          class: "form-control",
          placeholder: "Choose an emoji...",
          data: { emoji_picker_target: "input" }
        )
      end

      def render_picker_container
        tag.div(
          data: { emoji_picker_target: "pickerContainer" },
          class: "hidden absolute z-50 mt-2 flex justify-start inset-x-0"
        )
      end

      def render_submit_button
        tag.button(
          type: "submit",
          class: "w-full flex items-center justify-center gap-1.5 rounded-lg border border-neutral-400/30 bg-neutral-800 px-3 py-2 text-xs font-medium whitespace-nowrap text-white shadow-sm transition-all duration-100 ease-in-out select-none hover:bg-neutral-700 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600 disabled:cursor-not-allowed disabled:opacity-50"
        ) do
          "Send"
        end
      end
    end
  end
end
