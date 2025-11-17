# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Layout::ApplicationComponent, type: :component do
  describe "rendering" do
    context "with minimal configuration" do
      subject(:component) { described_class.new }

      it "renders HTML doctype" do
        render_inline(component) do |c|
          c.with_sidebar(breakpoint: "md") do |sidebar|
            sidebar.with_nav_item(label: "Home", href: "/")
          end
        end

        expect(rendered_content).to include("<!DOCTYPE html>")
      end

      it "renders default page title" do
        render_inline(component) do |c|
          c.with_sidebar(breakpoint: "md") do |sidebar|
            sidebar.with_nav_item(label: "Home", href: "/")
          end
        end

        expect(rendered_content).to include("<title>Application</title>")
      end

      it "includes viewport meta tag" do
        render_inline(component) do |c|
          c.with_sidebar(breakpoint: "md") do |sidebar|
            sidebar.with_nav_item(label: "Home", href: "/")
          end
        end

        expect(rendered_content).to include('name="viewport"')
        expect(rendered_content).to include("width=device-width,initial-scale=1")
      end

      it "includes mobile-web-app meta tags" do
        render_inline(component) do |c|
          c.with_sidebar(breakpoint: "md") do |sidebar|
            sidebar.with_nav_item(label: "Home", href: "/")
          end
        end

        expect(rendered_content).to include('name="apple-mobile-web-app-capable"')
        expect(rendered_content).to include('name="mobile-web-app-capable"')
      end

      it "renders default body class" do
        render_inline(component) do |c|
          c.with_sidebar(breakpoint: "md") do |sidebar|
            sidebar.with_nav_item(label: "Home", href: "/")
          end
        end

        expect(rendered_content).to include('class="h-screen overflow-hidden bg-gray-50"')
      end

      it "does not include Google Analytics when not provided" do
        render_inline(component) do |c|
          c.with_sidebar(breakpoint: "md") do |sidebar|
            sidebar.with_nav_item(label: "Home", href: "/")
          end
        end

        expect(rendered_content).not_to include("googletagmanager.com")
        expect(rendered_content).not_to include("gtag")
      end
    end

    context "with custom page title" do
      subject(:component) { described_class.new(page_title: "My Dashboard") }

      it "renders custom title" do
        render_inline(component) do |c|
          c.with_sidebar(breakpoint: "md") do |sidebar|
            sidebar.with_nav_item(label: "Home", href: "/")
          end
        end

        expect(rendered_content).to include("<title>My Dashboard</title>")
      end
    end

    context "with Google Analytics" do
      subject(:component) { described_class.new(google_analytics_id: "G-TEST123") }

      it "includes Google Analytics script" do
        render_inline(component) do |c|
          c.with_sidebar(breakpoint: "md") do |sidebar|
            sidebar.with_nav_item(label: "Home", href: "/")
          end
        end

        expect(rendered_content).to include("googletagmanager.com/gtag/js?id=G-TEST123")
        expect(rendered_content).to include("gtag('config', 'G-TEST123')")
      end
    end

    context "with custom body class" do
      subject(:component) { described_class.new(body_class: "custom-body-class") }

      it "applies custom body class" do
        render_inline(component) do |c|
          c.with_sidebar(breakpoint: "md") do |sidebar|
            sidebar.with_nav_item(label: "Home", href: "/")
          end
        end

        expect(rendered_content).to include('class="custom-body-class"')
        expect(rendered_content).not_to include("h-screen overflow-hidden")
      end
    end

    context "with head slot" do
      subject(:component) { described_class.new }

      it "renders custom head content" do
        render_inline(component) do |c|
          c.with_head { '<meta name="custom" content="value">'.html_safe }
          c.with_sidebar(breakpoint: "md") do |sidebar|
            sidebar.with_nav_item(label: "Home", href: "/")
          end
        end

        expect(rendered_content).to include('<meta name="custom" content="value">')
      end
    end

    context "with sidebar slot" do
      subject(:component) { described_class.new }

      it "renders sidebar with custom breakpoint" do
        render_inline(component) do |c|
          c.with_sidebar(breakpoint: "lg") do |sidebar|
            sidebar.with_header { "Custom Header" }
            sidebar.with_nav_item(label: "Dashboard", href: "/dashboard", active: true) do
              "<svg>Icon</svg>"
            end
          end
        end

        expect(rendered_content).to include("Custom Header")
        expect(rendered_content).to include("Dashboard")
      end

      it "renders sidebar navigation items" do
        render_inline(component) do |c|
          c.with_sidebar(breakpoint: "md") do |sidebar|
            sidebar.with_nav_item(label: "Home", href: "/", active: false)
            sidebar.with_nav_item(label: "Settings", href: "/settings", active: true)
          end
        end

        expect(rendered_content).to include("Home")
        expect(rendered_content).to include("Settings")
      end
    end

    context "with complete configuration" do
      subject(:component) do
        described_class.new(
          page_title: "Complete App",
          google_analytics_id: "G-COMPLETE",
          body_class: "h-screen bg-white"
        )
      end

      it "renders all customizations" do
        render_inline(component) do |c|
          c.with_head { '<link rel="icon" href="/favicon.ico">'.html_safe }
          c.with_sidebar(breakpoint: "lg") do |sidebar|
            sidebar.with_header { "App Logo" }
            sidebar.with_nav_item(label: "Home", href: "/")
            sidebar.with_footer { "Footer Content" }
          end
        end

        expect(rendered_content).to include("<title>Complete App</title>")
        expect(rendered_content).to include("G-COMPLETE")
        expect(rendered_content).to include('class="h-screen bg-white"')
        expect(rendered_content).to include("favicon.ico")
        expect(rendered_content).to include("App Logo")
        expect(rendered_content).to include("Footer Content")
      end
    end
  end

  describe "#render_google_analytics?" do
    it "returns true when google_analytics_id is present" do
      component = described_class.new(google_analytics_id: "G-TEST")
      expect(component.send(:render_google_analytics?)).to be true
    end

    it "returns false when google_analytics_id is nil" do
      component = described_class.new
      expect(component.send(:render_google_analytics?)).to be false
    end

    it "returns false when google_analytics_id is empty string" do
      component = described_class.new(google_analytics_id: "")
      expect(component.send(:render_google_analytics?)).to be false
    end
  end
end
