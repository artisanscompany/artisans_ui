# frozen_string_literal: true

module ArtisansUi
  module Form
    # Form fields with labels and inputs
    # Exact RailsBlocks implementation - comprehensive form styling
    # Note: Requires custom CSS classes (form-control, label, etc.)
    #
    # @example
    #   <%= render ArtisansUi::Form::FormFieldsComponent.new %>
    class FormFieldsComponent < ApplicationViewComponent
      def call
        tag.form(action: "#", class: "w-full max-w-sm") do
          safe_join([
            render_text_field("name", "Name", "Enter your name..."),
            render_email_field,
            render_url_field,
            render_phone_field,
            render_password_field,
            render_date_field,
            render_time_field,
            render_disabled_field,
            render_readonly_field,
            render_error_field,
            render_file_upload,
            render_single_select,
            render_multiple_select,
            render_disabled_select,
            render_checkboxes,
            render_switches,
            render_radios
          ])
        end
      end

      private

      def render_text_field(name, label_text, placeholder)
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label(label_text, for: name),
            tag.input(
              type: "text",
              name: name,
              class: "form-control",
              placeholder: placeholder
            )
          ])
        end
      end

      def render_email_field
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("Email", for: "email"),
            tag.input(
              type: "email",
              name: "email",
              placeholder: "Enter your email...",
              class: "form-control"
            )
          ])
        end
      end

      def render_url_field
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("Website", for: "website"),
            tag.input(
              type: "url",
              name: "website",
              placeholder: "Enter your website...",
              class: "form-control"
            )
          ])
        end
      end

      def render_phone_field
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("Phone", for: "phone"),
            tag.input(
              type: "tel",
              name: "phone",
              placeholder: "Enter your phone...",
              class: "form-control"
            )
          ])
        end
      end

      def render_password_field
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("Password", for: "password"),
            tag.input(
              type: "password",
              name: "password",
              placeholder: "Enter your password...",
              class: "form-control"
            )
          ])
        end
      end

      def render_date_field
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("Date", for: "date"),
            tag.input(
              type: "date",
              name: "date",
              placeholder: "Enter your date...",
              class: "form-control"
            )
          ])
        end
      end

      def render_time_field
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("Time", for: "time"),
            tag.input(
              type: "time",
              name: "time",
              placeholder: "Enter your time...",
              class: "form-control"
            )
          ])
        end
      end

      def render_disabled_field
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("Disabled", for: "name"),
            tag.input(
              type: "text",
              name: "name",
              class: "form-control",
              placeholder: "Michael Scott",
              disabled: true
            )
          ])
        end
      end

      def render_readonly_field
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("Readonly", for: "name"),
            tag.input(
              type: "text",
              name: "name",
              class: "form-control",
              placeholder: "Jim Halpert",
              readonly: true
            )
          ])
        end
      end

      def render_error_field
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("Website", for: "website"),
            tag.input(
              type: "url",
              name: "website",
              class: "form-control error",
              value: "My Website"
            ),
            tag.p(
              "Please enter a valid URL",
              class: "mt-1 text-sm leading-normal text-red-500 italic"
            )
          ])
        end
      end

      def render_file_upload
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("File upload", for: "file"),
            tag.div(class: "relative") do
              safe_join([
                tag.input(
                  type: "file",
                  id: "file-upload",
                  class: "sr-only",
                  onchange: "updateFileName(this)"
                ),
                tag.label(
                  for: "file-upload",
                  class: "flex items-center gap-2 cursor-pointer rounded-lg border-2 border-dashed border-neutral-300 bg-neutral-50 px-4 py-2 text-sm font-medium text-neutral-700 transition-colors hover:border-neutral-400 hover:bg-neutral-100 focus-within:ring-2 focus-within:ring-neutral-600 focus-within:ring-offset-2"
                ) do
                  safe_join([
                    tag.span("Choose File", class: "shrink-0"),
                    tag.span(
                      "No file chosen",
                      id: "file-name",
                      class: "truncate text-neutral-500 text-xs"
                    )
                  ])
                end,
                render_file_upload_script
              ])
            end
          ])
        end
      end

      def render_file_upload_script
        tag.script do
          raw <<~JS
            function updateFileName(input) {
              const fileName = input.files[0]?.name || 'No file chosen';
              document.getElementById('file-name').textContent = fileName;
            }
          JS
        end
      end

      def render_single_select
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("Favorite Game", for: "favorite-game"),
            tag.select(name: "favorite-game", id: "favorite-game") do
              safe_join([
                tag.option("Choose a game", value: "", selected: true),
                tag.option("Minecraft", value: "minecraft"),
                tag.option("Fortnite", value: "fortnite"),
                tag.option("Roblox", value: "roblox"),
                tag.option("League of Legends", value: "league-of-legends"),
                tag.option("Valorant", value: "valorant"),
                tag.option("Apex Legends", value: "apex-legends"),
                tag.option("Overwatch", value: "overwatch"),
                tag.option("Call of Duty", value: "call-of-duty"),
                tag.option("Battlefield", value: "battlefield"),
                tag.option("Other", value: "other")
              ])
            end
          ])
        end
      end

      def render_multiple_select
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("Favorite Games", for: "favorite-games"),
            tag.select(name: "favorite-games", id: "favorite-games", class: "space-y-1", multiple: true) do
              safe_join([
                tag.option(
                  "Choose games",
                  value: "",
                  disabled: true,
                  class: "cursor-not-allowed border-b !rounded-b-none border-neutral-200"
                ),
                tag.option("Minecraft", value: "minecraft"),
                tag.option("Fortnite", value: "fortnite"),
                tag.option("Roblox", value: "roblox"),
                tag.option("League of Legends", value: "league-of-legends"),
                tag.option("Valorant", value: "valorant"),
                tag.option("Apex Legends", value: "apex-legends"),
                tag.option("Overwatch", value: "overwatch"),
                tag.option("Call of Duty", value: "call-of-duty"),
                tag.option("Battlefield", value: "battlefield"),
                tag.option("Other", value: "other")
              ])
            end
          ])
        end
      end

      def render_disabled_select
        tag.div(class: "mb-6 relative gap-y-1.5") do
          safe_join([
            tag.label("Industry (Disabled)", for: "industry_disabled"),
            tag.select(name: "industry_disabled", id: "industry_disabled", disabled: true) do
              safe_join([
                tag.option("Minecraft", value: "minecraft"),
                tag.option("Fortnite", value: "fortnite"),
                tag.option("Roblox", value: "roblox"),
                tag.option("League of Legends", value: "league-of-legends"),
                tag.option("Valorant", value: "valorant"),
                tag.option("Apex Legends", value: "apex-legends"),
                tag.option("Overwatch", value: "overwatch")
              ])
            end
          ])
        end
      end

      def render_checkboxes
        tag.div(class: "mb-6 relative gap-y-1.5 flex flex-col gap-1") do
          safe_join([
            render_checkbox("checked-checkbox", "Styled checkbox", checked: true),
            render_checkbox("checkbox", "Styled checkbox"),
            render_checkbox("disabled-checkbox", "Disabled checkbox", disabled: true)
          ])
        end
      end

      def render_checkbox(id, label_text, checked: false, disabled: false)
        tag.div(class: "flex items-center gap-x-3") do
          safe_join([
            tag.input(
              type: "checkbox",
              id: id,
              checked: checked,
              disabled: disabled
            ),
            tag.label(label_text, for: id, class: "inline-block")
          ])
        end
      end

      def render_switches
        tag.div(class: "flex flex-col gap-4 mb-6") do
          safe_join([
            render_switch_basic,
            render_switch_with_icons
          ])
        end
      end

      def render_switch_basic
        tag.label(class: "group flex items-center gap-x-3 cursor-pointer justify-between w-full") do
          safe_join([
            tag.span("Tailwind Switch", class: "mr-2 text-sm font-medium flex items-center"),
            render_switch_control("tailwind_switch")
          ])
        end
      end

      def render_switch_with_icons
        tag.label(class: "group flex items-center cursor-pointer justify-between w-full") do
          safe_join([
            tag.span("Tailwind Switch with icons", class: "mr-2 text-sm font-medium flex items-center"),
            render_switch_control_with_icons("tailwind_switch_icons")
          ])
        end
      end

      def render_switch_control(name)
        tag.div(class: "relative") do
          safe_join([
            tag.input(type: "checkbox", class: "sr-only peer", name: name, id: name),
            tag.div(
              class: "w-10 h-6 bg-neutral-200 border border-black/10 rounded-full transition-all duration-150 ease-in-out cursor-pointer group-hover:bg-[#dcdcdb] peer-checked:bg-[#404040] peer-checked:group-hover:bg-neutral-600 peer-checked:border-white/10 peer-focus-visible:outline-2 peer-focus-visible:outline-offset-2 peer-focus-visible:outline-neutral-600"
            ),
            tag.div(
              class: "absolute top-[3px] left-[3px] w-[18px] h-[18px] bg-white rounded-full shadow-sm transition-all duration-150 ease-in-out peer-checked:translate-x-4 flex items-center justify-center"
            )
          ])
        end
      end

      def render_switch_control_with_icons(name)
        tag.div(class: "relative") do
          safe_join([
            tag.input(type: "checkbox", class: "sr-only peer", name: name, id: name),
            tag.div(
              class: "w-10 h-6 bg-neutral-200 border border-black/10 rounded-full transition-all duration-150 ease-in-out cursor-pointer group-hover:bg-[#dcdcdb] peer-checked:bg-[#404040] peer-checked:group-hover:bg-neutral-600 peer-checked:border-white/10 peer-focus-visible:outline-2 peer-focus-visible:outline-offset-2 peer-focus-visible:outline-neutral-600"
            ),
            tag.div(
              class: "absolute top-[3px] left-[3px] w-[18px] h-[18px] bg-white rounded-full shadow-sm transition-all duration-150 ease-in-out peer-checked:translate-x-4 flex items-center justify-center"
            ) do
              safe_join([
                render_x_icon,
                render_checkmark_icon
              ])
            end
          ])
        end
      end

      def render_x_icon
        tag.svg(
          class: "w-3 h-3 text-neutral-400 transition-all duration-150 ease-in-out group-has-[:checked]:opacity-0",
          fill: "none",
          viewBox: "0 0 12 12",
          xmlns: "http://www.w3.org/2000/svg"
        ) do
          tag.path(
            d: "M4 8l2-2m0 0l2-2M6 6L4 4m2 2l2 2",
            stroke: "currentColor",
            stroke_width: "2",
            stroke_linecap: "round",
            stroke_linejoin: "round"
          )
        end
      end

      def render_checkmark_icon
        tag.svg(
          class: "absolute w-3 h-3 text-neutral-700 transition-all duration-150 ease-in-out opacity-0 group-has-[:checked]:opacity-100",
          fill: "currentColor",
          viewBox: "0 0 12 12",
          xmlns: "http://www.w3.org/2000/svg"
        ) do
          tag.path(
            d: "M3.707 5.293a1 1 0 00-1.414 1.414l1.414-1.414zM5 8l-.707.707a1 1 0 001.414 0L5 8zm4.707-3.293a1 1 0 00-1.414-1.414l1.414 1.414zm-7.414 2l2 2 1.414-1.414-2-2-1.414 1.414zm3.414 2l4-4-1.414-1.414-4 4 1.414 1.414z",
            fill: "currentColor"
          )
        end
      end

      def render_radios
        tag.div(class: "mb-6 relative gap-y-1.5 flex flex-col gap-1") do
          safe_join([
            render_radio("checked-radio", "Styled radio", checked: true),
            render_radio("radio", "Styled radio"),
            render_radio("disabled-radio", "Disabled radio", disabled: true)
          ])
        end
      end

      def render_radio(id, label_text, checked: false, disabled: false)
        tag.div(class: "flex items-center gap-x-3") do
          safe_join([
            tag.input(
              name: "radio",
              type: "radio",
              id: id,
              checked: checked,
              disabled: disabled
            ),
            tag.label(label_text, for: id, class: "inline-block")
          ])
        end
      end
    end
  end
end
