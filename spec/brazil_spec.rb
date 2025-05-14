require "spec_helper"

RSpec.describe Kontact::Brazil do
  describe "generate" do
    it "a valid mobile number" do
      result = described_class.generate(:mobile)
      expect(result).to match(/\+55 \d{2} 9\d{4}-\d{4}/)
    end

    it "a valid landline number" do
      result = described_class.generate(:landline)
      expect(result).to match(/\+55 \d{2} [2-5]\d{3}-\d{4}/)
    end

    it "raises error with invalid type" do
      expect do
        described_class.generate(:fax)
      end.to raise_error(ArgumentError, /Invalid type/)
    end
  end

  describe "returns" do
    it "true for valid mobile numbers" do
      expect(described_class.valid?("+55 11 91234-5678")).to be true
      expect(described_class.valid?("+55 21 99888-0000")).to be true
    end

    it "true for valid landline numbers" do
      expect(described_class.valid?("+55 11 2345-6789")).to be true
      expect(described_class.valid?("+55 41 3222-1111")).to be true
    end

    it "false for invalid format" do
      expect(described_class.valid?("11 91234-5678")).to be false
      expect(described_class.valid?("+55-11-91234-5678")).to be false
      expect(described_class.valid?("+55 11 912345678")).to be false
    end

    it "false for invalid DDDs" do
      expect(described_class.valid?("+55 00 91234-5678")).to be false
      expect(described_class.valid?("+55 10 91234-5678")).to be false
    end

    it "false for invalid mobile prefix" do
      expect(described_class.valid?("+55 11 81234-5678")).to be false
    end

    it "false for invalid landline prefix" do
      expect(described_class.valid?("+55 11 6123-4567")).to be false
    end
  end
end
