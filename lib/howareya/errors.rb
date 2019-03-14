module Howareya
  class MissingConfigError < StandardError
    def initialize(msg="It looks like you haven't set up the config for Howareya")
      super
    end
  end

  class MissingMetricError < StandardError
    def initialize(msg="It looks like you haven't registered a metric at Howareya")
      super
    end
  end

  class BadAPIKeyError < StandardError
    def initialize(msg="It looks like you're using an invalid api key for Howareya")
      super
    end
  end
end

