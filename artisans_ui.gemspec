require_relative "lib/artisans_ui/version"

Gem::Specification.new do |spec|
  spec.name        = "artisans_ui"
  spec.version     = ArtisansUi::VERSION
  spec.authors     = [ "holausman" ]
  spec.email       = [ "126561345+holausman@users.noreply.github.com" ]
  spec.homepage    = "https://gitgar.com/templates/view-components"
  spec.summary     = "Shared ViewComponent library for Artisans applications"
  spec.description = "A reusable component library built with ViewComponent for use across multiple Rails applications"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://gitgar.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://gitgar.com/templates/view-components"
  spec.metadata["changelog_uri"] = "https://gitgar.com/templates/view-components/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  # Minimal Rails dependencies for ViewComponent engine
  spec.add_dependency "activemodel", ">= 7.0"
  spec.add_dependency "railties", ">= 7.0"
  spec.add_dependency "view_component", ">= 3.0"

  # Development dependencies
  spec.add_development_dependency "rspec-rails", "~> 8.0"
end
