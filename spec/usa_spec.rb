require "spec_helper"

RSpec.describe Kontact::USA do
  describe "generate" do
    it "a phone number in the format +1(NPA)NXX-XXXX" do
      number = described_class.generate(formatted: true)
      expect(number).to match(/\A\+1 \((\d{3})\) \d{3}-\d{4}\z/)
    end

    it "generates mostly unique numbers" do
      numbers = Array.new(100) { described_class.generate }
      expect(numbers.uniq.size).to be > 90
    end
  end

  describe "uses" do
    it "only valid prefixes (excludes 911, 411, 555)" do
      100.times do
        prefix = described_class.generate(formatted: true).split[2].split("-").first.to_i
        expect([911, 411, 555]).not_to include(prefix)
      end
    end
  end

  describe "when" do
    it "does not generate prefixes starting with 0 or 1" do
      100.times do
        prefix = described_class.generate(formatted: true).split[2].split("-").first
        expect(prefix[0]).to match(/[2-9]/)
      end
    end
  end

  describe "validate" do
    it "a valid US number" do
      expect(described_class.valid?("+1 (202) 345-6789")).to be true
    end

    it "invalid format" do
      expect(described_class.valid?("202-345-6789")).to be false
      expect(described_class.valid?("+1-202-345-6789")).to be false
      expect(described_class.valid?("+1 202345-6789")).to be false
    end

    it "invalid area code" do
      expect(described_class.valid?("+1 000 345-6789")).to be false
      expect(described_class.valid?("+1 123 345-6789")).to be false
    end

    it "forbidden prefix" do
      expect(described_class.valid?("+1 202 555-6789")).to be false
      expect(described_class.valid?("+1 303 411-1234")).to be false
    end

    it "if prefix starts with 0 or 1" do
      expect(described_class.valid?("+1 202 012-3456")).to be false
      expect(described_class.valid?("+1 202 199-9999")).to be false
    end
  end
end
