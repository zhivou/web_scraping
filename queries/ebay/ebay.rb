require '../../main'

class Ebay < Main
	attr_accessor :page,
								:search_phrase,
								:newly_listed,
								:us_only

	PAGINATION = "//ol[@class='x-pagination__ol']//li[@class='x-pagination__li'][last()]"
	URL = "https://www.ebay.com/"

	def initialize(
		search_phrase,
		newly_listed:false,
		us_only:false
	)
		@page = goto(URL)
		@search_phrase = search_phrase
		@newly_listed = newly_listed
		@us_only = us_only
	end

	def start
		search(search_phrase)
		filter_newly_listed if newly_listed
		filter_us_only if us_only
		get_all_links
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
	# Filters
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

