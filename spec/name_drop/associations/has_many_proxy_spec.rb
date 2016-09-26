require "spec_helper"

describe NameDrop::Associations::HasManyProxy do
  Target = Class.new(NameDrop::Resources::Base)

  subject { described_class.new(parent, target_class) }
  let(:target_class) { Target }
  let(:parent) { double("parent") }
  let(:client) { double("client") }

  before do
    allow(parent).to receive(:client).and_return(client)
    allow(parent).to receive(:attributes).and_return("id" => "123")
  end

  it "has a target class" do
    expect(subject.instance_values).to include("target_class" => target_class)
  end
  it "has a parent" do
    expect(subject.instance_values).to include("parent" => parent)
  end

  context "delegating to the target class" do
    it "fetches a collection" do
      expect(target_class).to receive(:all).with(client, double_id: "123").and_return([])
      subject.all
    end

    context "building a new instance" do
      let(:attributes) { { name: "Some Name" } }

      it "builds the instance with attributes, including the parent ID" do
        expect(target_class).to receive(:new).with(client, attributes.merge(double_id: "123"))
        subject.build(attributes)
      end
    end
  end

  it "reloads the collection" do
    expect(subject).to receive(:all).once.and_return(true)
    subject.reload
  end

  it "delegates missing methods to the collection" do
    allow(target_class).to receive(:all).and_return([])
    expect(subject.all).to receive(:each)
    subject.each
  end
end
