import { Controller } from "@hotwired/stimulus";
import { computePosition, flip, shift, offset, arrow } from "@floating-ui/dom";

// Global tooltip state manager
// This class tracks all visible tooltips and manages the "fast mode" feature
// Fast mode: After the first tooltip is shown, subsequent tooltips appear instantly (no delay)
// This provides a better UX when quickly hovering over multiple items (e.g., sidebar icons)
class TooltipGlobalState {
  constructor() {
    this.visibleCount = 0; // Number of currently visible tooltips
    this.isFastMode = false; // Whether we're in fast mode (no delay)
    this.resetTimeout = null; // Timeout to reset fast mode
    this.fastModeResetDelay = 100; // Time (ms) after last tooltip closes to exit fast mode
    this.visibleTooltips = new Set(); // Set of currently visible tooltip controllers
    this.closingTooltips = new Set(); // Set of tooltips currently animating closed
  }

  // Called when a tooltip starts showing
  onTooltipShow(tooltipController) {
    // Add to visible set, remove from closing set
    this.visibleTooltips.add(tooltipController);
    this.closingTooltips.delete(tooltipController);
    this.visibleCount = this.visibleTooltips.size;

    // Enable fast mode if we have any visible tooltips
    if (this.visibleCount > 0 && !this.isFastMode) {
      this.isFastMode = true;
    }

    // Cancel any pending reset timeout
    this.clearResetTimeout();
  }

  // Called when a tooltip starts hiding
  onTooltipHide(tooltipController) {
    // Move from visible to closing set
    this.visibleTooltips.delete(tooltipController);
    this.closingTooltips.add(tooltipController);
    this.visibleCount = this.visibleTooltips.size;

    // If no more visible tooltips, schedule fast mode reset
    if (this.visibleCount === 0) {
      this.scheduleReset();
    }
  }

  // Called when a tooltip's closing animation finishes
  onTooltipHidden(tooltipController) {
    // Remove from closing set
    this.closingTooltips.delete(tooltipController);
  }

  // Schedule reset of fast mode after a delay
  scheduleReset() {
    this.clearResetTimeout();
    this.resetTimeout = setTimeout(() => {
      // Only reset if we have no visible or closing tooltips
      if (this.visibleCount === 0 && this.closingTooltips.size === 0) {
        this.isFastMode = false;
      }
    }, this.fastModeResetDelay);
  }

  clearResetTimeout() {
    if (this.resetTimeout) {
      clearTimeout(this.resetTimeout);
      this.resetTimeout = null;
    }
  }

  // Hide all tooltips instantly except the specified one
  hideAllTooltipsInstantly(exceptController) {
    // Hide all visible tooltips
    const visibleToHide = [...this.visibleTooltips].filter((controller) => controller !== exceptController);
    visibleToHide.forEach((controller) => {
      controller._hideTooltip(true); // true = instant hide
    });

    // Also instantly hide any closing tooltips
    const closingToHide = [...this.closingTooltips].filter((controller) => controller !== exceptController);
    closingToHide.forEach((controller) => {
      controller._finishClosingAnimation();
    });
  }

  // Check if we're in fast mode
  isInFastMode() {
    return this.isFastMode;
  }
}

// Create global instance
const tooltipGlobalState = new TooltipGlobalState();

// Connects to data-controller="tooltip"
export default class extends Controller {
  static targets = ["content", "arrow"];

  static values = {
    placement: { type: String, default: "top" },
    offset: { type: Number, default: 8 },
    maxWidth: { type: String, default: "20rem" },
    delay: { type: Number, default: 200 }, // Delay before showing tooltip
    size: { type: String, default: "md" }, // sm, md, lg
    animation: { type: String, default: "fade" }, // fade, origin, combined, or none
    trigger: { type: String, default: "hover" }, // hover, focus, click, or combined (e.g., "hover focus")
  };

  connect() {
    this.tooltip = null;
    this.cleanup = null;
    this.showTimeout = null;
    this.hideTimeout = null;
    this.isVisible = false;
    this.isClosing = false;
    this.observer = null;

    // Detect touch devices
    this.isTouchDevice = "ontouchstart" in window || navigator.maxTouchPoints > 0;

    // On touch devices, use click instead of hover
    if (this.isTouchDevice && this.triggerValue === "hover") {
      this.triggerValue = "click";
    }

    // Parse trigger value (can be space-separated list like "hover focus")
    this.triggers = this.triggerValue.split(" ");

    this.setupEventListeners();
  }

  disconnect() {
    this.clearTimeouts();
    this.removeTooltip();
    this.removeEventListeners();
    this.disconnectObserver();
  }

  setupEventListeners() {
    this.boundShow = this.show.bind(this);
    this.boundHide = this.hide.bind(this);
    this.boundToggle = this.toggle.bind(this);

    if (this.triggers.includes("hover")) {
      this.element.addEventListener("mouseenter", this.boundShow);
      this.element.addEventListener("mouseleave", this.boundHide);
    }

    if (this.triggers.includes("focus")) {
      this.element.addEventListener("focus", this.boundShow);
      this.element.addEventListener("blur", this.boundHide);
    }

    if (this.triggers.includes("click")) {
      this.element.addEventListener("click", this.boundToggle);
    }
  }

  removeEventListeners() {
    if (this.triggers.includes("hover")) {
      this.element.removeEventListener("mouseenter", this.boundShow);
      this.element.removeEventListener("mouseleave", this.boundHide);
    }

    if (this.triggers.includes("focus")) {
      this.element.removeEventListener("focus", this.boundShow);
      this.element.removeEventListener("blur", this.boundHide);
    }

    if (this.triggers.includes("click")) {
      this.element.removeEventListener("click", this.boundToggle);
    }
  }

  show() {
    // If already visible or closing, don't show again
    if (this.isVisible || this.isClosing) {
      return;
    }

    // Hide all other tooltips instantly before showing this one
    tooltipGlobalState.hideAllTooltipsInstantly(this);

    // Clear any pending hide timeout
    this.clearHideTimeout();

    // Determine delay based on fast mode
    const delay = tooltipGlobalState.isInFastMode() ? 0 : this.delayValue;

    this.showTimeout = setTimeout(() => {
      this.createTooltip();
      this.positionTooltip();
      this.showTooltip();
      this.setupObserver();

      // Notify global state
      tooltipGlobalState.onTooltipShow(this);
    }, delay);
  }

  hide() {
    this.clearShowTimeout();

    if (!this.isVisible) {
      return;
    }

    this._hideTooltip(false); // false = normal hide with animation
  }

  // Internal method to hide tooltip (can be called externally by global state)
  _hideTooltip(instant = false) {
    if (!this.isVisible) {
      return;
    }

    this.isVisible = false;
    this.isClosing = true;

    // Notify global state
    tooltipGlobalState.onTooltipHide(this);

    if (!this.tooltip) {
      return;
    }

    if (instant || this.animationValue === "none") {
      this.removeTooltip();
      this.isClosing = false;
      tooltipGlobalState.onTooltipHidden(this);
    } else {
      // Animate out
      this.tooltip.classList.remove("tooltip-visible");
      this.tooltip.classList.add("tooltip-hiding");

      // Wait for animation to complete
      setTimeout(() => {
        this._finishClosingAnimation();
      }, 150); // Match animation duration
    }
  }

  // Internal method to finish closing animation (can be called externally by global state)
  _finishClosingAnimation() {
    if (this.tooltip) {
      this.removeTooltip();
    }
    this.isClosing = false;
    tooltipGlobalState.onTooltipHidden(this);
  }

  toggle() {
    if (this.isVisible) {
      this.hide();
    } else {
      this.show();
    }
  }

  createTooltip() {
    if (this.tooltip) {
      return;
    }

    // Clone the content
    const content = this.contentTarget.cloneNode(true);
    content.removeAttribute("data-tooltip-target");

    // Create tooltip element
    this.tooltip = document.createElement("div");
    this.tooltip.className = this.getTooltipClasses();
    this.tooltip.style.maxWidth = this.maxWidthValue;

    // Create arrow if we have an arrow target
    if (this.hasArrowTarget) {
      const arrowEl = document.createElement("div");
      arrowEl.className = "tooltip-arrow";
      this.tooltip.appendChild(arrowEl);
      this.arrowElement = arrowEl;
    }

    // Append content
    this.tooltip.appendChild(content);

    // Append to body
    document.body.appendChild(this.tooltip);
  }

  getTooltipClasses() {
    const classes = ["tooltip"];

    // Size classes
    if (this.sizeValue === "sm") {
      classes.push("tooltip-sm");
    } else if (this.sizeValue === "lg") {
      classes.push("tooltip-lg");
    } else {
      classes.push("tooltip-md");
    }

    // Animation classes
    if (this.animationValue === "fade") {
      classes.push("tooltip-fade");
    } else if (this.animationValue === "origin") {
      classes.push("tooltip-origin");
    } else if (this.animationValue === "combined") {
      classes.push("tooltip-fade", "tooltip-origin");
    }

    return classes.join(" ");
  }

  async positionTooltip() {
    if (!this.tooltip) {
      return;
    }

    const middleware = [offset(this.offsetValue), flip(), shift({ padding: 5 })];

    if (this.arrowElement) {
      middleware.push(arrow({ element: this.arrowElement }));
    }

    const { x, y, placement, middlewareData } = await computePosition(this.element, this.tooltip, {
      placement: this.placementValue,
      middleware,
    });

    // Position tooltip
    Object.assign(this.tooltip.style, {
      left: `${x}px`,
      top: `${y}px`,
    });

    // Position arrow
    if (this.arrowElement && middlewareData.arrow) {
      const { x: arrowX, y: arrowY } = middlewareData.arrow;
      const staticSide = {
        top: "bottom",
        right: "left",
        bottom: "top",
        left: "right",
      }[placement.split("-")[0]];

      Object.assign(this.arrowElement.style, {
        left: arrowX != null ? `${arrowX}px` : "",
        top: arrowY != null ? `${arrowY}px` : "",
        right: "",
        bottom: "",
        [staticSide]: "-4px",
      });
    }
  }

  showTooltip() {
    if (!this.tooltip) {
      return;
    }

    this.isVisible = true;

    requestAnimationFrame(() => {
      if (this.tooltip) {
        this.tooltip.classList.add("tooltip-visible");
      }
    });
  }

  removeTooltip() {
    if (this.tooltip) {
      this.tooltip.remove();
      this.tooltip = null;
      this.arrowElement = null;
    }

    this.disconnectObserver();
  }

  setupObserver() {
    // Watch for trigger element scrolling out of view
    if (!this.observer && "IntersectionObserver" in window) {
      this.observer = new IntersectionObserver(
        (entries) => {
          entries.forEach((entry) => {
            if (!entry.isIntersecting && this.isVisible) {
              this.hide();
            }
          });
        },
        {
          threshold: 0,
        }
      );

      this.observer.observe(this.element);
    }
  }

  disconnectObserver() {
    if (this.observer) {
      this.observer.disconnect();
      this.observer = null;
    }
  }

  clearTimeouts() {
    this.clearShowTimeout();
    this.clearHideTimeout();
  }

  clearShowTimeout() {
    if (this.showTimeout) {
      clearTimeout(this.showTimeout);
      this.showTimeout = null;
    }
  }

  clearHideTimeout() {
    if (this.hideTimeout) {
      clearTimeout(this.hideTimeout);
      this.hideTimeout = null;
    }
  }
}
