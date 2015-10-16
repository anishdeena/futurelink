require 'nokogiri'
require 'open-uri'
require 'openssl'

namespace :getWikipediaMovieQuotes do
	desc "Get AFI's 100 Years...100 Movie Quotes from Wikipedia and store in Mongo"
	task :scrapeAndStoreMovieQuotes => :environment do
		OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
		doc = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/AFI%27s_100_Years...100_Movie_Quotes"))
		table = doc.css("table.wikitable.sortable tr")
		#doc.css("table.wikitable.sortable tr")[1].elements[1].elements[0].attributes["href"].content
		table[1..101].each do |row|
			quote = Quote.new
			quote.rank = row.elements[0].text.to_i
			quote.quotation = row.elements[1].text.gsub('"', '')
			if row.elements[2].elements[0]
				quote.character = row.elements[2].elements[0].text
			end
			if row.elements[3].elements[0]
				quote.actor = row.elements[3].elements[0].text
			end
			if row.elements[4].elements[0]
				quote.film = row.elements[4].elements[0].text
			end
			if row.elements[5]
				quote.year = row.elements[5].text
			end
			# if row.elements[2].elements[0]
			# 	quote.character_link = "https://en.wikipedia.org" + row.elements[2].elements[0].attributes["href"].content
			# end
			# if row.elements[3].elements[0]
			# 	quote.actor_link = "https://en.wikipedia.org" + row.elements[3].elements[0].attributes["href"].content
			# end
			# if row.elements[4].elements[0].children[0]
			# 	quote.film_link = "https://en.wikipedia.org" + row.elements[4].elements[0].children[0].attributes["href"].content
			# end
			if quote.valid?
				quote.save
			end
		end
	end
end
