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

	def get_all_links
		result = []
		@page.links.each do |link|
			if link.dom_class == 's-item__link'
				result << link
			end
		end
		result
	end

	def pagination_count
		last_element = "//ol[@class='x-pagination__ol']//li[@class='x-pagination__li'][last()]"
		@page.xpath(last_element).text
	end
end

sony_search = SonyAII.new
sony_search.search("Sony a7 ii")
links = sony_search.get_all_links
p ''