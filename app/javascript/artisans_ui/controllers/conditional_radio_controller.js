import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["conditionalField"];

  static values = {
    fieldMap: Object,
  };

  connect() {
    // Check if there's a radio already selected and show its field
    const radios = this.element.querySelectorAll('input[type="radio"]');
    radios.forEach((radio) => {
      if (radio.checked) {
        this.showField(radio.value);
      }
    });
  }

  change(event) {
    const selectedValue = event.target.value;
    this.showField(selectedValue);
  }

  showField(value) {
    // Hide all conditional fields
    this.conditionalFieldTargets.forEach((field) => {
      field.classList.add("hidden");
    });

    // Show the field that matches the selected radio value
    const fieldName = this.fieldMapValue[value];
    if (fieldName) {
      const fieldToShow = this.conditionalFieldTargets.find(
        (field) => field.dataset.conditionalField === fieldName
      );
      if (fieldToShow) {
        fieldToShow.classList.remove("hidden");
      }
    }
  }
}
