require "spec_helper"

describe NameDrop::Associations::Dsl do
  class BaseClass
    include NameDrop::Associations::Dsl
  end

  describe "when included into another class" do
    describe ".has_many" do
      it "defines a has_many relation" do
        expect(NameDrop::Associations::HasMany).to receive(:define_relation).with(BaseClass, :child_records, {})
        BaseClass.has_many(:child_records)
      end
    end

    describe ".belongs_to" do
      it "defines a belongs_to relation" do
        expect(NameDrop::Associations::BelongsTo).to receive(:define_relation).with(:parent, BaseClass)
        BaseClass.belongs_to(:parent)
      end
    end
  end
end
