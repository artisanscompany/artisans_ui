import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="artisans-ui--modal"
export default class extends Controller {
  static targets = ["dialog", "backdrop"]
  static values = {
    open: { type: Boolean, default: false },
    closeOnBackdrop: { type: Boolean, default: true },
    closeOnEscape: { type: Boolean, default: true }
  }

  connect() {
    // If modal should be open on connect
    if (this.openValue) {
      this.open()
    }

    // Listen for escape key if enabled
    if (this.closeOnEscapeValue) {
      this.boundHandleEscape = this.handleEscape.bind(this)
      document.addEventListener("keydown", this.boundHandleEscape)
    }
  }

  disconnect() {
    // Clean up event listeners
    if (this.closeOnEscapeValue && this.boundHandleEscape) {
      document.removeEventListener("keydown", this.boundHandleEscape)
    }

    // Restore body scroll
    this.enableBodyScroll()
  }

  open(event) {
    if (event) event.preventDefault()

    // Show modal
    this.element.classList.remove("hidden")
    this.element.setAttribute("aria-hidden", "false")

    // Prevent body scroll
    this.disableBodyScroll()

    // Focus first focusable element or dialog
    requestAnimationFrame(() => {
      this.focusFirstElement()
    })

    // Trigger custom event
    this.dispatch("opened")
  }

  close(event) {
    if (event) event.preventDefault()

    // Hide modal
    this.element.classList.add("hidden")
    this.element.setAttribute("aria-hidden", "true")

    // Restore body scroll
    this.enableBodyScroll()

    // Trigger custom event
    this.dispatch("closed")
  }

  toggle(event) {
    if (event) event.preventDefault()

    if (this.element.classList.contains("hidden")) {
      this.open()
    } else {
      this.close()
    }
  }

  // Close when clicking backdrop
  backdropClick(event) {
    if (!this.closeOnBackdropValue) return

    // Only close if clicking the backdrop itself, not child elements
    if (event.target === event.currentTarget) {
      this.close()
    }
  }

  // Close when pressing Escape
  handleEscape(event) {
    if (event.key === "Escape" && !this.element.classList.contains("hidden")) {
      this.close()
    }
  }

  // Prevent body scroll when modal is open
  disableBodyScroll() {
    const scrollbarWidth = window.innerWidth - document.documentElement.clientWidth
    document.body.style.overflow = "hidden"
    document.body.style.paddingRight = `${scrollbarWidth}px`
  }

  // Restore body scroll when modal is closed
  enableBodyScroll() {
    document.body.style.overflow = ""
    document.body.style.paddingRight = ""
  }

  // Focus management for accessibility
  focusFirstElement() {
    const focusableElements = this.element.querySelectorAll(
      'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'
    )

    if (focusableElements.length > 0) {
      focusableElements[0].focus()
    } else if (this.hasDialogTarget) {
      this.dialogTarget.focus()
    }
  }
}
