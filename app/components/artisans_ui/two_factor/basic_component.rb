# frozen_string_literal: true

module ArtisansUi
  module TwoFactor
    class BasicComponent < ViewComponent::Base
      def initialize(
        title: "Two-Factor Authentication",
        subtitle: nil,
        submit_text: "Verify code",
        form_url: "#",
        form_method: :post,
        auto_submit: false,
        autofocus: true,
        **html_options
      )
        @title = title
        @subtitle = subtitle
        @submit_text = submit_text
        @form_url = form_url
        @form_method = form_method
        @auto_submit = auto_submit
        @autofocus = autofocus
        @html_options = html_options
        @html_options[:data] ||= {}
        @html_options[:data][:controller] = "two-factor"
        @html_options[:data][:"two-factor-auto-submit-value"] = auto_submit
        @html_options[:data][:"two-factor-autofocus-value"] = autofocus
        @html_options[:class] = class_names(
          "mx-auto w-full max-w-xl py-6",
          html_options[:class]
        )
      end

      attr_reader :title, :subtitle, :submit_text, :form_url, :form_method, :auto_submit, :autofocus, :html_options

      def lock_icon_svg
        <<~SVG.html_safe
          <g fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" stroke="currentColor">
            <line x1="9" y1="11" x2="9" y2="12"></line>
            <path d="M6.25,7.628v-3.128c0-1.519,1.231-2.75,2.75-2.75h0c1.519,0,2.75,1.231,2.75,2.75v3.129"></path>
            <circle cx="9" cy="11.5" r="4.75"></circle>
          </g>
        SVG
      end
    end
  end
end
