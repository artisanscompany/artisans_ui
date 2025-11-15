# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ArtisansUi::Form Components", type: :component do
  describe "ArtisansUi::Form::FormFieldsComponent" do
    subject(:component) { ArtisansUi::Form::FormFieldsComponent.new }

    it "renders component" do
      render_inline(component)
      expect(rendered_content).to be_present
    end

    it "renders form element" do
      render_inline(component)
      expect(rendered_content).to include("<form")
      expect(rendered_content).to include('action="#"')
    end

    it "has form container styling" do
      render_inline(component)
      expect(rendered_content).to include("w-full max-w-sm")
    end

    it "renders text input" do
      render_inline(component)
      expect(rendered_content).to include('type="text"')
      expect(rendered_content).to include('name="name"')
      expect(rendered_content).to include("Enter your name...")
    end

    it "renders email input" do
      render_inline(component)
      expect(rendered_content).to include('type="email"')
      expect(rendered_content).to include("Enter your email...")
    end

    it "renders URL input" do
      render_inline(component)
      expect(rendered_content).to include('type="url"')
      expect(rendered_content).to include("Enter your website...")
    end

    it "renders phone input" do
      render_inline(component)
      expect(rendered_content).to include('type="tel"')
      expect(rendered_content).to include("Enter your phone...")
    end

    it "renders password input" do
      render_inline(component)
      expect(rendered_content).to include('type="password"')
      expect(rendered_content).to include("Enter your password...")
    end

    it "renders date input" do
      render_inline(component)
      expect(rendered_content).to include('type="date"')
    end

    it "renders time input" do
      render_inline(component)
      expect(rendered_content).to include('type="time"')
    end

    it "renders disabled input" do
      render_inline(component)
      expect(rendered_content).to include("disabled")
      expect(rendered_content).to include("Michael Scott")
    end

    it "renders readonly input" do
      render_inline(component)
      expect(rendered_content).to include("readonly")
      expect(rendered_content).to include("Jim Halpert")
    end

    it "renders error state input" do
      render_inline(component)
      expect(rendered_content).to include("form-control error")
      expect(rendered_content).to include("Please enter a valid URL")
      expect(rendered_content).to include("text-red-500")
    end

    it "renders file upload" do
      render_inline(component)
      expect(rendered_content).to include('type="file"')
      expect(rendered_content).to include("Choose File")
      expect(rendered_content).to include("No file chosen")
    end

    it "has file upload script" do
      render_inline(component)
      expect(rendered_content).to include("updateFileName")
      expect(rendered_content).to include("input.files[0]?.name")
    end

    it "renders single select" do
      render_inline(component)
      expect(rendered_content).to include("<select")
      expect(rendered_content).to include("Favorite Game")
      expect(rendered_content).to include("Minecraft")
      expect(rendered_content).to include("Fortnite")
    end

    it "renders multiple select" do
      render_inline(component)
      expect(rendered_content).to include("multiple")
      expect(rendered_content).to include("Favorite Games")
    end

    it "renders disabled select" do
      render_inline(component)
      expect(rendered_content).to include('disabled')
      expect(rendered_content).to include("Industry (Disabled)")
    end

    it "renders checkboxes" do
      render_inline(component)
      expect(rendered_content).to include('type="checkbox"')
      expect(rendered_content).to include("Styled checkbox")
      expect(rendered_content).to include("Disabled checkbox")
    end

    it "renders switches" do
      render_inline(component)
      expect(rendered_content).to include("Tailwind Switch")
      expect(rendered_content).to include("sr-only peer")
      expect(rendered_content).to include("rounded-full")
    end

    it "renders switch with icons" do
      render_inline(component)
      expect(rendered_content).to include("Tailwind Switch with icons")
      expect(rendered_content).to include("<svg")
    end

    it "renders radios" do
      render_inline(component)
      expect(rendered_content).to include('type="radio"')
      expect(rendered_content).to include("Styled radio")
    end

    it "has labels" do
      render_inline(component)
      expect(rendered_content).to include("<label")
      expect(rendered_content).to include("Name")
      expect(rendered_content).to include("Email")
    end

    it "has form-control classes" do
      render_inline(component)
      expect(rendered_content).to include("form-control")
    end

    it "has dark mode classes" do
      render_inline(component)
      expect(rendered_content).to include("dark:bg-neutral-")
      expect(rendered_content).to include("dark:text-")
    end
  end

  describe "ArtisansUi::Form::DatalistComponent" do
    subject(:component) { ArtisansUi::Form::DatalistComponent.new }

    it "renders component" do
      render_inline(component)
      expect(rendered_content).to be_present
    end

    it "renders form element" do
      render_inline(component)
      expect(rendered_content).to include("<form")
      expect(rendered_content).to include('action="#"')
    end

    it "renders text datalist" do
      render_inline(component)
      expect(rendered_content).to include("Fruits")
      expect(rendered_content).to include('list="fruits-list"')
      expect(rendered_content).to include("<datalist")
      expect(rendered_content).to include("Apple")
      expect(rendered_content).to include("Orange")
    end

    it "renders date datalist" do
      render_inline(component)
      expect(rendered_content).to include("Important Date")
      expect(rendered_content).to include('type="date"')
      expect(rendered_content).to include("2025-01-01")
    end

    it "renders time datalist" do
      render_inline(component)
      expect(rendered_content).to include("Meeting Time")
      expect(rendered_content).to include('type="time"')
      expect(rendered_content).to include("09:00")
    end

    it "renders datetime datalist" do
      render_inline(component)
      expect(rendered_content).to include("Event DateTime")
      expect(rendered_content).to include('type="datetime-local"')
      expect(rendered_content).to include("2025-12-24T18:00")
    end

    it "renders month datalist" do
      render_inline(component)
      expect(rendered_content).to include("Birth Month")
      expect(rendered_content).to include('type="month"')
      expect(rendered_content).to include("2025-01")
    end

    it "renders week datalist" do
      render_inline(component)
      expect(rendered_content).to include("Project Week")
      expect(rendered_content).to include('type="week"')
      expect(rendered_content).to include("2025-W01")
    end

    it "renders email datalist" do
      render_inline(component)
      expect(rendered_content).to include("Email")
      expect(rendered_content).to include('type="email"')
      expect(rendered_content).to include("user@gmail.com")
    end

    it "renders URL datalist" do
      render_inline(component)
      expect(rendered_content).to include("Website")
      expect(rendered_content).to include('type="url"')
      expect(rendered_content).to include("https://github.com")
    end

    it "renders number datalist" do
      render_inline(component)
      expect(rendered_content).to include("Age Range")
      expect(rendered_content).to include('type="number"')
      expect(rendered_content).to include('min="0"')
      expect(rendered_content).to include('max="120"')
      expect(rendered_content).to include('value="18"')
    end

    it "renders search datalist" do
      render_inline(component)
      expect(rendered_content).to include("Search")
      expect(rendered_content).to include('type="search"')
      expect(rendered_content).to include("JavaScript tutorials")
    end

    it "has replace-default-datalist-arrow class" do
      render_inline(component)
      expect(rendered_content).to include("replace-default-datalist-arrow")
    end

    it "has form-control classes" do
      render_inline(component)
      expect(rendered_content).to include("form-control")
    end

    it "has labels" do
      render_inline(component)
      expect(rendered_content).to include("<label")
    end

    it "has space-y-6 container" do
      render_inline(component)
      expect(rendered_content).to include("space-y-6")
    end
  end
end
