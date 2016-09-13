require "spec_helper"

describe NameDrop::Resources::Base do
  let(:parent_class_id) { 1 }
  let(:belongs_to_class_id) { 2 }

  describe ".path" do
    context "when the resource belongs to another resource" do
      class ParentClass < NameDrop::Resources::Base

      end

      class BelongsToClass < NameDrop::Resources::Base
        belongs_to :parent_class
      end

      it "constructs the url with the parent association as a prefix" do
        expect(BelongsToClass.path(params: { parent_class_id: parent_class_id })).to eq "parent_classes/#{parent_class_id}/belongs_to_classes"
      end
    end

    context "when the action is singular" do
      it "appends the resource ID to the path" do
        expect(ParentClass.path(type: :singular, params: { id: parent_class_id })).to eq "parent_classes/#{parent_class_id}"
      end
    end

    context "when the action is for a collection" do
      it "returns the collection path" do
        expect(ParentClass.path).to eq "parent_classes"
      end
    end

    context "when the action is persistence" do
      it "appends the resource ID to the path" do
        expect(ParentClass.path(type: :persistence, params: { id: parent_class_id })).to eq "parent_classes/#{parent_class_id}"
      end
    end
  end

  describe "#path" do
    subject { BelongsToClass.new(anything, id: belongs_to_class_id, parent_class_id: parent_class_id) }

    it "generates the path based on the instance attributes" do
      expect(subject.path(type: :singular)).to eq "parent_classes/#{parent_class_id}/belongs_to_classes/#{belongs_to_class_id}"
    end
  end
end
