# frozen_string_literal: true

module ArtisansUi
  module TreeView
    class BasicComponent < ViewComponent::Base
      renders_many :folders, lambda { |name:, id:, open: false, **html_options|
        Folder.new(
          name: name,
          id: id,
          open: open,
          **html_options
        )
      }

      def initialize(animate: true, **html_options)
        @animate = animate
        @html_options = html_options
        @html_options[:data] ||= {}
        @html_options[:data][:controller] = "tree-view"
        @html_options[:data][:"tree-view-animate-value"] = animate
        @html_options[:class] = class_names(
          "w-full",
          html_options[:class]
        )
      end

      attr_reader :animate, :html_options

      class Folder < ViewComponent::Base
        renders_many :items, lambda { |name:, type: :file, id: nil, open: false, &block|
          if type == :folder
            Folder.new(name: name, id: id, open: open, &block)
          else
            File.new(name: name)
          end
        }

        def initialize(name:, id:, open: false, **html_options)
          @name = name
          @id = id
          @open = open
          @html_options = html_options
        end

        attr_reader :name, :id, :open, :html_options

        def folder_icon_svg
          if open
            <<~SVG.html_safe
              <g fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" stroke="currentColor">
                <path d="M5,14.75h-.75c-1.105,0-2-.895-2-2V4.75c0-1.105,.895-2,2-2h1.825c.587,0,1.144,.258,1.524,.705l1.524,1.795h4.626c1.105,0,2,.895,2,2v1"></path>
                <path d="M16.148,13.27l.843-3.13c.257-.953-.461-1.89-1.448-1.89H6.15c-.678,0-1.272,.455-1.448,1.11l-.942,3.5c-.257,.953,.461,1.89,1.448,1.89H14.217c.904,0,1.696-.607,1.931-1.48Z"></path>
              </g>
            SVG
          else
            <<~SVG.html_safe
              <g fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" stroke="currentColor">
                <path d="M13.75,5.25c1.105,0,2,.895,2,2v5.5c0,1.105-.895,2-2,2H4.25c-1.105,0-2-.895-2-2V4.75c0-1.105,.895-2,2-2h1.825c.587,0,1.144,.258,1.524,.705l1.524,1.795h4.626Z"></path>
              </g>
            SVG
          end
        end

        def file_icon_svg
          <<~SVG.html_safe
            <g fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" stroke="currentColor">
              <path d="M15.16,6.25h-3.41c-.552,0-1-.448-1-1V1.852"></path>
              <path d="M2.75,14.25V3.75c0-1.105,.895-2,2-2h5.586c.265,0,.52,.105,.707,.293l3.914,3.914c.188,.188,.293,.442,.293,.707v7.586c0,1.105-.895,2-2,2H4.75c-1.105,0-2-.895-2-2Z"></path>
            </g>
          SVG
        end
      end

      class File < ViewComponent::Base
        def initialize(name:)
          @name = name
        end

        attr_reader :name

        def file_icon_svg
          <<~SVG.html_safe
            <g fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" stroke="currentColor">
              <path d="M15.16,6.25h-3.41c-.552,0-1-.448-1-1V1.852"></path>
              <path d="M2.75,14.25V3.75c0-1.105,.895-2,2-2h5.586c.265,0,.52,.105,.707,.293l3.914,3.914c.188,.188,.293,.442,.293,.707v7.586c0,1.105-.895,2-2,2H4.75c-1.105,0-2-.895-2-2Z"></path>
            </g>
          SVG
        end
      end
    end
  end
end
