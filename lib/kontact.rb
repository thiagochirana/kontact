require_relative "kontact/version"
require_relative "kontact/brazil"
require_relative "kontact/usa"

module Kontact
  def self.generate(country = detect_country, type = :mobile)
    case country.to_sym
    when :brazil
      Brazil.generate(type)
    when :usa
      USA.generate(type)
    else
      raise ArgumentError, "Unsupported country: #{country}"
    end
  end

  def self.valid?(number, country = detect_country)
    raise ArgumentError, "Number can not empty or blank" unless number

    case country.to_sym
    when :brazil
      Brazil.valid?(number)
    when :usa
      USA.valid?(number)
    else
      raise ArgumentError, "Unsupported country: #{country}"
    end
  end

  private

  def self.detect_country
    locale = ENV["LANG"] || ENV["LC_ALL"] || ENV["LC_MESSAGES"] || ""
    case locale.downcase
    when /pt[-_]br/
      :brazil
    when /en[-_]us/
      :usa
    else
      :brazil # as a main fallback
    end
  end
end
