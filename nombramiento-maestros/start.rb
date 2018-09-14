#! /usr/bin/env ruby

require 'net/http'

url = "http://www.gobiernodecanarias.org/educacion/7/dgper/nombradiarios/Docs/" \
      "NDPTF#{Time.now.strftime('%d-%m-%y')}.PDF"

uri = URI.parse(url)
result = Net::HTTP.start(uri.host, uri.port) { |http| http.get(uri.path) }
puts url if result.code == '200'
