require "spec_helper"

describe NameDrop::Associations::HasMany do
  NameDrop::Resources::ParentClass = Class.new(NameDrop::Resources::Base)
  NameDrop::Resources::Child = Class.new(NameDrop::Resources::Base)

  before do
    described_class.define_relation(NameDrop::Resources::ParentClass, :children)
  end

  it "defines a method that corresponds to the association name" do
    expect(NameDrop::Resources::ParentClass.instance_methods).to include(:children)
  end

  it "memoizes the result" do
    instance = NameDrop::Resources::ParentClass.new(anything)
    expect(instance.instance_values.keys).to_not include("children")
    instance.children
    expect(instance.instance_values.keys).to include("children")
  end
end
