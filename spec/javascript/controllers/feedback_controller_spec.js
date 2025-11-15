import { Application } from "@hotwired/stimulus";
import FeedbackController from "../../../app/javascript/artisans_ui/controllers/feedback_controller";

describe("FeedbackController", () => {
  let application;
  let controller;

  beforeEach(() => {
    application = Application.start();
    application.register("feedback", FeedbackController);
  });

  afterEach(() => {
    application.stop();
  });

  describe("initialization", () => {
    it("sets isOpen to false on connect", () => {
      const element = document.createElement("div");
      element.setAttribute("data-controller", "feedback");
      document.body.appendChild(element);

      controller = application.getControllerForElementAndIdentifier(
        element,
        "feedback"
      );

      expect(controller.isOpen).toBe(false);
      document.body.removeChild(element);
    });

    it("uses default anchor point 'center'", () => {
      const element = document.createElement("div");
      element.setAttribute("data-controller", "feedback");
      document.body.appendChild(element);

      controller = application.getControllerForElementAndIdentifier(
        element,
        "feedback"
      );

      expect(controller.anchorPointValue).toBe("center");
      document.body.removeChild(element);
    });

    it("accepts custom anchor point", () => {
      const element = document.createElement("div");
      element.setAttribute("data-controller", "feedback");
      element.setAttribute("data-feedback-anchor-point-value", "top-left");
      document.body.appendChild(element);

      controller = application.getControllerForElementAndIdentifier(
        element,
        "feedback"
      );

      expect(controller.anchorPointValue).toBe("top-left");
      document.body.removeChild(element);
    });
  });

  describe("anchor point calculation", () => {
    beforeEach(() => {
      const element = document.createElement("div");
      element.setAttribute("data-controller", "feedback");
      document.body.appendChild(element);

      controller = application.getControllerForElementAndIdentifier(
        element,
        "feedback"
      );
    });

    afterEach(() => {
      if (controller.element.parentNode) {
        controller.element.parentNode.removeChild(controller.element);
      }
    });

    it("calculates center anchor point correctly", () => {
      controller.anchorPointValue = "center";
      const rect = { left: 100, top: 100, width: 50, height: 30 };
      const point = controller.getAnchorPoint(rect);

      expect(point.x).toBe(125); // left + width/2
      expect(point.y).toBe(115); // top + height/2
    });

    it("calculates top-left anchor point correctly", () => {
      controller.anchorPointValue = "top-left";
      const rect = { left: 100, top: 100, width: 50, height: 30 };
      const point = controller.getAnchorPoint(rect);

      expect(point.x).toBe(100);
      expect(point.y).toBe(100);
    });

    it("calculates bottom-right anchor point correctly", () => {
      controller.anchorPointValue = "bottom-right";
      const rect = {
        left: 100,
        top: 100,
        width: 50,
        height: 30,
        right: 150,
        bottom: 130,
      };
      const point = controller.getAnchorPoint(rect);

      expect(point.x).toBe(150);
      expect(point.y).toBe(130);
    });
  });

  describe("toggle behavior", () => {
    beforeEach(() => {
      const element = document.createElement("div");
      element.setAttribute("data-controller", "feedback");
      element.innerHTML = `
        <button data-feedback-target="button">Feedback</button>
        <div data-feedback-target="form" class="hidden">
          <textarea data-feedback-target="textarea"></textarea>
        </div>
      `;
      document.body.appendChild(element);

      controller = application.getControllerForElementAndIdentifier(
        element,
        "feedback"
      );
    });

    afterEach(() => {
      if (controller.element.parentNode) {
        controller.element.parentNode.removeChild(controller.element);
      }
    });

    it("opens when closed", () => {
      controller.isOpen = false;
      controller.toggle();
      expect(controller.isOpen).toBe(true);
    });

    it("closes when open", () => {
      controller.isOpen = true;
      controller.toggle();
      expect(controller.isOpen).toBe(false);
    });
  });
});
