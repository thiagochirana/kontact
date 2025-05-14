require "spec_helper"

RSpec.describe Kontact::USA do
  describe "generate" do
    it "a phone number in the format +1 NPA NXX-XXXX" do
      number = described_class.generate
      expect(number).to match(/\A\+1 \d{3} \d{3}-\d{4}\z/)
    end

    it "generates mostly unique numbers" do
      numbers = Array.new(100) { described_class.generate }
      expect(numbers.uniq.size).to be > 90
    end
  end

  describe "uses" do
    it "only valid prefixes (excludes 911, 411, 555)" do
      100.times do
        prefix = described_class.generate.split[2].split("-").first.to_i
        expect([911, 411, 555]).not_to include(prefix)
      end
    end

    it "only known area codes (NPA)" do
      100.times do
        area = described_class.generate.split[1]
        expect(Kontact::USA::AREAS).to include(area)
      end
    end
  end

  describe "when" do
    it "does not generate prefixes starting with 0 or 1" do
      100.times do
        prefix = described_class.generate.split[2].split("-").first
        expect(prefix[0]).to match(/[2-9]/)
      end
    end
  end
end
