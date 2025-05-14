module Kontact
  module Brazil
    DDDs = %w[
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
    ]

    def self.generate(type = :mobile)
      ddd = DDDs.sample
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
      match = number.match(/\A\+55 (\d{2}) (\d{4,5})-(\d{4})\z/)
      return false unless match

      ddd = match[1]
      prefix = match[2]
      return false unless DDDs.include?(ddd)

      if prefix.length == 5
        prefix.start_with?("9")
      elsif prefix.length == 4
        prefix[0].to_i.between?(2, 5)
      else
        false
      end
    end
  end
end
