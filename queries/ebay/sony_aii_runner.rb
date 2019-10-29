require_relative 'ebay'

s = Ebay.new("Sony a7 ii")
s.newly_listed = true
s.us_only = true
result = s.start