module ArtisansUi
  module Switch
    class BasicComponent < ApplicationViewComponent
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
        tag.div(class: "absolute top-[3px] left-[3px] w-[18px] h-[18px] bg-white rounded-full shadow-sm transition-all duration-150 ease-in-out peer-checked:translate-x-4 flex items-center justify-center")
      end
    end
  end
end
