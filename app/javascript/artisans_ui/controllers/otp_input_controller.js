import { Controller } from "@hotwired/stimulus"

// OTP Input Controller
// Handles 6-digit verification code inputs with auto-advance, paste support, and keyboard navigation
//
// Usage:
//   <div data-controller="otp-input"
//        data-otp-input-auto-submit-value="false"
//        data-otp-input-autofocus-value="true">
//     <input data-otp-input-target="digit" data-action="input->otp-input#handleInput" ...>
//     <input data-otp-input-target="digit" data-action="input->otp-input#handleInput" ...>
//     ...
//   </div>
export default class extends Controller {
  static targets = ["digit"]
  static values = {
    autoSubmit: Boolean,
    autofocus: Boolean
  }

  connect() {
    if (this.autofocusValue && this.digitTargets.length > 0) {
      this.digitTargets[0].focus()
    }
  }

  handleInput(event) {
    const input = event.target
    let value = input.value

    // Only allow digits
    if (!/^\d*$/.test(value)) {
      input.value = value.replace(/\D/g, "")
      return
    }

    // If user somehow pastes multiple digits, take only the first one
    if (value.length > 1) {
      input.value = value[0]
      value = value[0]
    }

    // Move to next input if value entered
    if (value.length === 1) {
      const currentIndex = this.digitTargets.indexOf(input)
      const nextInput = this.digitTargets[currentIndex + 1]

      if (nextInput) {
        nextInput.focus()
        nextInput.select() // Select any existing value for easy replacement
      } else if (this.autoSubmitValue) {
        // Last digit entered and auto-submit enabled
        this.element.closest("form")?.requestSubmit()
      }
    }
  }

  handleKeydown(event) {
    const input = event.target
    const currentIndex = this.digitTargets.indexOf(input)

    // Backspace: clear current and move to previous if empty
    if (event.key === "Backspace") {
      if (!input.value && currentIndex > 0) {
        event.preventDefault()
        const prevInput = this.digitTargets[currentIndex - 1]
        prevInput.focus()
        prevInput.value = ""
      }
    }

    // Arrow Left: move to previous
    if (event.key === "ArrowLeft" && currentIndex > 0) {
      event.preventDefault()
      this.digitTargets[currentIndex - 1].focus()
    }

    // Arrow Right: move to next
    if (event.key === "ArrowRight" && currentIndex < this.digitTargets.length - 1) {
      event.preventDefault()
      this.digitTargets[currentIndex + 1].focus()
    }

    // Home: jump to first input
    if (event.key === "Home") {
      event.preventDefault()
      this.digitTargets[0].focus()
    }

    // End: jump to last input
    if (event.key === "End") {
      event.preventDefault()
      this.digitTargets[this.digitTargets.length - 1].focus()
    }
  }

  handlePaste(event) {
    event.preventDefault()

    // Get pasted text and extract only digits, limited to 6
    const paste = event.clipboardData.getData("text").replace(/\D/g, "").slice(0, 6)

    if (paste.length === 0) return

    // Fill in the digits
    paste.split("").forEach((char, index) => {
      if (this.digitTargets[index]) {
        this.digitTargets[index].value = char
      }
    })

    // Focus the next empty input or the last filled one
    const lastFilledIndex = Math.min(paste.length - 1, this.digitTargets.length - 1)
    const nextEmptyIndex = paste.length < this.digitTargets.length ? paste.length : lastFilledIndex

    this.digitTargets[nextEmptyIndex].focus()

    // Auto-submit if all 6 digits filled and auto-submit enabled
    if (paste.length === 6 && this.autoSubmitValue) {
      this.element.closest("form")?.requestSubmit()
    }
  }
}
