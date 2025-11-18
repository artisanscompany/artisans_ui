# frozen_string_literal: true

module ArtisansUi
  module Kbd
    # OS-specific keyboard shortcut display that shows different keys based on user's platform
    #
    # @example Save shortcut (Cmd+S on Mac, Ctrl+S on Windows/Linux)
    #   <%= render ArtisansUi::Kbd::OsSpecificComponent.new(
    #     label: "Save document:",
    #     mac_keys: ["⌘", "S"],
    #     other_keys: ["Ctrl", "S"]
    #   ) %>
    #
    # @example Copy shortcut with multiple modifiers
    #   <%= render ArtisansUi::Kbd::OsSpecificComponent.new(
    #     label: "Force quit:",
    #     mac_keys: ["⌘", "⌥", "Q"],
    #     other_keys: ["Ctrl", "Alt", "Q"]
    #   ) %>
    #
    # @example Interactive button with OS-specific hotkey
    #   <%= render ArtisansUi::Kbd::OsSpecificComponent.new(
    #     label: "Open command palette",
    #     mac_keys: ["⌘", "Shift", "O"],
    #     other_keys: ["Ctrl", "Shift", "O"],
    #     interactive: true,
    #     hotkey: ["meta+shift+o", "ctrl+shift+o"],
    #     onclick: "alert('Command palette opened!')"
    #   ) %>
    class OsSpecificComponent < ApplicationViewComponent
      def initialize(label:, mac_keys:, other_keys:, interactive: false, hotkey: nil, onclick: nil, **html_options)
        @label = label
        @mac_keys = mac_keys
        @other_keys = other_keys
        @interactive = interactive
        @hotkey = Array(hotkey) if hotkey
        @onclick = onclick
        @html_options = html_options
      end

      def call
        if @interactive
          render_interactive_button
        else
          render_static_display
        end
      end

      private

      def render_static_display
        tag.div(
          data: { controller: "os-detect" },
          class: "flex items-center gap-2 text-sm text-neutral-600",
          **@html_options
        ) do
          safe_join([
            tag.span(@label),
            kbd_group
          ])
        end
      end

      def render_interactive_button
        tag.button(
          type: "button",
          data: {
            controller: "tooltip hotkey os-detect",
            tooltip_content: "Action performed!",
            tooltip_placement_value: "top",
            tooltip_trigger_value: "focus",
            action: @hotkey ? @hotkey.map { |key| "keydown.#{key}@document->hotkey#click" }.join(" ") : nil
          },
          onclick: @onclick,
          class: button_classes,
          **@html_options
        ) do
          safe_join([
            @label,
            " with ",
            kbd_group
          ])
        end
      end

      def kbd_group
        tag.div(class: "flex items-center gap-1") do
          safe_join([
            mac_kbd_elements,
            other_kbd_elements
          ])
        end
      end

      def mac_kbd_elements
        tag.div(
          data: { os_detect_target: "mac" },
          class: "hidden flex items-center gap-1"
        ) do
          safe_join(
            @mac_keys.map.with_index do |key, index|
              [
                tag.kbd(key),
                (index < @mac_keys.length - 1 ? tag.span("+") : nil)
              ]
            end.flatten.compact
          )
        end
      end

      def other_kbd_elements
        tag.div(
          data: { os_detect_target: "nonMac" },
          class: "hidden flex items-center gap-1"
        ) do
          safe_join(
            @other_keys.map.with_index do |key, index|
              [
                tag.kbd(key),
                (index < @other_keys.length - 1 ? tag.span("+") : nil)
              ]
            end.flatten.compact
          )
        end
      end

      def button_classes
        "flex flex-wrap items-center justify-center gap-1.5 rounded-lg border border-neutral-200 bg-white/90 px-3.5 py-2 text-sm font-medium whitespace-nowrap text-neutral-800 shadow-xs transition-all duration-100 ease-in-out select-none hover:bg-neutral-50 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600 disabled:cursor-not-allowed disabled:opacity-50"
      end
    end
  end
end
