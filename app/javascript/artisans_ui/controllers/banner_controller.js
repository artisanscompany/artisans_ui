import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="banner"
export default class extends Controller {
  static targets = ["days", "hours", "minutes", "seconds"];
  static values = {
    cookieName: { type: String, default: "banner_dismissed" }, // The name of the cookie to store the banner dismissal
    cookieDays: { type: Number, default: 0 }, // How long the cookie should persist (-1 = no cookie, 0 = session only, >0 = days)
    countdownEndTime: { type: String, default: "" }, // ISO 8601 date string (e.g., "2024-12-31T23:59:59")
    autoHide: { type: Boolean, default: false }, // Auto hide after countdown expires
  };

  connect() {
    // Check if banner was previously dismissed - do this BEFORE showing anything
    if (this.isBannerDismissed()) {
      // Don't show the banner at all, just remove from DOM
      return;
    }

    // Check if countdown has already expired (only if countdown is configured)
    if (this.countdownEndTimeValue) {
      const endTime = new Date(this.countdownEndTimeValue);
      if (!isNaN(endTime.getTime()) && endTime <= new Date()) {
        // Countdown already expired, don't show banner
        return;
      }
    }

    // Banner should be shown - remove hidden class and animate in
    this.element.classList.remove("hidden");
    requestAnimationFrame(() => {
      this.element.classList.remove("opacity-0");
      // Remove only the y-axis translations, preserve x-axis (for centered banners)
      this.element.classList.remove("-translate-y-full", "translate-y-full");
      this.element.classList.add("opacity-100", "translate-y-0");
    });

    // Initialize countdown if we have a target end time
    if (this.countdownEndTimeValue) {
      this.initializeCountdown();
    }
  }

  disconnect() {
    if (this.countdownTimer) {
      clearInterval(this.countdownTimer);
    }
  }

  initializeCountdown() {
    // Parse the end time as ISO 8601 date string
    const endTime = new Date(this.countdownEndTimeValue);

    // Validate the date
    if (isNaN(endTime.getTime())) {
      console.error("Invalid countdown end time. Please provide a valid ISO 8601 date string (e.g., '2024-12-31T23:59:59'):", this.countdownEndTimeValue);
      return;
    }

    this.endTime = endTime;

    // Update immediately
    this.updateCountdown();

    // Update every second
    this.countdownTimer = setInterval(() => {
      this.updateCountdown();
    }, 1000);
  }

  updateCountdown() {
    const now = new Date();
    const timeRemaining = this.endTime - now;

    if (timeRemaining <= 0) {
      // Countdown expired
      this.handleCountdownExpired();
      return;
    }

    // Calculate days, hours, minutes, seconds
    const days = Math.floor(timeRemaining / (1000 * 60 * 60 * 24));
    const hours = Math.floor((timeRemaining % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    const minutes = Math.floor((timeRemaining % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((timeRemaining % (1000 * 60)) / 1000);

    // Update targets if they exist
    if (this.hasDaysTarget) {
      this.daysTarget.textContent = String(days).padStart(2, "0");
    }
    if (this.hasHoursTarget) {
      this.hoursTarget.textContent = String(hours).padStart(2, "0");
    }
    if (this.hasMinutesTarget) {
      this.minutesTarget.textContent = String(minutes).padStart(2, "0");
    }
    if (this.hasSecondsTarget) {
      this.secondsTarget.textContent = String(seconds).padStart(2, "0");
    }
  }

  handleCountdownExpired() {
    // Clear the interval
    if (this.countdownTimer) {
      clearInterval(this.countdownTimer);
      this.countdownTimer = null;
    }

    // Display zeros
    if (this.hasDaysTarget) this.daysTarget.textContent = "00";
    if (this.hasHoursTarget) this.hoursTarget.textContent = "00";
    if (this.hasMinutesTarget) this.minutesTarget.textContent = "00";
    if (this.hasSecondsTarget) this.secondsTarget.textContent = "00";

    // Auto hide if configured
    if (this.autoHideValue) {
      setTimeout(() => {
        this.hide();
      }, 2000); // Wait 2 seconds before hiding
    }
  }

  hide(event) {
    if (event) event.preventDefault();

    // Add exit animation using Tailwind classes
    this.element.classList.remove("opacity-100", "translate-y-0");
    this.element.classList.add("opacity-0");

    // Add the appropriate slide out based on position
    if (this.element.classList.contains("top-0")) {
      this.element.classList.add("-translate-y-full");
    } else if (this.element.classList.contains("bottom-0") || this.element.classList.contains("bottom-4")) {
      this.element.classList.add("translate-y-full");
    }

    // Wait for animation to complete before removing
    setTimeout(() => {
      // Set cookie to remember dismissal (only if cookieDays is not -1)
      if (this.cookieDaysValue !== -1) {
        this.setCookie(this.cookieNameValue, "true", this.cookieDaysValue);
        // Remove element from DOM when using cookies
        this.element.remove();
      } else {
        // When cookieDays is -1, keep element in DOM but hide it for refresh functionality
        this.element.classList.add("hidden");
      }
    }, 300); // Match the transition duration
  }

  // Cookie management methods
  setCookie(name, value, days) {
    if (days === 0) {
      // Session cookie (no expiration - lasts until browser closes)
      document.cookie = name + "=" + value + ";path=/;SameSite=Lax";
    } else {
      // Persistent cookie with expiration
      const date = new Date();
      date.setTime(date.getTime() + days * 24 * 60 * 60 * 1000);
      const expires = "expires=" + date.toUTCString();
      document.cookie = name + "=" + value + ";" + expires + ";path=/;SameSite=Lax";
    }
  }

  getCookie(name) {
    const nameEQ = name + "=";
    const cookies = document.cookie.split(";");
    for (let i = 0; i < cookies.length; i++) {
      let cookie = cookies[i];
      while (cookie.charAt(0) === " ") {
        cookie = cookie.substring(1, cookie.length);
      }
      if (cookie.indexOf(nameEQ) === 0) {
        return cookie.substring(nameEQ.length, cookie.length);
      }
    }
    return null;
  }

  isBannerDismissed() {
    return this.getCookie(this.cookieNameValue) === "true";
  }
}
