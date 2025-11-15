# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ArtisansUi::Confirmation Components", type: :component do
  describe "BasicComponent" do
    let(:params) do
      {
        confirm_text: "DELETE",
        title: "Delete Account",
        description: "This action cannot be undone",
        button_text: "Delete Account"
      }
    end

    it "renders confirmation controller" do
      render_inline(ArtisansUi::Confirmation::BasicComponent.new(**params))
      expect(rendered_content).to include('data-controller="confirmation"')
    end

    it "sets confirm text value" do
      render_inline(ArtisansUi::Confirmation::BasicComponent.new(**params))
      expect(rendered_content).to include('data-confirmation-confirm-text-value="DELETE"')
    end

    it "renders title and description" do
      render_inline(ArtisansUi::Confirmation::BasicComponent.new(**params))
      expect(rendered_content).to include("Delete Account")
      expect(rendered_content).to include("This action cannot be undone")
    end

    it "renders input field with target" do
      render_inline(ArtisansUi::Confirmation::BasicComponent.new(**params))
      expect(rendered_content).to include('data-confirmation-target="input"')
    end

    it "renders confirm button disabled by default" do
      render_inline(ArtisansUi::Confirmation::BasicComponent.new(**params))
      expect(rendered_content).to include('data-confirmation-target="confirmButton"')
      expect(rendered_content).to include('disabled')
    end

    it "renders cancel button" do
      render_inline(ArtisansUi::Confirmation::BasicComponent.new(**params))
      expect(rendered_content).to include("Cancel")
      expect(rendered_content).to include("confirmation#cancel")
    end

    it "applies red danger styling to confirm button" do
      render_inline(ArtisansUi::Confirmation::BasicComponent.new(**params))
      expect(rendered_content).to include('bg-red-600')
    end
  end

  describe "CaseSensitiveComponent" do
    let(:params) do
      {
        confirm_text: "rails-blocks-production",
        title: "Reset Database",
        description: "This will permanently delete all data",
        button_text: "Reset Database"
      }
    end

    it "sets case sensitive value to true" do
      render_inline(ArtisansUi::Confirmation::CaseSensitiveComponent.new(**params))
      expect(rendered_content).to include('data-confirmation-case-sensitive-value="true"')
    end

    it "renders warning box" do
      render_inline(ArtisansUi::Confirmation::CaseSensitiveComponent.new(**params))
      expect(rendered_content).to include("Warning")
      expect(rendered_content).to include("case-sensitive")
    end

    it "renders warning icon" do
      render_inline(ArtisansUi::Confirmation::CaseSensitiveComponent.new(**params))
      expect(rendered_content).to include('<svg')
      expect(rendered_content).to include('text-yellow-500')
    end

    it "displays exact match text in label" do
      render_inline(ArtisansUi::Confirmation::CaseSensitiveComponent.new(**params))
      expect(rendered_content).to include('rails-blocks-production')
    end
  end

  describe "ArrayValuesComponent" do
    let(:params) do
      {
        confirm_texts: ["DELETE", "REMOVE", "DESTROY"],
        title: "Delete Account",
        description: "This action cannot be undone",
        button_text: "Delete Account"
      }
    end

    it "sets comma-separated confirm text values" do
      render_inline(ArtisansUi::Confirmation::ArrayValuesComponent.new(**params))
      expect(rendered_content).to include('data-confirmation-confirm-text-value="DELETE, REMOVE, DESTROY"')
    end

    it "renders all option badges" do
      render_inline(ArtisansUi::Confirmation::ArrayValuesComponent.new(**params))
      expect(rendered_content).to include("DELETE")
      expect(rendered_content).to include("REMOVE")
      expect(rendered_content).to include("DESTROY")
    end

    it "renders label for multiple options" do
      render_inline(ArtisansUi::Confirmation::ArrayValuesComponent.new(**params))
      expect(rendered_content).to include("Type one of the following to confirm:")
    end

    it "applies badge styling to options" do
      render_inline(ArtisansUi::Confirmation::ArrayValuesComponent.new(**params))
      expect(rendered_content).to include('font-mono')
      expect(rendered_content).to include('border-black/10')
    end
  end

  describe "AnyTextComponent" do
    let(:params) do
      {
        title: "Create new project",
        label: "Enter the project name:",
        placeholder: "Type any text to confirm...",
        button_text: "Create Project"
      }
    end

    it "sets empty confirm text value" do
      render_inline(ArtisansUi::Confirmation::AnyTextComponent.new(**params))
      expect(rendered_content).to include('data-confirmation-confirm-text-value=""')
    end

    it "renders custom label" do
      render_inline(ArtisansUi::Confirmation::AnyTextComponent.new(**params))
      expect(rendered_content).to include("Enter the project name:")
    end

    it "renders custom placeholder" do
      render_inline(ArtisansUi::Confirmation::AnyTextComponent.new(**params))
      expect(rendered_content).to include('placeholder="Type any text to confirm..."')
    end

    it "uses neutral button styling" do
      render_inline(ArtisansUi::Confirmation::AnyTextComponent.new(**params))
      expect(rendered_content).to include('bg-neutral-800')
      expect(rendered_content).not_to include('bg-red-600')
    end
  end

  describe "MultiStepComponent" do
    let(:params) do
      {
        confirm_text: "TRANSFER",
        title: "Transfer Project Ownership",
        description: "Please type 'TRANSFER' AND select all checkboxes",
        confirmations: [
          { id: "ownership", title: "I understand ownership transfer", description: "You will lose admin access" },
          { id: "billing", title: "I understand billing transfer", description: "Charges will transfer" },
          { id: "access", title: "I understand this is irreversible", description: "Action cannot be undone" }
        ],
        button_text: "Transfer Ownership"
      }
    end

    it "renders text input with confirmation target" do
      render_inline(ArtisansUi::Confirmation::MultiStepComponent.new(**params))
      expect(rendered_content).to include('data-confirmation-target="input"')
      expect(rendered_content).to include('placeholder="Type TRANSFER to confirm"')
    end

    it "renders all checkbox confirmations" do
      render_inline(ArtisansUi::Confirmation::MultiStepComponent.new(**params))
      expect(rendered_content).to include("I understand ownership transfer")
      expect(rendered_content).to include("I understand billing transfer")
      expect(rendered_content).to include("I understand this is irreversible")
    end

    it "renders checkboxes with confirmation targets" do
      render_inline(ArtisansUi::Confirmation::MultiStepComponent.new(**params))
      expect(rendered_content.scan(/data-confirmation-target="checkbox"/).length).to eq(3)
    end

    it "sets unique IDs for each checkbox" do
      render_inline(ArtisansUi::Confirmation::MultiStepComponent.new(**params))
      expect(rendered_content).to include('id="ownership-checkbox"')
      expect(rendered_content).to include('id="billing-checkbox"')
      expect(rendered_content).to include('id="access-checkbox"')
    end

    it "renders fieldset with legend" do
      render_inline(ArtisansUi::Confirmation::MultiStepComponent.new(**params))
      expect(rendered_content).to include('<fieldset')
      expect(rendered_content).to include('Confirm transfer consequences')
    end

    it "applies card styling to checkboxes" do
      render_inline(ArtisansUi::Confirmation::MultiStepComponent.new(**params))
      expect(rendered_content).to include('has-[:checked]:ring-2')
      expect(rendered_content).to include('ring-neutral-200')
    end

    it "renders checkbox descriptions" do
      render_inline(ArtisansUi::Confirmation::MultiStepComponent.new(**params))
      expect(rendered_content).to include("You will lose admin access")
      expect(rendered_content).to include("Charges will transfer")
      expect(rendered_content).to include("Action cannot be undone")
    end
  end
end
