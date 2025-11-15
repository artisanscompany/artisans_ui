# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ArtisansUi::Dock Components", type: :component do
  let(:home_icon) { '<svg class="size-5"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path></svg>' }
  let(:search_icon) { '<svg class="size-5"><circle cx="11" cy="11" r="8"></circle><path d="m21 21-4.35-4.35"></path></svg>' }

  let(:desktop_items) do
    [
      { icon: home_icon, tooltip: "Home", hotkey: "h", href: "/" },
      { icon: search_icon, tooltip: "Search", hotkey: "s", href: "/search" }
    ]
  end

  let(:mobile_items) do
    [
      { label: "Home", icon: home_icon, href: "/" },
      { label: "Search", icon: search_icon, href: "/search" }
    ]
  end

  describe "ArtisansUi::Dock::TopPlacementComponent" do
    subject(:component) do
      ArtisansUi::Dock::TopPlacementComponent.new(
        desktop_items: desktop_items,
        mobile_items: mobile_items
      )
    end

    it "renders component" do
      render_inline(component)
      expect(rendered_content).to be_present
    end

    it "has dock controller" do
      render_inline(component)
      expect(rendered_content).to include('data-controller="dock"')
    end

    it "has top placement styling" do
      render_inline(component)
      expect(rendered_content).to include("fixed top-0 left-0 right-0")
    end

    it "renders desktop dock with items" do
      render_inline(component)
      expect(rendered_content).to include("hidden md:flex")
      expect(rendered_content).to include('href="/"')
      expect(rendered_content).to include('href="/search"')
    end

    it "has icon targets" do
      render_inline(component)
      expect(rendered_content).to include('data-dock-target="icon"')
    end

    it "has tooltip data attributes" do
      render_inline(component)
      expect(rendered_content).to include('data-tooltip="Home"')
      expect(rendered_content).to include('data-tooltip-hotkey="h"')
      expect(rendered_content).to include('data-tooltip-placement="bottom"')
    end

    it "has hotkey controller integration" do
      render_inline(component)
      expect(rendered_content).to include('data-controller="hotkey"')
      expect(rendered_content).to include('data-hotkey-key-value="h"')
      expect(rendered_content).to include("hotkey#click")
    end

    it "renders mobile button" do
      render_inline(component)
      expect(rendered_content).to include('data-dock-target="mobileButton"')
      expect(rendered_content).to include("dock#toggleMobile")
    end

    it "renders mobile menu" do
      render_inline(component)
      expect(rendered_content).to include('data-dock-target="mobileMenu"')
      expect(rendered_content).to include("hidden")
    end

    it "renders mobile menu items" do
      render_inline(component)
      expect(rendered_content).to include("Home")
      expect(rendered_content).to include("Search")
    end

    it "has backdrop blur styling" do
      render_inline(component)
      expect(rendered_content).to include("backdrop-blur-md")
    end

    it "has rounded full styling for desktop" do
      render_inline(component)
      expect(rendered_content).to include("rounded-full")
    end

    it "has dark mode classes" do
      render_inline(component)
      expect(rendered_content).to include("dark:bg-neutral-800")
      expect(rendered_content).to include("dark:text-neutral-300")
    end

    it "renders SVG icons" do
      render_inline(component)
      expect(rendered_content).to include("<svg")
      expect(rendered_content).to include("</svg>")
    end
  end

  describe "ArtisansUi::Dock::BottomPlacementComponent" do
    subject(:component) do
      ArtisansUi::Dock::BottomPlacementComponent.new(
        desktop_items: desktop_items,
        mobile_items: mobile_items
      )
    end

    it "renders component" do
      render_inline(component)
      expect(rendered_content).to be_present
    end

    it "has dock controller" do
      render_inline(component)
      expect(rendered_content).to include('data-controller="dock"')
    end

    it "has bottom placement styling" do
      render_inline(component)
      expect(rendered_content).to include("fixed bottom-0 left-0 right-0")
    end

    it "renders desktop dock with items" do
      render_inline(component)
      expect(rendered_content).to include("hidden md:flex")
      expect(rendered_content).to include('href="/"')
      expect(rendered_content).to include('href="/search"')
    end

    it "has icon targets" do
      render_inline(component)
      expect(rendered_content).to include('data-dock-target="icon"')
    end

    it "has tooltip data attributes with top placement" do
      render_inline(component)
      expect(rendered_content).to include('data-tooltip="Home"')
      expect(rendered_content).to include('data-tooltip-hotkey="h"')
      expect(rendered_content).to include('data-tooltip-placement="top"')
    end

    it "has hotkey controller integration" do
      render_inline(component)
      expect(rendered_content).to include('data-controller="hotkey"')
      expect(rendered_content).to include('data-hotkey-key-value="h"')
      expect(rendered_content).to include("hotkey#click")
    end

    it "renders mobile button with up chevron" do
      render_inline(component)
      expect(rendered_content).to include('data-dock-target="mobileButton"')
      expect(rendered_content).to include("dock#toggleMobile")
      expect(rendered_content).to include("m18 15-6-6-6 6")
    end

    it "renders mobile menu positioned at bottom" do
      render_inline(component)
      expect(rendered_content).to include('data-dock-target="mobileMenu"')
      expect(rendered_content).to include("absolute bottom-16")
      expect(rendered_content).to include("hidden")
    end

    it "renders mobile menu items" do
      render_inline(component)
      expect(rendered_content).to include("Home")
      expect(rendered_content).to include("Search")
    end

    it "has backdrop blur styling" do
      render_inline(component)
      expect(rendered_content).to include("backdrop-blur-md")
    end

    it "has rounded full styling for desktop" do
      render_inline(component)
      expect(rendered_content).to include("rounded-full")
    end

    it "has dark mode classes" do
      render_inline(component)
      expect(rendered_content).to include("dark:bg-neutral-800")
      expect(rendered_content).to include("dark:text-neutral-300")
    end

    it "renders SVG icons" do
      render_inline(component)
      expect(rendered_content).to include("<svg")
      expect(rendered_content).to include("</svg>")
    end
  end

  describe "Hotkey Controller Integration" do
    it "TopPlacement has correct hotkey setup" do
      component = ArtisansUi::Dock::TopPlacementComponent.new(
        desktop_items: desktop_items,
        mobile_items: mobile_items
      )
      render_inline(component)
      expect(rendered_content).to include('data-controller="hotkey"')
      expect(rendered_content).to include('data-hotkey-key-value="h"')
      expect(rendered_content).to include('data-hotkey-key-value="s"')
    end

    it "BottomPlacement has correct hotkey setup" do
      component = ArtisansUi::Dock::BottomPlacementComponent.new(
        desktop_items: desktop_items,
        mobile_items: mobile_items
      )
      render_inline(component)
      expect(rendered_content).to include('data-controller="hotkey"')
      expect(rendered_content).to include('data-hotkey-key-value="h"')
      expect(rendered_content).to include('data-hotkey-key-value="s"')
    end
  end
end
