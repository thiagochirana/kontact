module Kontact
  module USA
    AREAS = %w[202 303 404 505 606]

    def self.generate(_type = :mobile)
      area = AREAS.sample
      number = "#{rand(200..999)}-#{rand(1000..9999)}"
      "+1 #{area} #{number}"
    end
  end
end
