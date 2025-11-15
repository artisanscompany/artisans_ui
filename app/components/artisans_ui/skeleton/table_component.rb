# frozen_string_literal: true

module ArtisansUi
  module Skeleton
    class TableComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.div(class: "animate-pulse w-full", **@html_options) do
          safe_join([
            tag.div(class: "bg-neutral-50 dark:bg-neutral-800 p-4 rounded-t-lg") do
              tag.div(class: "flex space-x-4") do
                safe_join([
                  tag.div(class: "h-4 bg-neutral-200 dark:bg-neutral-700 rounded w-1/4"),
                  tag.div(class: "h-4 bg-neutral-200 dark:bg-neutral-700 rounded w-1/4"),
                  tag.div(class: "h-4 bg-neutral-200 dark:bg-neutral-700 rounded w-1/4"),
                  tag.div(class: "h-4 bg-neutral-200 dark:bg-neutral-700 rounded w-1/4")
                ])
              end
            end,
            tag.div(class: "divide-y divide-neutral-200 dark:divide-neutral-700") do
              safe_join(
                5.times.map do
                  tag.div(class: "p-4") do
                    tag.div(class: "flex space-x-4") do
                      safe_join([
                        tag.div(class: "h-4 bg-neutral-200 dark:bg-neutral-700 rounded w-1/4"),
                        tag.div(class: "h-4 bg-neutral-200 dark:bg-neutral-700 rounded w-1/4"),
                        tag.div(class: "h-4 bg-neutral-200 dark:bg-neutral-700 rounded w-1/4"),
                        tag.div(class: "h-4 bg-neutral-200 dark:bg-neutral-700 rounded w-1/4")
                      ])
                    end
                  end
                end
              )
            end
          ])
        end
      end
    end
  end
end
