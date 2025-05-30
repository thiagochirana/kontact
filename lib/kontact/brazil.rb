module Kontact
  module Brazil
    DDD = %w[
      11 12 13 14 15 16 17 18 19
      21 22 24
      27 28
      31 32 33 34 35 37 38
      41 42 43 44 45 46
      47 48 49
      51 53 54 55
      61 62 63 64
      65 66 67
      68 69
      71 73 74 75 77
      79
      81 82 83 84 85 86 87 88 89
      91 92 93 94 95 96 97 98 99
    ].freeze

    def self.generate(type = :mobile)
      ddd = DDD.sample
      number = case type
               when :mobile
                 "9#{rand(1000..9999)}-#{rand(1000..9999)}"
               when :landline
                 "#{rand(2000..5999)}-#{rand(1000..9999)}"
               else
                 raise ArgumentError, "Invalid type: #{type}"
               end
      "+55 #{ddd} #{number}"
    end

    def self.valid?(number)
      return false unless number.match?(/\A\+?55[ ()\d-]+\z/)
      return false if number.include?("--") || number.include?("++") || number.include?("-+")
      return false unless number.match?(/\A[\d\s\-+()]+\z/)
      return false if number.count("+") > 1
      return false if number.count("-") > 1
      return false if number.count("(") > 1
      return false if number.count(")") > 1
      return false if number.match?(/[^\d\s\-+()]/)

      digits = number.gsub(/\D/, "")

      return false unless digits.start_with?("55")

      digits = digits[2..]

      return false unless [10, 11].include?(digits.length)

      ddd = digits[0..1]
      prefix = digits[2..-5]

      return false unless DDD.include?(ddd)

      if digits.length == 11
        prefix.start_with?("9")
      elsif digits.length == 10
        prefix[0].to_i.between?(2, 5)
      else
        false
      end
    end
  end
end
