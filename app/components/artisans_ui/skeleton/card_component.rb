# frozen_string_literal: true

module ArtisansUi
  module Skeleton
    class CardComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.div(class: "animate-pulse border border-neutral-200 dark:border-neutral-700 rounded-xl p-4 shadow-xs max-w-md", **@html_options) do
          safe_join([
            tag.div(class: "h-48 bg-neutral-200 dark:bg-neutral-700 rounded-lg mb-4"),
            tag.div(class: "h-6 bg-neutral-200 dark:bg-neutral-700 rounded w-3/4 mb-4"),
            tag.div(class: "space-y-2 mb-4") do
              safe_join([
                tag.div(class: "h-4 bg-neutral-200 dark:bg-neutral-700 rounded w-full"),
                tag.div(class: "h-4 bg-neutral-200 dark:bg-neutral-700 rounded w-5/6"),
                tag.div(class: "h-4 bg-neutral-200 dark:bg-neutral-700 rounded w-4/6")
              ])
            end,
            tag.div(class: "flex items-center space-x-4 mt-4") do
              safe_join([
                tag.div(class: "h-4 bg-neutral-200 dark:bg-neutral-700 rounded w-20"),
                tag.div(class: "h-4 bg-neutral-200 dark:bg-neutral-700 rounded w-20")
              ])
            end
          ])
        end
      end
    end
  end
end
