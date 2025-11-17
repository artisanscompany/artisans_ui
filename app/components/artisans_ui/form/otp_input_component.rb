# frozen_string_literal: true

module ArtisansUi
  module Form
    # OTP Input Component
    # Six-digit verification code input with auto-advance and paste support
    # Uses Stimulus for enhanced UX including auto-focus, paste handling, and keyboard navigation
    #
    # @example Basic OTP input
    #   <%= render ArtisansUi::Form::OtpInputComponent.new(
    #     name: :token
    #   ) %>
    #
    # @example With auto-submit
    #   <%= render ArtisansUi::Form::OtpInputComponent.new(
    #     name: :verification_code,
    #     auto_submit: true
    #   ) %>
    #
    # @example With custom styling
    #   <%= render ArtisansUi::Form::OtpInputComponent.new(
    #     name: :otp,
    #     class: "my-custom-wrapper"
    #   ) %>
    class OtpInputComponent < ApplicationViewComponent
      def initialize(name: :token, auto_submit: false, autofocus: true, **html_options)
        @name = name
        @auto_submit = auto_submit
        @autofocus = autofocus
        @html_options = html_options
        @html_options[:data] ||= {}
        @html_options[:data][:controller] = "otp-input"
        @html_options[:data][:"otp-input-auto-submit-value"] = auto_submit
        @html_options[:data][:"otp-input-autofocus-value"] = autofocus
      end

      def call
        tag.div(class: wrapper_classes, **@html_options) do
          safe_join(
            6.times.map do |i|
              digit_input(i)
            end
          )
        end
      end

      private

      def wrapper_classes
        custom_class = @html_options.delete(:class)
        classes = ["inline-flex items-center gap-1.5 sm:gap-2"]
        classes << custom_class if custom_class
        classes.compact.join(" ")
      end

      def digit_input(index)
        tag.input(
          type: "text",
          name: "#{@name}[]",
          data: {
            otp_input_target: "digit",
            action: "input->otp-input#handleInput keydown->otp-input#handleKeydown paste->otp-input#handlePaste",
            index: index
          },
          inputmode: "numeric",
          maxlength: "1",
          autocomplete: (index == 0 ? "one-time-code" : "off"),
          required: true,
          autofocus: (@autofocus && index == 0),
          class: "block w-12 h-12 rounded-lg border border-neutral-200 dark:border-neutral-700 text-center text-lg font-mono bg-white dark:bg-neutral-900 text-neutral-900 dark:text-white placeholder-neutral-500 dark:placeholder-neutral-400 focus:outline-none focus:ring-2 focus:ring-neutral-300 dark:focus:ring-neutral-600 focus:border-transparent transition-colors"
        )
      end
    end
  end
end
