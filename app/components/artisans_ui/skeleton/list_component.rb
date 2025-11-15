# frozen_string_literal: true

module ArtisansUi
  module Skeleton
    class ListComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.div(class: "animate-pulse max-w-md space-y-4", **@html_options) do
          safe_join(
            4.times.map do
              tag.div(class: "flex items-center space-x-4") do
                safe_join([
                  tag.div(class: "rounded-full bg-neutral-200 dark:bg-neutral-700 h-12 w-12"),
                  tag.div(class: "flex-1 min-w-0 space-y-2") do
                    safe_join([
                      tag.div(class: "h-4 bg-neutral-200 dark:bg-neutral-700 rounded w-3/4"),
                      tag.div(class: "h-3 bg-neutral-200 dark:bg-neutral-700 rounded w-1/2")
                    ])
                  end,
                  tag.div(class: "h-6 w-6 bg-neutral-200 dark:bg-neutral-700 rounded")
                ])
              end
            end
          )
        end
      end
    end
  end
end
