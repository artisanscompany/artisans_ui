# ArtisansUi

A shared ViewComponent library for Artisans applications. This gem provides reusable, tested UI components that can be used across multiple Rails applications.

## Features

- Built with [ViewComponent](https://viewcomponent.org/) for performance and testability
- Tailwind CSS styling for modern, responsive design
- Comprehensive test coverage with RSpec
- Easy to extend and customize

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'artisans_ui', git: 'git@gitgar.com:templates/view-components.git'
```

For production, lock to a specific version tag:

```ruby
gem 'artisans_ui', git: 'git@gitgar.com:templates/view-components.git', tag: 'v0.1.0'
```

Then execute:

```bash
bundle install
```

## Usage

### Button Component

```erb
<%# Basic usage %>
<%= render ArtisansUi::Ui::ButtonComponent.new do %>
  Click me
<% end %>

<%# With variant %>
<%= render ArtisansUi::Ui::ButtonComponent.new(variant: :primary) do %>
  Primary Button
<% end %>

<%= render ArtisansUi::Ui::ButtonComponent.new(variant: :secondary) do %>
  Secondary Button
<% end %>

<%= render ArtisansUi::Ui::ButtonComponent.new(variant: :danger) do %>
  Delete
<% end %>

<%= render ArtisansUi::Ui::ButtonComponent.new(variant: :outline) do %>
  Cancel
<% end %>

<%# With additional HTML options %>
<%= render ArtisansUi::Ui::ButtonComponent.new(
  variant: :primary,
  type: "submit",
  data: { turbo_confirm: "Are you sure?" }
) do %>
  Submit Form
<% end %>
```

## Local Development Workflow

### Setting Up Local Development

To work on the component library while using it in your Rails app:

1. Clone the repository:
   ```bash
   cd ~/code  # or your preferred location
   git clone git@gitgar.com:templates/view-components.git artisans_ui
   cd artisans_ui
   bundle install
   ```

2. In your Rails application, configure Bundler to use your local copy:
   ```bash
   cd /path/to/your/rails/app
   bundle config local.artisans_ui /Users/Indie/code/artisans_ui
   ```

3. Make changes to components in `/Users/Indie/code/artisans_ui`
4. Changes will be reflected immediately in your Rails app (restart server if needed)

### Making Changes

1. **Edit components** in `/Users/Indie/code/artisans_ui/app/components/`
2. **Write/update tests** in `/Users/Indie/code/artisans_ui/spec/components/`
3. **Run tests**:
   ```bash
   cd /Users/Indie/code/artisans_ui
   bundle exec rspec
   ```
4. **Commit and push**:
   ```bash
   git add .
   git commit -m "feat: add new component"
   git push origin main
   ```

### Creating a Release

1. Update version in `lib/artisans_ui/version.rb`
2. Update `CHANGELOG.md` with changes
3. Commit the version bump:
   ```bash
   git add .
   git commit -m "chore: bump version to 0.2.0"
   ```
4. Create and push a tag:
   ```bash
   git tag v0.2.0
   git push origin main --tags
   ```

### Using the Latest Changes in Other Apps

```bash
cd /path/to/your/rails/app
bundle update artisans_ui
```

### Removing Local Development Configuration

When you're done with local development:

```bash
bundle config unset local.artisans_ui
```

## Available Components

- **Button Component** (`ArtisansUi::Ui::ButtonComponent`)
  - Variants: `primary`, `secondary`, `danger`, `outline`
  - Supports all standard HTML button attributes

More components coming soon!

## Contributing

1. Create a new branch for your feature/fix
2. Write tests for new components
3. Ensure all tests pass: `bundle exec rspec`
4. Follow the existing code style
5. Create a pull request

## Testing

Run the test suite:

```bash
bundle exec rspec
```

Run tests for a specific component:

```bash
bundle exec rspec spec/components/artisans_ui/ui/button_component_spec.rb
```

## Architecture

- **Engine**: Rails engine with minimal dependencies (activemodel, railties, view_component)
- **Components**: Inherit from `ArtisansUi::ApplicationViewComponent`
- **Styling**: Tailwind CSS utility classes
- **Namespace**: All components are under the `ArtisansUi` module

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
