# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::TreeView::BasicComponent, type: :component do
  it "renders tree view with folders and files" do
    render_inline(described_class.new) do |component|
      component.with_folder(name: "src", id: "tree-content-src", open: true) do |folder|
        folder.with_item(name: "app", type: :folder, id: "tree-content-app", open: true) do |subfolder|
          subfolder.with_item(name: "layout.tsx", type: :file)
          subfolder.with_item(name: "page.tsx", type: :file)
        end
        folder.with_item(name: "lib", type: :folder, id: "tree-content-lib", open: false) do |subfolder|
          subfolder.with_item(name: "utils.ts", type: :file)
        end
      end
    end

    expect(page).to have_text("src")
    expect(page).to have_text("app")
    expect(page).to have_text("layout.tsx")
    expect(page).to have_text("page.tsx")
    expect(page).to have_text("lib")
    expect(page).to have_css('[data-controller="tree-view"]')
    expect(page).to have_css('button[aria-controls="tree-content-src"]')
  end

  it "sets animate value" do
    render_inline(described_class.new(animate: false))
    expect(page).to have_css('[data-tree-view-animate-value="false"]')
  end
end
