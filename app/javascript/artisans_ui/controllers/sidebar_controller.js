import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="sidebar"
export default class extends Controller {
  static targets = [
    "desktopSidebar",
    "mobileSidebar",
    "contentTemplate",
    "sharedContent",
    "desktopContent",
    "mobileBackdrop",
    "mobilePanel",
  ];

  static values = {
    storageKey: { type: String, default: "sidebarOpen" },
  };

  connect() {
    this.boundHandleToggle = this.handleToggle.bind(this);

    // Clone sidebar content for both mobile and desktop
    if (this.hasContentTemplateTarget) {
      // Clone for desktop
      if (this.hasDesktopContentTarget && !this.desktopContentTarget.querySelector("nav")) {
        const desktopClone = this.contentTemplateTarget.content.cloneNode(true);
        this.desktopContentTarget.appendChild(desktopClone);
      }

      // Clone for mobile
      if (this.hasSharedContentTarget && !this.sharedContentTarget.querySelector("nav")) {
        const mobileClone = this.contentTemplateTarget.content.cloneNode(true);
        this.sharedContentTarget.appendChild(mobileClone);

        // Update close button in mobile view to use X icon instead of collapse icon
        const mobileNav = this.sharedContentTarget.querySelector("nav");
        if (mobileNav) {
          const closeButton = mobileNav.querySelector('[data-action*="sidebar#close"]');
          if (closeButton) {
            closeButton.setAttribute("data-action", "click->sidebar#closeMobile");
            closeButton.classList.remove("cursor-w-resize");

            // Replace collapse icon with X icon
            const svg = closeButton.querySelector("svg");
            if (svg) {
              svg.innerHTML = '<g fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" stroke="currentColor"><line x1="13.25" y1="4.75" x2="4.75" y2="13.25"></line><line x1="13.25" y1="13.25" x2="4.75" y2="4.75"></line></g>';
            }
          }
        }
      }
    }

    // Restore saved state for desktop sidebar
    if (this.hasDesktopSidebarTarget) {
      // Disable transitions temporarily to prevent flash on page load
      this.desktopSidebarTarget.style.transition = "none";

      const savedState = localStorage.getItem(this.storageKeyValue);

      if (savedState !== null) {
        this.desktopSidebarTarget.open = savedState === "true";
      } else {
        // Default to open if no saved state
        this.desktopSidebarTarget.open = true;
      }

      // Re-enable transitions after a short delay
      requestAnimationFrame(() => {
        requestAnimationFrame(() => {
          this.desktopSidebarTarget.style.transition = "";
        });
      });

      // Listen for toggle events to save state
      this.desktopSidebarTarget.addEventListener("toggle", this.boundHandleToggle);
    }
  }

  disconnect() {
    if (this.hasDesktopSidebarTarget && this.boundHandleToggle) {
      this.desktopSidebarTarget.removeEventListener("toggle", this.boundHandleToggle);
    }
  }

  handleToggle(event) {
    const isOpen = event.target.open;
    localStorage.setItem(this.storageKeyValue, isOpen.toString());
  }

  // Mobile sidebar methods
  openMobile() {
    if (!this.hasMobileSidebarTarget) return;

    this.mobileSidebarTarget.classList.remove("hidden");

    // Trigger animations after a brief delay
    requestAnimationFrame(() => {
      if (this.hasMobileBackdropTarget) {
        this.mobileBackdropTarget.classList.remove("opacity-0");
        this.mobileBackdropTarget.classList.add("opacity-100");
      }

      if (this.hasMobilePanelTarget) {
        this.mobilePanelTarget.classList.remove("-translate-x-full");
        this.mobilePanelTarget.classList.add("translate-x-0");
      }
    });
  }

  closeMobile() {
    if (!this.hasMobileSidebarTarget) return;

    if (this.hasMobileBackdropTarget) {
      this.mobileBackdropTarget.classList.remove("opacity-100");
      this.mobileBackdropTarget.classList.add("opacity-0");
    }

    if (this.hasMobilePanelTarget) {
      this.mobilePanelTarget.classList.remove("translate-x-0");
      this.mobilePanelTarget.classList.add("-translate-x-full");
    }

    // Wait for animation to complete before hiding
    setTimeout(() => {
      if (this.hasMobileSidebarTarget) {
        this.mobileSidebarTarget.classList.add("hidden");
      }
    }, 300); // Match transition duration
  }

  closeOnBackdrop(event) {
    // Only close if clicking directly on the backdrop (not bubbled from panel)
    if (event.target === event.currentTarget) {
      this.closeMobile();
    }
  }
}
