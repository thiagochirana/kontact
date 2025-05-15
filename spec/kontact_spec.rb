# frozen_string_literal: true

RSpec.describe Kontact do
  it "has a version number" do
    expect(Kontact::VERSION).not_to be nil
  end
  describe "valid?" do
    context "when country is :brazil" do
      it "returns true for valid brazilian number" do
        number = Kontact::Brazil.generate
        expect(described_class.valid?(number, :brazil)).to be true
      end

      it "returns false for invalid brazilian number" do
        expect(described_class.valid?("+55 99 1234-5678", :brazil)).to be false
      end
    end

    context "when country is :usa" do
      it "returns true for valid US number" do
        number = Kontact::USA.generate
        expect(described_class.valid?(number, :usa)).to be true
      end

      it "returns false for invalid US number" do
        expect(described_class.valid?("+1 000 123-4567", :usa)).to be false
      end
    end

    context "when number is nil" do
      it "raises ArgumentError" do
        expect do
          described_class.valid?(nil, :brazil)
        end.to raise_error(ArgumentError, /Number can not empty or blank/)
      end
    end

    context "when country is unsupported" do
      it "raises ArgumentError" do
        expect do
          described_class.valid?("+55 11 91234-5678", :mexico)
        end.to raise_error(ArgumentError, /Unsupported country/)
      end
    end
  end
end
