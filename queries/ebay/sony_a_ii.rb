require '../../main'

class SonyAII < Main
	attr_accessor :page

	def initialize
		@page = goto("https://www.ebay.com/")
	end

	def search(phrase)
		form = @page.forms.first
		form['_nkw'] = phrase
		@page = form.submit
	end
end

sony_search = SonyAII.new
sony_search.search("Sony a7 ii")
p ''