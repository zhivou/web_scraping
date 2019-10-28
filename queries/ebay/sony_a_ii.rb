require '../../main'

class SonyAII < Main
	attr_accessor :page

	PAGINATION = "//ol[@class='x-pagination__ol']//li[@class='x-pagination__li'][last()]"

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
		@page.xpath(PAGINATION).text
	end

	##
	# TODO: Something isn't working here!
	#
	def pagination
		result = []
		@page.links.each do |link|
			if link.dom_class == "x-pagination__li"
				result << link
			end
		end
		result
	end

	#
	# Accessors
	#
	def filter_ending_soonest
		@page = self.page.link_with(xpath: "//span[.='Time: ending soonest']/..").click
	end

	def filter_best_match
		@page = self.page.link_with(xpath: "//span[.='Best Match']/..").click
	end

	def filter_newly_listed
		@page = self.page.link_with(xpath: "//span[.='Time: newly listed']/..").click
	end

	def filter_us_only
		@page = self.page.link_with(xpath: "//span[.='US Only']//ancestor::a").click
	end
end

sony_search = SonyAII.new
sony_search.search("Sony a7 ii")
sony_search.filter_newly_listed
p ''