# frozen_string_literal: true

module ArtisansUi
  module Autogrow
    # Comment UI with Autogrow Component (Variant 3)
    # Complete comment interface with autogrow textarea, styled like a social media comment box
    # Note: This component requires the Emoji Picker component for full functionality
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Autogrow::CommentComponent.new(
    #     id: "comment-autogrow",
    #     placeholder: "Write a comment...",
    #     parent_user_name: "Sarah Johnson",
    #     parent_user_avatar: "https://images.unsplash.com/photo-1580489944761-15a19d654956?w=100&h=100&fit=crop",
    #     parent_comment: "Just shipped a new feature! Really excited to see what everyone thinks. 🚀",
    #     current_user_avatar: "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=100&h=100&fit=crop"
    #   ) %>
    class CommentComponent < ApplicationViewComponent
      def initialize(id:, placeholder: nil, parent_user_name: nil, parent_user_avatar: nil, parent_comment: nil, current_user_avatar: nil, **html_options)
        @id = id
        @placeholder = placeholder
        @parent_user_name = parent_user_name
        @parent_user_avatar = parent_user_avatar
        @parent_comment = parent_comment
        @current_user_avatar = current_user_avatar
        @html_options = html_options
      end

      def call
        tag.div(class: "w-full max-w-lg") do
          tag.div(class: "bg-white rounded-xl shadow-sm border border-neutral-200 p-4") do
            safe_join([
              render_parent_comment,
              render_comment_form
            ])
          end
        end
      end

      private

      def render_parent_comment
        return unless @parent_user_name && @parent_comment

        tag.div(class: "mb-4 p-3 bg-neutral-50 rounded-lg") do
          tag.div(class: "flex items-start gap-3") do
            safe_join([
              tag.img(
                src: @parent_user_avatar,
                alt: "#{@parent_user_name} avatar",
                class: "size-8 mt-1 rounded-full flex-shrink-0 object-cover"
              ),
              tag.div(class: "flex-1") do
                safe_join([
                  tag.p(@parent_user_name, class: "text-sm font-medium text-neutral-900"),
                  tag.p(@parent_comment, class: "text-sm text-neutral-700 mt-1")
                ])
              end
            ])
          end
        end
      end

      def render_comment_form
        tag.div(class: "flex items-start gap-3") do
          safe_join([
            tag.img(
              src: @current_user_avatar,
              alt: "Your avatar",
              class: "size-8 mt-1 rounded-full flex-shrink-0 object-cover"
            ),
            tag.div(class: "flex-1") do
              safe_join([
                tag.textarea(
                  "",
                  id: @id,
                  rows: 1,
                  class: "form-control min-h-10 max-h-52 resize-none small-scrollbar",
                  placeholder: @placeholder,
                  data: {
                    controller: "artisans-ui--autogrow",
                    action: "input->artisans-ui--autogrow#autogrow"
                  },
                  **@html_options
                ),
                tag.div(class: "mt-2 flex items-center justify-between") do
                  safe_join([
                    render_toolbar_buttons,
                    render_post_button
                  ])
                end
              ])
            end
          ])
        end
      end

      def render_toolbar_buttons
        tag.div(class: "flex items-center gap-1") do
          safe_join([
            render_emoji_button,
            render_attach_button
          ])
        end
      end

      def render_emoji_button
        # Note: This requires the Emoji Picker component
        tag.button(
          type: "button",
          class: "outline-hidden size-8 text-xl shrink-0 flex items-center justify-center rounded-md text-neutral-700 hover:bg-neutral-100 hover:text-neutral-800 focus:outline-hidden disabled:pointer-events-none disabled:opacity-50"
        ) do
          tag.svg(
            xmlns: "http://www.w3.org/2000/svg",
            class: "size-4.5",
            width: "18",
            height: "18",
            viewBox: "0 0 18 18"
          ) do
            tag.g(
              fill: "none",
              "stroke-linecap": "round",
              "stroke-linejoin": "round",
              "stroke-width": "1.5",
              stroke: "currentColor"
            ) do
              safe_join([
                tag.circle(cx: "9", cy: "9", r: "7.25"),
                tag.circle(cx: "6", cy: "8", r: "1", fill: "currentColor", "data-stroke": "none", stroke: "none"),
                tag.circle(cx: "12", cy: "8", r: "1", fill: "currentColor", "data-stroke": "none", stroke: "none"),
                tag.path(d: "M11.897,10.757c-.154-.154-.366-.221-.583-.189h0c-1.532,.239-3.112,.238-4.638-.001-.214-.032-.421,.035-.572,.185-.154,.153-.227,.376-.193,.598,.23,1.511,1.558,2.651,3.089,2.651s2.86-1.141,3.089-2.654c.033-.216-.039-.436-.192-.589Z", fill: "currentColor", "data-stroke": "none", stroke: "none")
              ])
            end
          end
        end
      end

      def render_attach_button
        tag.button(
          type: "button",
          class: "outline-hidden size-8 text-xl shrink-0 flex items-center justify-center rounded-md text-neutral-700 hover:bg-neutral-100 hover:text-neutral-800 focus:outline-hidden disabled:pointer-events-none disabled:opacity-50"
        ) do
          tag.svg(
            xmlns: "http://www.w3.org/2000/svg",
            class: "size-4.5",
            width: "18",
            height: "18",
            viewBox: "0 0 18 18"
          ) do
            tag.g(
              fill: "none",
              "stroke-linecap": "round",
              "stroke-linejoin": "round",
              "stroke-width": "1.5",
              stroke: "currentColor"
            ) do
              safe_join([
                tag.line(x1: "13.75", y1: "1.75", x2: "13.75", y2: "6.75"),
                tag.line(x1: "16.25", y1: "4.25", x2: "11.25", y2: "4.25"),
                tag.path(d: "M5.75,5v6.75c0,.828,.672,1.5,1.5,1.5h0c.828,0,1.5-.672,1.5-1.5V4.75c0-1.657-1.343-3-3-3h0c-1.657,0-3,1.343-3,3v7c0,2.485,2.015,4.5,4.5,4.5h0c2.485,0,4.5-2.015,4.5-4.5v-3")
              ])
            end
          end
        end
      end

      def render_post_button
        tag.button(
          type: "button",
          class: "flex items-center justify-center gap-1.5 rounded-lg border border-neutral-400/30 bg-neutral-800 px-3 py-2 text-sm font-medium whitespace-nowrap text-white shadow-sm transition-all duration-100 ease-in-out select-none hover:bg-neutral-700 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-neutral-600 disabled:cursor-not-allowed disabled:opacity-50"
        ) do
          "Post"
        end
      end
    end
  end
end
