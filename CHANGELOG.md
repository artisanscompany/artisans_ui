# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
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
