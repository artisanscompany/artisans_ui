import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="collapsible"
export default class extends Controller {
  static targets = ["content", "collapsedIcon", "expandedIcon"];
  static values = { open: Boolean };

  connect() {
    this.isOpen = this.openValue;
    this.updateDisplay();
  }

  toggle() {
    this.isOpen = !this.isOpen;
    this.updateDisplay();
  }

  updateDisplay() {
    const content = this.contentTarget;
    const collapsedIcon = this.hasCollapsedIconTarget ? this.collapsedIconTarget : null;
    const expandedIcon = this.hasExpandedIconTarget ? this.expandedIconTarget : null;

    if (this.isOpen) {
      // Show content
      content.style.maxHeight = content.scrollHeight + "px";
      content.style.opacity = "1";
      content.setAttribute("data-state", "open");

      // Fade to expanded icon
      if (collapsedIcon) collapsedIcon.style.opacity = "0";
      if (expandedIcon) expandedIcon.style.opacity = "1";

      this.element.setAttribute("data-state", "open");
    } else {
      // Hide content
      content.style.maxHeight = "0";
      content.style.opacity = "0";
      content.setAttribute("data-state", "closed");

      // Fade to collapsed icon
      if (collapsedIcon) collapsedIcon.style.opacity = "1";
      if (expandedIcon) expandedIcon.style.opacity = "0";

      this.element.setAttribute("data-state", "closed");
    }
  }
}
