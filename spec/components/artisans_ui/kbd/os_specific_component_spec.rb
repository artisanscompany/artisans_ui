# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Kbd::OsSpecificComponent, type: :component do
  it "renders with os-detect controller" do
    render_inline(described_class.new(
      label: "Save:",
      mac_keys: ["⌘", "S"],
      other_keys: ["Ctrl", "S"]
    ))
    expect(rendered_content).to include('data-controller="os-detect"')
  end

  it "renders label text" do
    render_inline(described_class.new(
      label: "Save document:",
      mac_keys: ["⌘", "S"],
      other_keys: ["Ctrl", "S"]
    ))
    expect(rendered_content).to include("Save document:")
  end

  it "renders mac target keys" do
    render_inline(described_class.new(
      label: "Save:",
      mac_keys: ["⌘", "S"],
      other_keys: ["Ctrl", "S"]
    ))
    expect(rendered_content).to include('data-os-detect-target="mac"')
    expect(rendered_content).to include("<kbd>⌘</kbd>")
    expect(rendered_content).to include("<kbd>S</kbd>")
  end

  it "renders non-mac target keys" do
    render_inline(described_class.new(
      label: "Save:",
      mac_keys: ["⌘", "S"],
      other_keys: ["Ctrl", "S"]
    ))
    expect(rendered_content).to include('data-os-detect-target="nonMac"')
    expect(rendered_content).to include("<kbd>Ctrl</kbd>")
  end

  it "hides both targets initially" do
    render_inline(described_class.new(
      label: "Save:",
      mac_keys: ["⌘", "S"],
      other_keys: ["Ctrl", "S"]
    ))
    expect(rendered_content).to include("hidden")
  end

  it "renders multiple modifier keys for mac" do
    render_inline(described_class.new(
      label: "Force quit:",
      mac_keys: ["⌘", "⌥", "Q"],
      other_keys: ["Ctrl", "Alt", "Q"]
    ))
    expect(rendered_content).to include("<kbd>⌘</kbd>")
    expect(rendered_content).to include("<kbd>⌥</kbd>")
    expect(rendered_content).to include("<kbd>Q</kbd>")
  end

  it "renders multiple modifier keys for non-mac" do
    render_inline(described_class.new(
      label: "Force quit:",
      mac_keys: ["⌘", "⌥", "Q"],
      other_keys: ["Ctrl", "Alt", "Q"]
    ))
    expect(rendered_content).to include("<kbd>Ctrl</kbd>")
    expect(rendered_content).to include("<kbd>Alt</kbd>")
  end

  it "includes plus signs between keys" do
    render_inline(described_class.new(
      label: "Save:",
      mac_keys: ["⌘", "S"],
      other_keys: ["Ctrl", "S"]
    ))
    expect(rendered_content).to include("+")
  end

  context "interactive mode" do
    it "renders as button when interactive" do
      render_inline(described_class.new(
        label: "Open command palette",
        mac_keys: ["⌘", "Shift", "O"],
        other_keys: ["Ctrl", "Shift", "O"],
        interactive: true,
        hotkey: ["meta+shift+o", "ctrl+shift+o"]
      ))
      expect(rendered_content).to include("<button")
    end

    it "includes hotkey controller when interactive" do
      render_inline(described_class.new(
        label: "Open command palette",
        mac_keys: ["⌘", "Shift", "O"],
        other_keys: ["Ctrl", "Shift", "O"],
        interactive: true,
        hotkey: ["meta+shift+o", "ctrl+shift+o"]
      ))
      expect(rendered_content).to include("hotkey")
    end

    it "includes tooltip controller when interactive" do
      render_inline(described_class.new(
        label: "Open command palette",
        mac_keys: ["⌘", "Shift", "O"],
        other_keys: ["Ctrl", "Shift", "O"],
        interactive: true,
        hotkey: ["meta+shift+o", "ctrl+shift+o"]
      ))
      expect(rendered_content).to include("tooltip")
    end

    it "includes hotkey actions" do
      render_inline(described_class.new(
        label: "Open command palette",
        mac_keys: ["⌘", "Shift", "O"],
        other_keys: ["Ctrl", "Shift", "O"],
        interactive: true,
        hotkey: ["meta+shift+o", "ctrl+shift+o"]
      ))
      expect(rendered_content).to include("keydown.meta+shift+o@document")
      expect(rendered_content).to include("keydown.ctrl+shift+o@document")
      expect(rendered_content).to include("hotkey#click")
    end

    it "includes onclick handler" do
      render_inline(described_class.new(
        label: "Open command palette",
        mac_keys: ["⌘", "Shift", "O"],
        other_keys: ["Ctrl", "Shift", "O"],
        interactive: true,
        hotkey: ["meta+shift+o", "ctrl+shift+o"],
        onclick: "alert('Opened!')"
      ))
      expect(rendered_content).to include("onclick=")
      expect(rendered_content).to include("alert(")
    end

    it "has button styling when interactive" do
      render_inline(described_class.new(
        label: "Open command palette",
        mac_keys: ["⌘", "Shift", "O"],
        other_keys: ["Ctrl", "Shift", "O"],
        interactive: true,
        hotkey: ["meta+shift+o", "ctrl+shift+o"]
      ))
      expect(rendered_content).to include("rounded-lg")
      expect(rendered_content).to include("border-neutral-200")
    end
  end

  context "static mode" do
    it "renders as div when not interactive" do
      render_inline(described_class.new(
        label: "Save:",
        mac_keys: ["⌘", "S"],
        other_keys: ["Ctrl", "S"]
      ))
      expect(rendered_content).to include("<div")
      expect(rendered_content).to include('data-controller="os-detect"')
      expect(rendered_content).not_to include("<button")
    end

    it "has text styling classes" do
      render_inline(described_class.new(
        label: "Save:",
        mac_keys: ["⌘", "S"],
        other_keys: ["Ctrl", "S"]
      ))
      expect(rendered_content).to include("text-neutral-600")
      expect(rendered_content).to include("dark:text-neutral-400")
    end
  end

  it "accepts custom HTML options" do
    render_inline(described_class.new(
      label: "Save:",
      mac_keys: ["⌘", "S"],
      other_keys: ["Ctrl", "S"],
      class: "custom-class"
    ))
    expect(rendered_content).to include("custom-class")
  end
end
