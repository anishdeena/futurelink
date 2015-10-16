class Quote
  include MongoMapper::Document

  key :quotation, String
  key :film, String
  key :character, String
  key :actor, String
  key :year, Integer
  key :type, String
  key :character_link, String
  key :film_link, String
  key :actor_link, String
  key :rank, Integer

  def self.getRandomQuote
    rank = Random.new.rand(1..100)
    getQuoteByRank(rank)
  end

  def self.getQuoteByRank(rank)
    return quote = Quote.find_by_rank(rank)
  end

end
