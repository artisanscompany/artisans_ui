# DatePicker Components

⚠️ **PARTIAL IMPLEMENTATION - External Dependencies Required**

Advanced date picker components powered by AirDatepicker library with Floating UI positioning.

**Status**: 4 of 10 components implemented (Basic, WithInitialDate, Range, WithTime)

**Note**: This category requires external JavaScript libraries (AirDatepicker, Floating UI) that must be installed separately by the consuming application. The Stimulus controller is provided, but components will only function once dependencies are installed.

## Installation Requirements

### 1. JavaScript Dependencies

Add to your `config/importmap.rb`:

```ruby
pin "air-datepicker", to: "https://esm.sh/air-datepicker@3.6.0"
pin "air-datepicker/locale/en", to: "https://esm.sh/air-datepicker@3.6.0/locale/en"
pin "@floating-ui/dom", to: "https://cdn.jsdelivr.net/npm/@floating-ui/dom@1.7.3/+esm"
```

### 2. CSS Stylesheet

Add to your layout's `<head>` section:

```erb
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/air-datepicker@3.6.0/air-datepicker.min.css">
```

### 3. Custom Styling

Add the custom CSS from `docs/datepicker_styles.css` to your `app/assets/stylesheets/application.css` for proper light/dark mode theming.

## Available Components

- **BasicComponent** - Simple date picker with optional buttons
- **WithInitialDateComponent** - Pre-populated with specific date
- **RangeComponent** - Select date range with start and end
- **WithTimeComponent** - Date and time selection
- **MinMaxDatesComponent** - Constrained date selection
- **DisabledDatesComponent** - Specific dates disabled
- **WeekPickerComponent** - Week selection mode
- **MonthYearPickerComponent** - Month/year only
- **TimeOnlyComponent** - Time picker without date
- **InlineCalendarComponent** - Always-visible calendar

## Usage Example

```erb
<%= render ArtisansUi::DatePicker::BasicComponent.new(
  show_today_button: true,
  show_clear_button: true
) %>
```

## Features

- Full dark mode support
- Floating UI intelligent positioning
- Keyboard navigation (Delete/Backspace to clear)
- Range selection
- Time picker integration
- Week/Month/Year views
- Disabled dates
- Min/max constraints
- Customizable buttons
- Inline calendar mode
```
