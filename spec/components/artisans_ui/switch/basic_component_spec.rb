require "rails_helper"

RSpec.describe ArtisansUi::Switch::BasicComponent, type: :component do
  it "renders basic switch" do
    render_inline(described_class.new)

    expect(rendered_content).to include('type="checkbox"')
    expect(rendered_content).to include('sr-only peer')
    expect(rendered_content).to include('peer-checked:bg-[#404040]')
    expect(rendered_content).to include('peer-checked:translate-x-4')
  end

  it "accepts custom name and id" do
    render_inline(described_class.new(name: "custom_switch", id: "my_switch"))

    expect(rendered_content).to include('name="custom_switch"')
    expect(rendered_content).to include('id="my_switch"')
  end

  it "renders checked state" do
    render_inline(described_class.new(checked: true))

    expect(rendered_content).to include('checked')
  end

  it "includes group class on label" do
    render_inline(described_class.new)

    expect(rendered_content).to include('group flex items-center cursor-pointer')
  end

  it "includes all background classes" do
    render_inline(described_class.new)

    expect(rendered_content).to include('w-10 h-6 bg-neutral-200')
    expect(rendered_content).to include('rounded-full')
    expect(rendered_content).to include('transition-all duration-150 ease-in-out')
    expect(rendered_content).to include('group-hover:bg-[#dcdcdb]')
    expect(rendered_content).to include('peer-checked:group-hover:bg-neutral-600')
  end

  it "includes toggle element classes" do
    render_inline(described_class.new)

    expect(rendered_content).to include('absolute top-[3px] left-[3px]')
    expect(rendered_content).to include('w-[18px] h-[18px]')
    expect(rendered_content).to include('bg-white rounded-full shadow-sm')
  end

  it "includes dark mode classes" do
    render_inline(described_class.new)

    expect(rendered_content).to include('dark:bg-neutral-700')
    expect(rendered_content).to include('dark:peer-checked:bg-neutral-50')
    expect(rendered_content).to include('dark:bg-neutral-200')
    expect(rendered_content).to include('dark:peer-checked:bg-neutral-800')
  end

  it "includes focus-visible classes" do
    render_inline(described_class.new)

    expect(rendered_content).to include('peer-focus-visible:outline-2')
    expect(rendered_content).to include('peer-focus-visible:outline-offset-2')
    expect(rendered_content).to include('peer-focus-visible:outline-neutral-600')
  end

  it "defaults to switch name when id not provided" do
    render_inline(described_class.new)

    expect(rendered_content).to include('name="switch"')
    expect(rendered_content).to include('id="switch"')
  end

  it "passes through html_options to label" do
    render_inline(described_class.new(data: { controller: "test" }))

    expect(rendered_content).to include('data-controller="test"')
  end
end
