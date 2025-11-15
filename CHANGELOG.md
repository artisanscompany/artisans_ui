# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Dock components (2 variants) - RailsBlocks exact implementation
  - TopPlacementComponent: Desktop dock menu at top with tooltips below icons
  - BottomPlacementComponent: Desktop dock menu at bottom with tooltips above icons
- Stimulus dock controller with Motion.dev spring animations
- Desktop hover animations with distance-based icon scaling (40-80px)
- Mobile menu toggle with staggered spring animations
- Tooltip system with Floating UI positioning and hotkey display
- Active state management based on URL pathname and query params
- Turbo compatibility (restore tooltips, update active states)
- Stimulus hotkey controller for keyboard shortcuts integration
- Comprehensive RSpec tests for all Dock components (30 examples total, 100% passing)
- Full dark mode support with backdrop blur and shadows
- Confirmation components (5 variants) - RailsBlocks exact implementation
  - BasicComponent: Text confirmation for destructive actions (type "DELETE")
  - CaseSensitiveComponent: Case-sensitive text matching with warning box
  - ArrayValuesComponent: Multiple acceptable text values (DELETE, REMOVE, DESTROY)
  - AnyTextComponent: Accept any text input (for project names, etc.)
  - MultiStepComponent: Combined text + multiple checkbox confirmations
- Stimulus confirmation controller with form submission prevention
- Comprehensive RSpec tests for all Confirmation variants (26 examples total, 100% passing)
- Full dark mode support with appropriate button styling (red for destructive, neutral for standard)
- ColorPicker components (6 variants) - RailsBlocks exact implementation
  - BasicComponent: Native HTML5 color input with minimal styling
  - WithSwatchesComponent: HTML5 color input with datalist predefined colors and visual swatch buttons
  - EnhancedComponent: Shoelace color picker with format display and modern interface
  - WithOpacityComponent: Shoelace picker with alpha channel support, HEX/RGBA display, and transparency preview
  - FormatVariationsComponent: Shoelace pickers demonstrating HEX, RGB, HSL, and HSV format outputs
  - WithPaletteComponent: Shoelace picker with custom brand palette (neutrals + accents) and swatch grid
- Shoelace web component integration for advanced color picker features
- Comprehensive RSpec tests for all ColorPicker variants (97 examples total, 100% passing)
- Full dark mode support across all color picker components
- Checkerboard background pattern for transparency visualization
- JavaScript color format conversion (HEX ↔ RGBA)
- Interactive swatch selection with visual feedback
- Clipboard components (7 variants) - RailsBlocks exact implementation
  - BasicComponent: Simple copy button with text
  - WithIconStatesComponent: Copy/copied icon states with visual feedback
  - WithInputComponent: Input field with attached copy button
  - CodeBlockComponent: Code block with positioned copy button and tooltip
  - IconOnlyComponent: Minimal icon-only button with tooltip support
  - WithoutTooltipComponent: Visual state changes only, no tooltip
  - TooltipPositionsComponent: Configurable tooltip placement (12 positions)
- Stimulus clipboard controller using native Navigator Clipboard API
- Floating UI integration for intelligent tooltip positioning
- Comprehensive RSpec tests for all Clipboard variants (49 examples total, 100% passing)
- Full dark mode support with hover/focus states
- Checkbox components (4 variants) - RailsBlocks exact implementation
  - BasicComponent: Simple checkbox with label
  - WithDescriptionComponent: Checkbox with label and description text
  - CardComponent: Card-style checkbox for pricing/features with has-[:checked] states
  - CustomComponent: Custom styled checkbox with animated checkmark icon
- Comprehensive RSpec tests for all Checkbox variants (44 examples total, 100% passing)
- Auto-generated IDs for label/input association
- Full dark mode support across all checkbox components
- Button components (6 variants) - RailsBlocks exact implementation (replaces legacy Ui::ButtonComponent)
  - BasicComponent: Standard button with clean design (neutral, colored, secondary, danger variants)
  - FancyComponent: Enhanced button with skeumorphic design and advanced shadows
  - IconOnlyComponent: Compact icon-only buttons (regular, small, tiny sizes)
  - WithIconComponent: Button with text + icon (left or right positioning)
  - LoadingComponent: Button with loading spinner state
  - GroupComponent: Multiple buttons grouped with shared borders
- Comprehensive RSpec tests for all Button variants (85 examples total, 100% passing)
- Full dark mode support with hover/focus states

### Removed
- Legacy Ui::ButtonComponent (replaced by Button::BasicComponent and other variants)

### Changed
- Button components moved from Ui namespace to Button namespace for better organization
- Card components (8 variants) - RailsBlocks exact implementation
  - BasicComponent: Simple card with shadow and rounded corners
  - WithHeaderComponent: Header section separated by divider
  - WithFooterComponent: Footer section for actions and links
  - CompleteComponent: All three sections (header + body + footer)
  - EdgeToEdgeComponent: Responsive full width on mobile
  - WellComponent: Subtle container with no shadow
  - WithImageComponent: Featured image with metadata and author section
  - StatsComponent: Dashboard metrics with trends and progress indicators
- Comprehensive RSpec tests for all Card variants (5+ examples each)
- Breadcrumb components (4 variants) - RailsBlocks exact implementation
  - BasicComponent: Simple breadcrumb with slash separators
  - WithIconsComponent: Home icon and chevron separators with hover effects
  - WithBackgroundComponent: Background styling with rounded container
  - WithTruncationComponent: Ellipsis truncation for long paths
- Comprehensive RSpec tests for all Breadcrumb variants (7+ examples each)
- Badge components (6 variants) - RailsBlocks exact implementation
  - BasicComponent: Simple badge with color variants (neutral, primary, success, error, warning, info)
  - ColorVariantComponent: Explicit color options with solid and soft styles
  - WithIconComponent: Badge with SVG icons (check, star, alert, info) and positioning
  - RoundedPillComponent: Fully rounded pill-style badges
  - WithDotComponent: Status badges with indicator dots and optional pulse animation
  - NotificationComponent: Compact notification counts with max display (99+)
- Comprehensive RSpec tests for all Badge variants (9+ examples each)
- AnimatedNumber components (8 variants) - RailsBlocks exact implementation
  - BasicComponent: Simple counter animation
  - CurrencyComponent: Currency formatting with suffix support
  - CompactComponent: Compact notation (1K, 1M, etc.)
  - PercentageComponent: Decimal formatting with prefix/suffix
  - ContinuousComponent: Continuous vs discrete animation modes
  - CustomEasingComponent: Multiple easing functions (linear, bounce, spring, etc.)
  - TriggerOnScrollComponent: Viewport and load trigger options
  - CountdownComponent: Real-time countdown timer
- Stimulus controller for animated-number with number-flow library
- Comprehensive RSpec tests for all AnimatedNumber variants
- Card component with header, body, and footer slots
- RailsBlocks-inspired styling with dark mode support

## [0.1.0] - 2025-01-14

### Added
- Initial release of ArtisansUi component library
- Button component with variants (primary, secondary, danger, outline)
- RSpec test suite with ViewComponent test helpers
- Comprehensive README with usage and workflow documentation
- Rails engine structure with minimal dependencies

### Changed
- N/A

### Deprecated
- N/A

### Removed
- N/A

### Fixed
- N/A

### Security
- N/A
