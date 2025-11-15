# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Kbd::ButtonWithHotkeyComponent, type: :component do
  it "renders a button with text" do
    render_inline(described_class.new(text: "Click me", hotkey: "ctrl+b", kbd_text: ["Ctrl", "B"]))
    expect(rendered_content).to include("<button")
    expect(rendered_content).to include("Click me")
  end

  it "includes hotkey controller" do
    render_inline(described_class.new(text: "Click me", hotkey: "ctrl+b", kbd_text: ["Ctrl", "B"]))
    expect(rendered_content).to include('data-controller="hotkey"')
  end

  it "includes hotkey action" do
    render_inline(described_class.new(text: "Click me", hotkey: "ctrl+b", kbd_text: ["Ctrl", "B"]))
    expect(rendered_content).to include('keydown.ctrl+b@document')
    expect(rendered_content).to include('hotkey#click')
  end

  it "renders kbd elements" do
    render_inline(described_class.new(text: "Click me", hotkey: "ctrl+b", kbd_text: ["Ctrl", "B"]))
    expect(rendered_content).to include("<kbd>Ctrl</kbd>")
    expect(rendered_content).to include("<kbd>B</kbd>")
  end

  it "renders multiple hotkeys" do
    render_inline(described_class.new(
      text: "Search",
      hotkey: ["meta+m", "ctrl+m"],
      kbd_text: ["⌘", "M"],
      kbd_alt_text: ["Ctrl", "M"]
    ))
    expect(rendered_content).to include("keydown.meta+m@document")
    expect(rendered_content).to include("keydown.ctrl+m@document")
    expect(rendered_content).to include("hotkey#click")
  end

  it "renders kbd_alt_text when provided" do
    render_inline(described_class.new(
      text: "Search",
      hotkey: ["meta+m", "ctrl+m"],
      kbd_text: ["⌘", "M"],
      kbd_alt_text: ["Ctrl", "M"]
    ))
    expect(rendered_content).to include("<kbd>⌘</kbd>")
    expect(rendered_content).to include("<kbd>Ctrl</kbd>")
    expect(rendered_content).to include(" or ")
  end

  it "renders as link when href provided" do
    render_inline(described_class.new(
      text: "Open Google",
      hotkey: "shift+g",
      kbd_text: ["Shift", "G"],
      href: "https://www.google.com"
    ))
    expect(rendered_content).to include('<a')
    expect(rendered_content).to include('href="https://www.google.com"')
    expect(rendered_content).to include('data-controller="hotkey"')
  end

  it "includes target attribute for links" do
    render_inline(described_class.new(
      text: "Open Google",
      hotkey: "shift+g",
      kbd_text: ["Shift", "G"],
      href: "https://www.google.com",
      target: "_blank"
    ))
    expect(rendered_content).to include('target="_blank"')
  end

  it "includes onclick handler" do
    render_inline(described_class.new(
      text: "Submit",
      hotkey: "ctrl+enter",
      kbd_text: ["Ctrl", "Enter"],
      onclick: "alert('Form submitted!')"
    ))
    expect(rendered_content).to include("onclick=")
    expect(rendered_content).to include("alert(")
  end

  it "has button styling classes" do
    render_inline(described_class.new(text: "Click me", hotkey: "ctrl+b", kbd_text: ["Ctrl", "B"]))
    expect(rendered_content).to include("rounded-lg")
    expect(rendered_content).to include("border-neutral-200")
  end

  it "has dark mode classes" do
    render_inline(described_class.new(text: "Click me", hotkey: "ctrl+b", kbd_text: ["Ctrl", "B"]))
    expect(rendered_content).to include("dark:border-neutral-700")
    expect(rendered_content).to include("dark:bg-neutral-800/50")
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(
      text: "Click me",
      hotkey: "ctrl+b",
      kbd_text: ["Ctrl", "B"],
      class: "custom-class"
    ))
    expect(rendered_content).to include("custom-class")
  end

  it "renders without kbd_text" do
    render_inline(described_class.new(text: "Click me", hotkey: "ctrl+b"))
    expect(rendered_content).to include("Click me")
    expect(rendered_content).not_to include("<kbd>")
  end

  it "handles plus signs between keys" do
    render_inline(described_class.new(text: "Click me", hotkey: "ctrl+b", kbd_text: ["Ctrl", "B"]))
    expect(rendered_content).to include("+")
  end
end
