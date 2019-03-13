require "howareya/errors"
require "howareya/configuration"
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
    raise Howareya::MissingMetricError if response.code === 404
    raise Howareya::BadAPIKeyError if response.code === 401
  end

end
