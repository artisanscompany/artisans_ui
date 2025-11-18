# frozen_string_literal: true

module ArtisansUi
  module Skeleton
    class BasicComponent < ApplicationViewComponent
      def initialize(**html_options)
        @html_options = html_options
      end

      def call
        tag.div(class: "animate-pulse max-w-md w-full", **@html_options) do
          safe_join([
            tag.div(class: "h-4 bg-neutral-200 rounded w-full mb-2"),
            tag.div(class: "h-4 bg-neutral-200 rounded w-1/2")
          ])
        end
      end
    end
  end
end
