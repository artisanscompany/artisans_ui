module ArtisansUi
  module Switch
    class WithIconComponent < ApplicationViewComponent
      def initialize(name: "switch", id: nil, checked: false, **html_options)
        @name = name
        @id = id || name
        @checked = checked
        @html_options = html_options
      end

      def call
        tag.label(class: "group flex items-center cursor-pointer", **@html_options) do
          tag.div(class: "relative") do
            safe_join([
              checkbox_input,
              background_element,
              toggle_element
            ])
          end
        end
      end

      private

      def checkbox_input
        tag.input(
          type: "checkbox",
          class: "sr-only peer",
          name: @name,
          id: @id,
          checked: @checked
        )
      end

      def background_element
        tag.div(class: "w-10 h-6 bg-neutral-200 border border-black/10 rounded-full transition-all duration-150 ease-in-out cursor-pointer group-hover:bg-[#dcdcdb] peer-checked:bg-[#404040] peer-checked:group-hover:bg-neutral-600 peer-checked:border-white/10 peer-focus-visible:outline-2 peer-focus-visible:outline-offset-2 peer-focus-visible:outline-neutral-600")
      end

      def toggle_element
        tag.div(class: "absolute top-[3px] left-[3px] w-[18px] h-[18px] bg-white rounded-full shadow-sm transition-all duration-150 ease-in-out peer-checked:translate-x-4 flex items-center justify-center") do
          safe_join([
            x_icon,
            checkmark_icon
          ])
        end
      end

      def x_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          fill: "none",
          viewBox: "0 0 20 20",
          stroke: "currentColor",
          class: "size-4 text-neutral-400 transition-opacity duration-150 ease-in-out group-has-[:checked]:opacity-0"
        ) do
          safe_join([
            tag.line(x1: "7", y1: "7", x2: "13", y2: "13", "stroke-width": "2"),
            tag.line(x1: "7", y1: "13", x2: "13", y2: "7", "stroke-width": "2")
          ])
        end
      end

      def checkmark_icon
        tag.svg(
          xmlns: "http://www.w3.org/2000/svg",
          fill: "none",
          viewBox: "0 0 20 20",
          stroke: "currentColor",
          class: "size-4 text-neutral-700 absolute opacity-0 transition-opacity duration-150 ease-in-out group-has-[:checked]:opacity-100"
        ) do
          tag.polyline(points: "6.5 10.5 8.75 13 13.5 7", "stroke-width": "2")
        end
      end
    end
  end
end
