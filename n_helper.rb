# Nokogiri Helper
require 'mechanize'

module NHelper

	def goto(url)
		Mechanize.new.get(url)
	end
end