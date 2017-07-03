require 'net/https'
require 'open-uri'

module Gbre
  # Repository methods for making requests to the Github API
  class GithubIssueRepository
    # Make a GET request to Github API
    # @param uri [String]
    # @return response.body [Object]
    def self.get(uri)
      uri = URI.parse(uri)
      http = Net::HTTP.new(uri.host, 443)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.path)
      request['User-Agent'] = 'n8rzz'
      response = http.request(request)

      response.body
    end
  end
end
