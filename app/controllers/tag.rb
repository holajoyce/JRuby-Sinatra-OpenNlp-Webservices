# --------------------
# tag a flyer
# --------------------
get '/tag' do
  
  itemTagName = "item"
  namedEntityTagName = "namedentity"

  # take a query from request handler,
	query = params[:q].to_s.downcase
	
	# take the query and tokenize it
	tokens = settings.tokenizer.tokenize(query)
	
	# take the tokens and apply entity detection
	spans = settings.ner_detector.detect(tokens)

	# begin tagging each named entity based on what was returned from above
	cnt =0
	for span in spans
		tokens = tokens.insert((span.getStart+cnt*2), "<"+namedEntityTagName+">") 
		tokens = tokens.insert((span.getEnd+cnt*2+1), "</"+namedEntityTagName+">") 
		cnt = cnt+1
	end

	xml = "<"+itemTagName+">"+tokens.join(" ")+"</"+itemTagName+">"

	# do some cleaning up before returning the named entities
	nes = [] #named entities
	doc = Nokogiri::XML(xml)
	doc.xpath('//'+namedEntityTagName).map do |ne| # for each named entity
		nes.push(ne.inner_text.strip!)
	end

	# return the tagged xml & also the named entities themselves in json response
	content_type :json
	{ 	
	  :status => 'ok', 
		:tokens => tokens, 
		:tagged=>xml,
		:namedentities => nes, 
		:uid => params[:uid]
	}.to_json

end

