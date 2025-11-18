# frozen_string_literal: true

module ArtisansUi
  module Skeleton
    class FormComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.div(class: "animate-pulse max-w-md space-y-6", **@html_options) do
          safe_join([
            tag.div(class: "space-y-2") do
              safe_join([
                tag.div(class: "h-4 bg-neutral-200 rounded w-20"),
                tag.div(class: "h-10 bg-neutral-200 rounded w-full")
              ])
            end,
            tag.div(class: "space-y-2") do
              safe_join([
                tag.div(class: "h-4 bg-neutral-200 rounded w-24"),
                tag.div(class: "h-10 bg-neutral-200 rounded w-full")
              ])
            end,
            tag.div(class: "space-y-2") do
              safe_join([
                tag.div(class: "h-4 bg-neutral-200 rounded w-32"),
                tag.div(class: "h-24 bg-neutral-200 rounded w-full")
              ])
            end,
            tag.div(class: "flex items-center space-x-2") do
              safe_join([
                tag.div(class: "h-4 w-4 bg-neutral-200 rounded"),
                tag.div(class: "h-4 bg-neutral-200 rounded w-32")
              ])
            end,
            tag.div(class: "flex space-x-4") do
              safe_join([
                tag.div(class: "h-10 bg-neutral-200 rounded w-24"),
                tag.div(class: "h-10 bg-neutral-200 rounded w-24")
              ])
            end
          ])
        end
      end
    end
  end
end
