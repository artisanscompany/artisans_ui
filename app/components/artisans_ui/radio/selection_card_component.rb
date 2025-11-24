# frozen_string_literal: true

module ArtisansUi
  module Radio
    class SelectionCardComponent < ApplicationViewComponent
      def initialize(name:, items:, legend: nil, **html_options)
        @name = name
        @items = items
        @legend = legend
        @html_options = html_options
      end

      def call
        tag.fieldset(class: "flex flex-col gap-4 #{@html_options[:class]}") do
          safe_join([
            (@legend ? tag.legend(@legend, class: "text-sm font-semibold mb-2") : nil),
            safe_join(@items.map { |item| card_radio(item) })
          ].compact)
        end
      end

      private

      def card_radio(item)
        input_id = "#{@name}_#{item[:value]}"
        checked = item[:checked]
        popular = item[:popular]

        classes = [
          "relative flex items-start gap-4 rounded-xl border p-4 cursor-pointer transition-all",
          "hover:bg-neutral-50",
          "has-[:checked]:ring-2 has-[:checked]:ring-neutral-900 has-[:checked]:border-transparent",
          "border-neutral-200"
        ]
        
        classes << "ring-1 ring-yellow-500 bg-yellow-50/30" if popular

        tag.label(
          for: input_id,
          class: classes.join(" ")
        ) do
          safe_join([
            tag.input(
              type: "radio",
              id: input_id,
              name: @name,
              value: item[:value],
              checked: checked || nil,
              class: "mt-1 accent-neutral-900"
            ),
            tag.div(class: "flex-1") do
              safe_join([
                tag.div(class: "flex items-center justify-between") do
                  safe_join([
                    tag.div(class: "font-semibold text-neutral-900") { item[:title] },
                    (item[:price] ? tag.div(class: "text-sm font-medium text-neutral-700") { item[:price] } : nil)
                  ].compact)
                end,
                (item[:description] ? tag.p(item[:description], class: "text-sm text-neutral-500 mt-1") : nil),
                (popular ? tag.span("POPULAR", class: "absolute -top-2 right-4 bg-yellow-500 text-white text-[10px] font-bold px-2 py-0.5 rounded-full tracking-wide") : nil),
                (item[:badge] ? tag.span(item[:badge], class: "absolute -top-2 right-#{popular ? '20' : '4'} bg-green-100 text-green-800 text-[10px] font-bold px-2 py-0.5 rounded-full") : nil)
              ].compact)
            end
          ])
        end
      end
    end
  end
end
