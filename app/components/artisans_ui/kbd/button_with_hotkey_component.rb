# frozen_string_literal: true

module ArtisansUi
  module Kbd
    # Button with hotkey support using the hotkey Stimulus controller
    #
    # @example Basic button with Ctrl+B hotkey
    #   <%= render ArtisansUi::Kbd::ButtonWithHotkeyComponent.new(
    #     text: "Click me",
    #     hotkey: "ctrl+b",
    #     kbd_text: ["Ctrl", "B"]
    #   ) %>
    #
    # @example Link with Shift+G hotkey
    #   <%= render ArtisansUi::Kbd::ButtonWithHotkeyComponent.new(
    #     text: "Open Google",
    #     hotkey: "shift+g",
    #     kbd_text: ["Shift", "G"],
    #     href: "https://www.google.com",
    #     target: "_blank"
    #   ) %>
    #
    # @example Button with multiple platform hotkeys
    #   <%= render ArtisansUi::Kbd::ButtonWithHotkeyComponent.new(
    #     text: "Search",
    #     hotkey: ["meta+m", "ctrl+m"],
    #     kbd_text: ["⌘", "M"],
    #     kbd_alt_text: ["Ctrl", "M"]
    #   ) %>
    class ButtonWithHotkeyComponent < ApplicationViewComponent
      def initialize(text:, hotkey:, kbd_text: [], kbd_alt_text: nil, href: nil, target: nil, onclick: nil, **html_options)
        @text = text
        @hotkey = Array(hotkey)
        @kbd_text = kbd_text
        @kbd_alt_text = kbd_alt_text
        @href = href
        @target = target
        @onclick = onclick
        @html_options = html_options
      end

      def call
        if @href
          render_link
        else
          render_button
        end
      end

      private

      def render_button
        tag.button(
          data: { controller: "hotkey", action: hotkey_action },
          onclick: @onclick,
          class: button_classes,
          **@html_options
        ) do
          button_content
        end
      end

      def render_link
        tag.a(
          href: @href,
          target: @target,
          data: { controller: "hotkey", action: hotkey_action },
          class: button_classes,
          **@html_options
        ) do
          button_content
        end
      end

      def button_content
        safe_join([
          @text,
          " ",
          kbd_elements
        ].flatten.compact)
      end

      def kbd_elements
        return [] if @kbd_text.empty?

        elements = []

        @kbd_text.each_with_index do |key, index|
          elements << tag.kbd(key)
          elements << "+" unless index == @kbd_text.length - 1
        end

        if @kbd_alt_text
          elements << " or "
          @kbd_alt_text.each_with_index do |key, index|
            elements << tag.kbd(key)
            elements << "+" unless index == @kbd_alt_text.length - 1
          end
        end

        elements
      end

      def hotkey_action
        @hotkey.map { |key| "keydown.#{key}@document->hotkey#click" }.join(" ")
      end

      def button_classes
        "flex flex-wrap items-center justify-center gap-1.5 rounded-lg border border-neutral-200 bg-white/90 px-3.5 py-2 text-sm font-medium whitespace-nowrap text-neutral-800 shadow-xs transition-all duration-100 ease-in-out select-none hover:bg-neutral-50 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600 disabled:cursor-not-allowed disabled:opacity-50"
      end
    end
  end
end
