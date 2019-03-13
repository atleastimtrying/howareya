module Howareya
  class Configuration
    attr_accessor :api_key, :url

    def initialize
      @api_key = nil
      @url = nil
    end
  end
end

