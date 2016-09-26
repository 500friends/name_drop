require "spec_helper"

describe NameDrop::Associations::BelongsTo do
  NameDrop::Resources::Parent = Class.new(NameDrop::Resources::Base)
  NameDrop::Resources::Child = Class.new(NameDrop::Resources::Base)

  before do
    described_class.define_relation(:parent, NameDrop::Resources::Child)
  end

  describe "getting the parent ID" do
    it "defines a method" do
      expect(NameDrop::Resources::Child.instance_methods).to include(:parent)
    end
  end

  describe "getting the parent object" do
    it "defines a method" do
      expect(NameDrop::Resources::Child.instance_methods).to include(:parent_id)
    end
  end

  describe "setting the parent object" do
    it "defines a setter" do
      expect(NameDrop::Resources::Child.instance_methods).to include(:parent=)
    end
  end
end
