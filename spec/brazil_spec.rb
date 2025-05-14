# spec/kontact/brazil_spec.rb
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
end
