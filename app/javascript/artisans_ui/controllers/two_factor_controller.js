import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["num1", "num2", "num3", "num4", "num5", "num6", "form", "submitButton"];
  static values = {
    autoSubmit: { type: Boolean, default: false }, // Whether to automatically submit the form
    autofocus: { type: Boolean, default: true }, // Whether to autofocus the first input
  };

  connect() {
    // Set autofocus on the first input if it's a target and autofocus is enabled
    if (this.autofocusValue && this.hasNum1Target) {
      this.num1Target.focus();
    }

    // Add focus event listeners to all input targets
    this._getInputTargets().forEach((input) => {
      input.addEventListener("focus", this.handleFocus.bind(this));
    });
  }

  disconnect() {
    // Clean up event listeners
    this._getInputTargets().forEach((input) => {
      input.removeEventListener("focus", this.handleFocus.bind(this));
    });
  }

  handleFocus(event) {
    const input = event.target;
    // Move cursor to end of input value
    setTimeout(() => {
      input.setSelectionRange(input.value.length, input.value.length);
    }, 0);
  }

  isNumber(value) {
    return /^[0-9]$/.test(value);
  }

  handleInput(event) {
    const currentInput = event.target;
    const nextInput = this._getNextInput(currentInput);

    if (this.isNumber(currentInput.value)) {
      if (nextInput) {
        nextInput.focus();
      } else {
        // Last input filled
        this.handleSubmit();
      }
    } else {
      currentInput.value = "";
    }
  }

  handleKeydown(event) {
    const currentInput = event.target;

    // Handle backspace navigation
    if (event.key === "Backspace" && currentInput.value === "") {
      const prevInput = this._getPreviousInput(currentInput);
      if (prevInput) {
        prevInput.focus();
      }
    }

    // Handle arrow key navigation
    if (event.key === "ArrowLeft") {
      event.preventDefault();
      const prevInput = this._getPreviousInput(currentInput);
      if (prevInput) {
        prevInput.focus();
      }
    }

    if (event.key === "ArrowRight") {
      event.preventDefault();
      const nextInput = this._getNextInput(currentInput);
      if (nextInput) {
        nextInput.focus();
      }
    }
  }

  handlePaste(event) {
    event.preventDefault();
    const paste = (event.clipboardData || window.clipboardData).getData("text").trim();

    if (paste.length === 6 && /^[0-9]+$/.test(paste)) {
      this.num1Target.value = paste.charAt(0);
      this.num2Target.value = paste.charAt(1);
      this.num3Target.value = paste.charAt(2);
      this.num4Target.value = paste.charAt(3);
      this.num5Target.value = paste.charAt(4);
      this.num6Target.value = paste.charAt(5);
      this.handleSubmit();
      this.num6Target.focus(); // Focus last input after paste, then handleSubmit will move to button
    }
  }

  handleSubmit(event) {
    if (event) {
      // If triggered by form submit event
      event.preventDefault();
    }
    if (this.hasSubmitButtonTarget) {
      this.submitButtonTarget.focus();
    }

    // Submit form if autoSubmit is true
    if (this.autoSubmitValue) {
      if (this.hasFormTarget) {
        this.formTarget.submit();
      }
    }
  }

  _getInputTargets() {
    return [
      this.num1Target,
      this.num2Target,
      this.num3Target,
      this.num4Target,
      this.num5Target,
      this.num6Target,
    ].filter((target) => target); // Filter out any potentially missing targets
  }

  _getNextInput(currentInput) {
    const inputs = this._getInputTargets();
    const currentIndex = inputs.indexOf(currentInput);
    if (currentIndex !== -1 && currentIndex < inputs.length - 1) {
      return inputs[currentIndex + 1];
    }
    return null;
  }

  _getPreviousInput(currentInput) {
    const inputs = this._getInputTargets();
    const currentIndex = inputs.indexOf(currentInput);
    if (currentIndex > 0) {
      return inputs[currentIndex - 1];
    }
    return null;
  }
}
