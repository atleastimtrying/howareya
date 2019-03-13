require "howareya/version"

module Howareya
  def self.setup(url, api_key)
    @api_key = api_key
    @url = url
  end

  def self.details
    { api_key: @api_key, url: @url}
  end

  def self.record_metric key, value
    response = HTTParty.post(@url, :body => { :api_key => @api_key, 
                             :key => key, 
                             :value => value })
    raise HowareyaMissingMetricError if response.code === 404
    raise HowareyaBadAPIKeyError if response.code === 401
  end

end

class HowareyaMissingMetricError < StandardError
  def initialize(msg="It looks like you havent registered a metric at Howareya")
    super
  end
end

class HowareyaBadAPIKeyError < StandardError
  def initialize(msg="It looks like you're using an invalid api key for Howareya")
    super
  end
end
