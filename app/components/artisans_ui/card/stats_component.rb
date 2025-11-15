# frozen_string_literal: true

module ArtisansUi
  module Card
    # Stats Card Component (Variant 8)
    # Card for displaying statistics and metrics
    # Exact RailsBlocks implementation
    #
    # @example
    #   <%= render ArtisansUi::Card::StatsComponent.new(
    #     label: "Total Revenue",
    #     value: "$71,897",
    #     trend: "up",
    #     trend_value: "12.5%",
    #     trend_label: "from last month",
    #     progress_label: "Progress to goal",
    #     progress_value: 72
    #   ) %>
    class StatsComponent < ApplicationViewComponent
      def initialize(
        label:,
        value:,
        trend: nil,
        trend_value: nil,
        trend_label: nil,
        progress_label: nil,
        progress_value: nil,
        **html_options
      )
        @label = label
        @value = value
        @trend = trend
        @trend_value = trend_value
        @trend_label = trend_label
        @progress_label = progress_label
        @progress_value = progress_value
        @html_options = html_options
      end

      def call
        tag.div(
          class: "bg-white dark:bg-neutral-800 border border-black/10 dark:border-white/10 overflow-hidden rounded-xl shadow-xs",
          **@html_options
        ) do
          tag.div(class: "px-4 py-5 sm:p-6") do
            content = []

            content << tag.dt(class: "text-sm font-medium text-neutral-500 dark:text-neutral-400 truncate") { @label }
            content << tag.dd(class: "mt-1 text-3xl font-semibold text-neutral-900 dark:text-white") { @value }

            if @trend
              content << tag.div(class: "mt-4") do
                trend_content = [
                  tag.div(class: "flex items-baseline") do
                    safe_join([
                      tag.span(class: trend_class) do
                        safe_join([
                          trend_icon,
                          @trend_value
                        ])
                      end,
                      @trend_label ? tag.span(class: "ml-2 text-sm text-neutral-500 dark:text-neutral-400") { @trend_label } : nil
                    ].compact)
                  end
                ]

                if @progress_value
                  trend_content << tag.div(class: "mt-3") do
                    tag.div(class: "relative pt-1") do
                      safe_join([
                        tag.div(class: "flex mb-2 items-center justify-between") do
                          safe_join([
                            tag.div do
                              tag.span(class: "text-xs font-semibold inline-block text-neutral-600 dark:text-neutral-400") { @progress_label }
                            end,
                            tag.div(class: "text-right") do
                              tag.span(class: "text-xs font-semibold inline-block text-neutral-600 dark:text-neutral-400") { "#{@progress_value}%" }
                            end
                          ])
                        end,
                        tag.div(class: "overflow-hidden h-2 mb-4 text-xs flex rounded bg-neutral-200 dark:bg-neutral-700") do
                          tag.div(
                            style: "width:#{@progress_value}%",
                            class: "shadow-none flex flex-col text-center whitespace-nowrap text-white justify-center bg-blue-500"
                          )
                        end
                      ])
                    end
                  end
                end

                safe_join(trend_content)
              end
            end

            safe_join(content)
          end
        end
      end

      private

      def trend_class
        base = "text-sm font-medium"
        color = @trend == "up" ? "text-green-600 dark:text-green-400" : "text-red-600 dark:text-red-400"
        "#{base} #{color}"
      end

      def trend_icon
        if @trend == "up"
          tag.svg(class: "self-center inline-block w-4 h-4 mr-1", fill: "currentColor", viewBox: "0 0 20 20") do
            tag.path(
              fill_rule: "evenodd",
              d: "M5.293 9.707a1 1 0 010-1.414l4-4a1 1 0 011.414 0l4 4a1 1 0 01-1.414 1.414L11 7.414V15a1 1 0 11-2 0V7.414L6.707 9.707a1 1 0 01-1.414 0z",
              clip_rule: "evenodd"
            )
          end
        else
          tag.svg(class: "self-center inline-block w-4 h-4 mr-1", fill: "currentColor", viewBox: "0 0 20 20") do
            tag.path(
              fill_rule: "evenodd",
              d: "M14.707 10.293a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 111.414-1.414L9 12.586V5a1 1 0 012 0v7.586l2.293-2.293a1 1 0 011.414 0z",
              clip_rule: "evenodd"
            )
          end
        end
      end
    end
  end
end
