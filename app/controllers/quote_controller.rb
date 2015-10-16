class QuoteController < ApplicationController
	def getRandomQuote
		quote = Quote.getRandomQuote
		render json: quote
	end
end
