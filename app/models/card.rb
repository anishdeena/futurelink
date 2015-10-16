class Card
  include MongoMapper::Document

  key :key, String
  key :url, Text
  key :card, Text
  key :views, Integer
  key :tags, Array


  def constructAndSaveCard(URL)
  	og = OpenGraph.fetch(article["url"])
  	doc = Nokogiri::HTML
  	constructCard(page_og, document)

  end

  def constructCard(page_og, document)
  	keyword_tags = doc.at_css('meta[name="keywords"]').attributes["content"].value
  end

  def saveCard(card)
  end

end
