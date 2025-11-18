# frozen_string_literal: true

module ArtisansUi
  module Form
    # Switch Field Component
    # Wrapper for switch toggle with label for use in forms
    # Integrates Rails form helpers with ArtisansUI switch component
    #
    # @example Basic usage
    #   <%= render ArtisansUi::Form::SwitchFieldComponent.new(
    #     form: form,
    #     method: :remote_allowed,
    #     label: "Remote work is allowed"
    #   ) %>
    #
    # @example With checked state
    #   <%= render ArtisansUi::Form::SwitchFieldComponent.new(
    #     form: form,
    #     method: :active,
    #     label: "This is active",
    #     checked: true
    #   ) %>
    class SwitchFieldComponent < ApplicationViewComponent
      def initialize(form:, method:, label:, checked: nil, **html_options)
        @form = form
        @method = method
        @label = label
        @checked = checked
        @html_options = html_options
      end

      def call
        tag.div(class: "flex items-center justify-between py-2", **@html_options) do
          safe_join([
            render_label,
            render_switch
          ])
        end
      end

      private

      def render_label
        tag.label(
          @label,
          for: field_id,
          class: "text-sm text-neutral-900 cursor-pointer"
        )
      end

      def render_switch
        tag.label(for: field_id, class: "relative inline-block group cursor-pointer") do
          safe_join([
            checkbox_input,
            background_element,
            toggle_element
          ])
        end
      end

      def checkbox_input
        @form.check_box(
          @method,
          {
            class: "sr-only peer",
            id: field_id,
            checked: checked_value
          }
        )
      end

      def background_element
        tag.div(class: "w-10 h-6 bg-neutral-200 border border-black/10 rounded-full transition-all duration-150 ease-in-out cursor-pointer group-hover:bg-[#dcdcdb] peer-checked:bg-[#404040] peer-checked:group-hover:bg-neutral-600 peer-checked:border-white/10 peer-focus-visible:outline-2 peer-focus-visible:outline-offset-2 peer-focus-visible:outline-neutral-600")
      end

      def toggle_element
        tag.div(class: "absolute top-[3px] left-[3px] w-[18px] h-[18px] bg-white rounded-full shadow-sm transition-all duration-150 ease-in-out peer-checked:translate-x-4 flex items-center justify-center pointer-events-none")
      end

      def field_id
        "#{@form.object_name}_#{@method}"
      end

      def checked_value
        return @checked unless @checked.nil?
        @form.object.send(@method) if @form.object.respond_to?(@method)
      end
    end
  end
end
