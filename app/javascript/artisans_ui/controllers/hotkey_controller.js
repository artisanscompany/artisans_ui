import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    key: String,
    modifier: { type: String, default: "" },
  };

  connect() {
    this.handleKeydown = this.handleKeydown.bind(this);
    document.addEventListener("keydown", this.handleKeydown);
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleKeydown);
  }

  handleKeydown(event) {
    if (!this.keyValue) return;

    const key = event.key.toLowerCase();
    const targetKey = this.keyValue.toLowerCase();

    // Check if the pressed key matches
    if (key !== targetKey) return;

    // Check modifier keys if specified
    const modifier = this.modifierValue.toLowerCase();
    if (modifier) {
      const modifiers = modifier.split("+").map((m) => m.trim());
      const requiresCtrl = modifiers.includes("ctrl") || modifiers.includes("control");
      const requiresMeta = modifiers.includes("meta") || modifiers.includes("cmd") || modifiers.includes("command");
      const requiresAlt = modifiers.includes("alt") || modifiers.includes("option");
      const requiresShift = modifiers.includes("shift");

      if (requiresCtrl && !event.ctrlKey) return;
      if (requiresMeta && !event.metaKey) return;
      if (requiresAlt && !event.altKey) return;
      if (requiresShift && !event.shiftKey) return;

      // If no modifier is required but one is pressed, don't trigger
      if (!requiresCtrl && !requiresMeta && !requiresAlt && !requiresShift) {
        if (event.ctrlKey || event.metaKey || event.altKey || event.shiftKey) return;
      }
    } else {
      // No modifier specified, so don't trigger if any modifier is pressed
      if (event.ctrlKey || event.metaKey || event.altKey || event.shiftKey) return;
    }

    // Trigger the click action
    this.click(event);
  }

  click(event) {
    event.preventDefault();
    this.element.click();
  }
}
