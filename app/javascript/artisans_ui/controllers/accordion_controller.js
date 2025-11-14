import { Controller } from "@hotwired/stimulus";

// Accordion controller from RailsBlocks
// Supports multiple variants: basic, with icons, always open, etc.
export default class extends Controller {
  static targets = ["item", "trigger", "content", "icon"];
  static values = {
    allowMultiple: { type: Boolean, default: false }
  };

  connect() {
    // Initialize accordion items
    this.itemTargets.forEach((item, index) => {
      const isOpen = item.dataset.state === "open";
      if (isOpen) {
        this._applyOpenVisuals(index);
      } else {
        this._applyClosedVisuals(index);
      }
    });
  }

  toggle(event) {
    const trigger = event.currentTarget;
    const index = this.triggerTargets.indexOf(trigger);

    if (index === -1) return;

    const item = this.itemTargets[index];
    const isOpen = item.dataset.state === "open";

    if (!this.allowMultipleValue) {
      // Close all other items
      this.itemTargets.forEach((otherItem, otherIndex) => {
        if (otherIndex !== index && otherItem.dataset.state === "open") {
          this._applyClosedVisuals(otherIndex);
        }
      });
    }

    if (isOpen) {
      this._applyClosedVisuals(index);
    } else {
      this._applyOpenVisuals(index);
    }
  }

  _applyOpenVisuals(index) {
    if (!this.itemTargets[index] || !this.triggerTargets[index] || !this.contentTargets[index]) return;

    const item = this.itemTargets[index];
    const trigger = this.triggerTargets[index];
    const content = this.contentTargets[index];
    const icon = this.hasIconTarget && this.iconTargets[index] ? this.iconTargets[index] : null;

    item.dataset.state = "open";
    trigger.setAttribute("aria-expanded", "true");
    trigger.dataset.state = "open";
    content.dataset.state = "open";
    content.removeAttribute("hidden");

    if (icon) {
      const isPlusMinus = icon.querySelector('path[d*="M5 12h14"]');
      const isLeftChevron = icon.classList.contains("-rotate-90");

      if (isPlusMinus) {
        // For plus/minus icons, CSS handles the animation via [data-state=open]
        // Icon rotation is handled by CSS: [&[data-state=open]>svg]:rotate-180
      } else if (isLeftChevron) {
        icon.classList.add("rotate-0");
        icon.classList.remove("-rotate-90");
      } else {
        icon.classList.add("rotate-180");
      }
    }

    content.style.maxHeight = `${content.scrollHeight}px`;
  }

  _applyClosedVisuals(index) {
    if (!this.itemTargets[index] || !this.triggerTargets[index] || !this.contentTargets[index]) return;

    const item = this.itemTargets[index];
    const trigger = this.triggerTargets[index];
    const content = this.contentTargets[index];
    const icon = this.hasIconTarget && this.iconTargets[index] ? this.iconTargets[index] : null;

    item.dataset.state = "closed";
    trigger.setAttribute("aria-expanded", "false");
    trigger.dataset.state = "closed";
    content.dataset.state = "closed";

    if (icon) {
      const isPlusMinus = icon.querySelector('path[d*="M5 12h14"]');
      const isLeftChevron = icon.classList.contains("rotate-0");

      if (isPlusMinus) {
        // CSS handles the icon rotation
      } else if (isLeftChevron) {
        icon.classList.add("-rotate-90");
        icon.classList.remove("rotate-0");
      } else {
        icon.classList.remove("rotate-180");
      }
    }

    content.style.maxHeight = "0px";

    // Hide after transition
    setTimeout(() => {
      if (content.dataset.state === "closed") {
        content.setAttribute("hidden", "");
      }
    }, 300); // Match transition duration
  }
}
