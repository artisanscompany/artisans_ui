# frozen_string_literal: true

module ArtisansUi
  module Skeleton
    class AvatarComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.div(class: "animate-pulse flex items-center space-x-4 max-w-md", **@html_options) do
          safe_join([
            tag.div(class: "rounded-full bg-neutral-200 dark:bg-neutral-700 h-10 w-10"),
            tag.div(class: "flex-1 space-y-2") do
              safe_join([
                tag.div(class: "h-4 bg-neutral-200 dark:bg-neutral-700 rounded w-3/4"),
                tag.div(class: "h-3 bg-neutral-200 dark:bg-neutral-700 rounded w-1/2")
              ])
            end
          ])
        end
      end
    end
  end
end
