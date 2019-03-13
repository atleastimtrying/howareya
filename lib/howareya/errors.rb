module Howareya
  class MissingMetricError < StandardError
    def initialize(msg="It looks like you havent registered a metric at Howareya")
      super
    end
  end

  class BadAPIKeyError < StandardError
    def initialize(msg="It looks like you're using an invalid api key for Howareya")
      super
    end
  end
end

