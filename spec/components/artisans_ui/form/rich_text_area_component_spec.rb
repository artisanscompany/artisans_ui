# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Form::RichTextAreaComponent, type: :component do
  let(:form_builder) do
    double("FormBuilder", rich_text_area: "<div class='trix-editor'></div>".html_safe)
  end

  it "renders rich text area with default classes" do
    render_inline(described_class.new(attribute: :content, form: form_builder))

    expect(form_builder).to have_received(:rich_text_area).with(
      :content,
      class: "trix-content block w-full border border-neutral-200 dark:border-neutral-700 rounded-lg bg-white dark:bg-neutral-900 text-neutral-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-neutral-300 dark:focus:ring-neutral-600 focus:border-transparent transition-colors"
    )
  end

  it "renders with placeholder" do
    render_inline(described_class.new(
      attribute: :description,
      form: form_builder,
      placeholder: "Enter description..."
    ))

    expect(form_builder).to have_received(:rich_text_area).with(
      :description,
      hash_including(placeholder: "Enter description...")
    )
  end

  it "merges custom classes with default classes" do
    render_inline(described_class.new(
      attribute: :content,
      form: form_builder,
      class: "min-h-96"
    ))

    expect(form_builder).to have_received(:rich_text_area).with(
      :content,
      hash_including(class: include("trix-content", "min-h-96"))
    )
  end

  it "passes through additional html options" do
    render_inline(described_class.new(
      attribute: :content,
      form: form_builder,
      data: { controller: "editor" },
      id: "custom-editor"
    ))

    expect(form_builder).to have_received(:rich_text_area).with(
      :content,
      hash_including(
        data: { controller: "editor" },
        id: "custom-editor"
      )
    )
  end
end
