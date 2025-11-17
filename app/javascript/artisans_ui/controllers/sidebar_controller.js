import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="sidebar"
export default class extends Controller {
  static targets = ["backdrop", "panel"];

  static values = {
    storageKey: { type: String, default: "sidebarOpen" },
  };

  // Toggle sidebar open/close (mobile only)
  toggle() {
    if (this.isOpen()) {
      this.close();
    } else {
      this.open();
    }
  }

  // Open sidebar (mobile only)
  open() {
    // Show backdrop
    if (this.hasBackdropTarget) {
      this.backdropTarget.classList.remove("hidden");
    }

    // Slide in panel
    if (this.hasPanelTarget) {
      this.panelTarget.classList.remove("-translate-x-full");
      this.panelTarget.classList.add("translate-x-0");
    }
  }

  // Close sidebar (mobile only)
  close() {
    // Hide backdrop
    if (this.hasBackdropTarget) {
      this.backdropTarget.classList.add("hidden");
    }

    // Slide out panel
    if (this.hasPanelTarget) {
      this.panelTarget.classList.remove("translate-x-0");
      this.panelTarget.classList.add("-translate-x-full");
    }
  }

  // Check if sidebar is currently open
  isOpen() {
    if (!this.hasPanelTarget) return false;
    return this.panelTarget.classList.contains("translate-x-0");
  }
}
