import { Controller } from "@hotwired/stimulus";
import { animate, spring } from "motion";

// Connects to data-controller="feedback"
export default class extends Controller {
  static targets = ["button", "buttonText", "form", "textarea"];
  static values = {
    anchorPoint: { type: String, default: "center" },
  };

  connect() {
    this.isOpen = false;
    this.setupEscapeHandler();
    this.setupClickOutsideHandler();
  }

  disconnect() {
    this.removeEscapeHandler();
    this.removeClickOutsideHandler();
  }

  toggle() {
    if (this.isOpen) {
      this.close();
    } else {
      this.open();
    }
  }

  open() {
    this.isOpen = true;
    const buttonRect = this.buttonTarget.getBoundingClientRect();
    const anchorPoint = this.getAnchorPoint(buttonRect);

    // Set form position and initial state
    this.formTarget.style.position = "fixed";
    this.formTarget.style.transformOrigin = `${anchorPoint.x}px ${anchorPoint.y}px`;
    this.formTarget.style.left = `${anchorPoint.x}px`;
    this.formTarget.style.top = `${anchorPoint.y}px`;
    this.formTarget.style.transform = "translate(-50%, -50%) scale(0)";
    this.formTarget.style.opacity = "0";
    this.formTarget.classList.remove("hidden");

    // Animate form expansion
    animate(
      this.formTarget,
      {
        opacity: 1,
        scale: 1,
      },
      {
        easing: spring({
          stiffness: 300,
          damping: 25,
        }),
      }
    );

    // Hide button with animation
    animate(
      this.buttonTarget,
      {
        opacity: 0,
        scale: 0.9,
      },
      {
        duration: 0.2,
      }
    ).finished.then(() => {
      this.buttonTarget.classList.add("hidden");
    });

    // Focus textarea after animation
    setTimeout(() => {
      this.textareaTarget.focus();
    }, 150);
  }

  close() {
    this.isOpen = false;

    // Animate form collapse
    animate(
      this.formTarget,
      {
        opacity: 0,
        scale: 0,
      },
      {
        duration: 0.2,
      }
    ).finished.then(() => {
      this.formTarget.classList.add("hidden");
      this.formTarget.style.position = "";
      this.formTarget.style.left = "";
      this.formTarget.style.top = "";
      this.formTarget.style.transform = "";
      this.formTarget.style.transformOrigin = "";
    });

    // Show button with animation
    this.buttonTarget.classList.remove("hidden");
    animate(
      this.buttonTarget,
      {
        opacity: 1,
        scale: 1,
      },
      {
        easing: spring({
          stiffness: 300,
          damping: 25,
        }),
      }
    );
  }

  submit(event) {
    event.preventDefault();
    // Handle form submission
    const formData = new FormData(event.target);
    const feedback = formData.get("feedback");

    // You can customize this to send to your backend
    console.log("Feedback submitted:", feedback);

    // Reset form and close
    this.textareaTarget.value = "";
    this.close();
  }

  getAnchorPoint(buttonRect) {
    const centerX = buttonRect.left + buttonRect.width / 2;
    const centerY = buttonRect.top + buttonRect.height / 2;
    const top = buttonRect.top;
    const bottom = buttonRect.bottom;
    const left = buttonRect.left;
    const right = buttonRect.right;

    switch (this.anchorPointValue) {
      case "top":
        return { x: centerX, y: top };
      case "top-left":
        return { x: left, y: top };
      case "top-right":
        return { x: right, y: top };
      case "bottom":
        return { x: centerX, y: bottom };
      case "bottom-left":
        return { x: left, y: bottom };
      case "bottom-right":
        return { x: right, y: bottom };
      case "left":
        return { x: left, y: centerY };
      case "right":
        return { x: right, y: centerY };
      case "center":
      default:
        return { x: centerX, y: centerY };
    }
  }

  setupEscapeHandler() {
    this.escapeHandler = (event) => {
      if (event.key === "Escape" && this.isOpen) {
        this.close();
      }
    };
    document.addEventListener("keydown", this.escapeHandler);
  }

  removeEscapeHandler() {
    if (this.escapeHandler) {
      document.removeEventListener("keydown", this.escapeHandler);
    }
  }

  setupClickOutsideHandler() {
    this.clickOutsideHandler = (event) => {
      if (this.isOpen && !this.element.contains(event.target)) {
        this.close();
      }
    };
    document.addEventListener("click", this.clickOutsideHandler);
  }

  removeClickOutsideHandler() {
    if (this.clickOutsideHandler) {
      document.removeEventListener("click", this.clickOutsideHandler);
    }
  }
}
