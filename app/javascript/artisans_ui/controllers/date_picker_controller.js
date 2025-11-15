import { Controller } from "@hotwired/stimulus";
import { computePosition, offset, flip, shift, arrow, autoUpdate } from "@floating-ui/dom";
import AirDatepicker from "air-datepicker";
import localeEn from "air-datepicker/locale/en";

export default class extends Controller {
  static targets = ["input", "inlineCalendar"];
  static values = {
    placement: { type: String, default: "bottom-start" },
    range: { type: Boolean, default: false },
    disabledDates: { type: Array, default: [] },
    timepicker: { type: Boolean, default: false },
    timeOnly: { type: Boolean, default: false },
    weekPicker: { type: Boolean, default: false },
    timeFormat: { type: String, default: "" },
    minHours: Number,
    maxHours: Number,
    minutesStep: Number,
    showTodayButton: { type: Boolean, default: false },
    showClearButton: { type: Boolean, default: false },
    showThisMonthButton: { type: Boolean, default: false },
    showThisYearButton: { type: Boolean, default: false },
    dateFormat: { type: String, default: "" },
    startView: { type: String, default: "days" },
    minView: { type: String, default: "days" },
    initialDate: { type: String, default: "" },
    minDate: { type: String, default: "" },
    maxDate: { type: String, default: "" },
    inline: { type: Boolean, default: false },
  };

  connect() {
    this.initializeDatepicker();
    this.inputTarget.addEventListener("keydown", this.handleKeydown.bind(this));
  }

  initializeDatepicker() {
    if (this.datepickerInstance) {
      this.datepickerInstance.destroy();
      this._cleanupPositioning();
    }

    const options = this._buildDatepickerOptions();

    if (!this.inlineValue) {
      options.position = this._createPositionFunction();
    }

    this.datepickerInstance = new AirDatepicker(this.inputTarget, options);

    if (this.weekPickerValue) {
      setTimeout(() => this._updateWeekDisplay(), 0);
    }

    if (this.inlineValue) {
      setTimeout(() => this._triggerChangeEvent(), 0);
    }
  }

  _buildDatepickerOptions() {
    const options = {
      locale: localeEn,
      autoClose: !this.inlineValue,
      inline: this.inlineValue,
      container: this.inputTarget.closest("dialog") || undefined,
    };

    if (this.timeOnlyValue) {
      options.dateFormat = "";
      options.onSelect = this._createTimeOnlySelectHandler();
    } else if (this.weekPickerValue) {
      options.dateFormat = "";
      options.onSelect = this._createWeekSelectHandler();
    } else if (this.hasDateFormatValue && this.dateFormatValue) {
      options.dateFormat = this.dateFormatValue;
    }

    if (this.hasStartViewValue) options.view = this.startViewValue;
    if (this.hasMinViewValue) options.minView = this.minViewValue;

    this._setDateConstraint(options, "minDate", this.minDateValue);
    this._setDateConstraint(options, "maxDate", this.maxDateValue);

    const initialDates = this._parseInitialDates();
    if (initialDates.length > 0) options.selectedDates = initialDates;

    if (this.rangeValue) {
      options.range = true;
      options.multipleDatesSeparator = " - ";
    }

    if (this.timepickerValue || this.timeOnlyValue) {
      Object.assign(options, {
        timepicker: true,
        timeFormat: this.timeFormatValue || "hh:mm AA",
        ...(this.hasMinHoursValue && { minHours: this.minHoursValue }),
        ...(this.hasMaxHoursValue && { maxHours: this.maxHoursValue }),
        ...(this.hasMinutesStepValue && { minutesStep: this.minutesStepValue }),
      });
      if (this.timeOnlyValue) options.classes = "only-timepicker";
    }

    const buttons = this._buildButtons();
    if (buttons.length > 0) options.buttons = buttons;

    const disabledDates = this._parseDisabledDates();
    if (disabledDates.length > 0) {
      options.onRenderCell = this._createRenderCellHandler(disabledDates);
    }

    if (this.inlineValue && !this.timeOnlyValue && !this.weekPickerValue) {
      const originalOnSelect = options.onSelect;
      options.onSelect = (params) => {
        originalOnSelect?.(params);
        this._triggerChangeEvent();
      };
    }

    return options;
  }

  _setDateConstraint(options, key, value) {
    if (value) {
      const date = this._parseDate(value);
      if (date) options[key] = date;
    }
  }

  _parseInitialDates() {
    if (!this.hasInitialDateValue || !this.initialDateValue) return [];

    try {
      if (this.initialDateValue.startsWith("[") && this.initialDateValue.endsWith("]")) {
        const dateStrings = JSON.parse(this.initialDateValue);
        return dateStrings.map((str) => this._parseDate(str)).filter(Boolean);
      }
      const date = this._parseDate(this.initialDateValue);
      return date ? [date] : [];
    } catch (e) {
      console.error("Error parsing initialDateValue:", e);
      return [];
    }
  }

  _buildButtons() {
    const buttons = [];
    if (this.showTodayButtonValue) buttons.push(this._createTodayButton());
    if (this.showThisMonthButtonValue) buttons.push(this._createMonthButton());
    if (this.showThisYearButtonValue) buttons.push(this._createYearButton());
    if (this.showClearButtonValue) buttons.push("clear");
    return buttons;
  }

  _createTodayButton() {
    const isTimepicker = this.timepickerValue || this.timeOnlyValue || this.weekPickerValue;
    const buttonText = this.weekPickerValue ? "This week" : isTimepicker ? "Now" : "Today";

    return {
      content: buttonText,
      onClick: (dp) => {
        const currentDate = new Date();
        const dates = this.rangeValue ? [currentDate, currentDate] : currentDate;
        if (isTimepicker && !this.weekPickerValue) {
          dp.clear();
          setTimeout(() => dp.selectDate(dates, { updateTime: true }), 0);
        } else {
          dp.selectDate(dates);
        }
      },
    };
  }

  _createMonthButton() {
    return {
      content: "This month",
      onClick: (dp) => {
        const now = new Date();
        dp.selectDate(new Date(now.getFullYear(), now.getMonth(), 1));
      },
    };
  }

  _createYearButton() {
    return {
      content: "This year",
      onClick: (dp) => {
        const now = new Date();
        dp.selectDate(new Date(now.getFullYear(), 0, 1));
      },
    };
  }

  _parseDisabledDates() {
    if (!this.disabledDatesValue?.length) return [];
    return this.disabledDatesValue.map((str) => this._parseDate(str)).filter(Boolean);
  }

  _createRenderCellHandler(disabledDates) {
    return ({ date, cellType }) => {
      if (cellType !== "day") return {};
      const cellDateUTC = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate()));
      const isDisabled = disabledDates.some((d) => d.getTime() === cellDateUTC.getTime());
      return isDisabled ? { disabled: true } : {};
    };
  }

  _createTimeOnlySelectHandler() {
    return ({ date, datepicker }) => {
      if (date) {
        const timeFormat = this.timeFormatValue || "hh:mm AA";
        this.inputTarget.value = datepicker.formatDate(date, timeFormat);
        this._triggerChangeEvent();
      }
    };
  }

  _createWeekSelectHandler() {
    return ({ date }) => {
      if (date) {
        const weekNumber = this._getWeekNumber(date);
        const year = date.getFullYear();
        this.inputTarget.value = `${year}-W${weekNumber.toString().padStart(2, "0")}`;
        this._triggerChangeEvent();
      }
    };
  }

  _createPositionFunction() {
    return ({ $datepicker, $target, $pointer, done }) => {
      const middleware = [offset(8), flip(), shift({ padding: 8 })];
      if ($pointer instanceof HTMLElement) {
        middleware.push(arrow({ element: $pointer, padding: 5 }));
      }

      this._cleanupPositioning();

      this.currentCleanup = autoUpdate($target, $datepicker, () => {
        computePosition($target, $datepicker, {
          placement: this.placementValue,
          middleware,
        }).then(({ x, y, middlewareData }) => {
          Object.assign($datepicker.style, { left: `${x}px`, top: `${y}px` });
          if ($pointer instanceof HTMLElement && middlewareData.arrow) {
            const { x: arrowX, y: arrowY } = middlewareData.arrow;
            Object.assign($pointer.style, {
              left: arrowX != null ? `${arrowX}px` : "",
              top: arrowY != null ? `${arrowY}px` : "",
            });
          }
        });
      }, { animationFrame: true });

      return () => {
        this._cleanupPositioning();
        done();
      };
    };
  }

  _getWeekNumber(date) {
    const temp = new Date(date.getTime());
    const dayNum = (temp.getDay() + 6) % 7;
    temp.setDate(temp.getDate() - dayNum + 3);
    const firstThurs = new Date(temp.getFullYear(), 0, 4);
    firstThurs.setDate(firstThurs.getDate() - ((firstThurs.getDay() + 6) % 7) + 3);
    return Math.round((temp.getTime() - firstThurs.getTime()) / 86400000 / 7) + 1;
  }

  _parseDate(dateString) {
    if (!dateString || typeof dateString !== "string") return null;

    if (dateString.includes(" ")) {
      const [datePart, timePart] = dateString.split(" ");
      const dateParts = datePart.split("-");
      if (dateParts.length === 3 && timePart) {
        const [year, month, day] = dateParts.map(Number);
        const [hours, minutes] = timePart.split(":").map(Number);
        if (!isNaN(year) && !isNaN(month) && !isNaN(day) && !isNaN(hours) && !isNaN(minutes)) {
          return new Date(year, month - 1, day, hours, minutes);
        }
      }
    }

    const parts = dateString.split("-");
    if (parts.length === 3) {
      const [year, month, day] = parts.map(Number);
      if (!isNaN(year) && !isNaN(month) && !isNaN(day)) {
        return new Date(Date.UTC(year, month - 1, day));
      }
    }

    return null;
  }

  handleKeydown(event) {
    if (event.key === "Delete" || event.key === "Backspace") {
      this.datepickerInstance?.clear();
      this.inputTarget.value = "";
    }
  }

  disconnect() {
    if (this.datepickerInstance) {
      this.datepickerInstance.destroy();
      this.datepickerInstance = null;
    }
    this._cleanupPositioning();
    if (this.inputTarget) {
      this.inputTarget.removeEventListener("keydown", this.handleKeydown.bind(this));
    }
  }

  _triggerChangeEvent() {
    this.inputTarget.dispatchEvent(new Event("change", { bubbles: true }));
  }

  _updateWeekDisplay() {
    if (!this.datepickerInstance) return;
    const selectedDates = this.datepickerInstance.selectedDates;
    if (selectedDates.length > 0) {
      const initialDate = selectedDates[0];
      const weekNumber = this._getWeekNumber(initialDate);
      const year = initialDate.getFullYear();
      this.inputTarget.value = `${year}-W${weekNumber.toString().padStart(2, "0")}`;
      this._triggerChangeEvent();
    } else {
      this.inputTarget.value = "";
      this._triggerChangeEvent();
    }
  }

  _cleanupPositioning() {
    if (this.currentCleanup) {
      this.currentCleanup();
      this.currentCleanup = null;
    }
  }
}
