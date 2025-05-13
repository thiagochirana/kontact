require_relative "kontact/version"
require_relative "kontact/brazil"
require_relative "kontact/usa"

module Kontact
  def self.generate(country, type = :mobile)
    case country.to_sym
    when :brazil
      Brazil.generate(type)
    when :usa
      USA.generate(type)
    else
      raise ArgumentError, "Unsupported country: #{country}"
    end
  end
end
