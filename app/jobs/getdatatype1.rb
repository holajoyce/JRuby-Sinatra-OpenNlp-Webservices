require 'set'
# require 'java'
# require 'jdbc/mysql'
# require 'rsolr'
=begin
  The purpose of this class is to query solr on the core you need and get back a bunch of docs.
  Once a doc is obtained, send it to nlp webservice to get tags on the document
  Then for each tag on each document
  Update both solr cores w/ another job - SearchAndUpdate which is left of this repository
=end
class Getdatatype1
	attr_accessor :docs

	@queue = :db_ds1yers
	def self.perform(parameters_json)

		parameters = JSON.parse(parameters_json)
		  
		f_url = parameters["f_url"] # datatype 1 from solr
		r_url = parameters["r_url"] # datatype 2 from solr
		n_url = parameters["n_url"] # url for nlp service

		# setup solr & nlp drivers
		solr_ds1_driver 	= RSolr.connect :url =>  f_url
		solr_datatype2_driver = RSolr.connect :url =>  r_url
	  nlp_driver = RSolr.connect :url => n_url # setup nlp driver
	    
		solr_docs_params = {:q=>"*:*", :wt=>:ruby, :rows=>0, :facet=>"on"}
		solr_docs_params["facet.field"] = "doc_id"
		solr_docs_params["facet.limit"] = -1

		# get the doc from solr
		solr_docs_response = solr_ds1_driver.get 'itas', :params=> solr_docs_params
		# from solr_docs_response create the doc_detail object
		
		# here we want to ask nlp webservice on the title field of our doc object
		# we piggy back onto the ruby solr client, so we also pass in the wt=json flag, though nlp ws doesn't require it
    nlp_response = nlp_driver.get 'tag', :params=>{:q=>doc_detail['title'],:wt=>'json',:uid=>""}

    # for each of the named entity returned
    # now ask your other solr core based on these named entities
    # you will get back a bunch of docs from that other core
		# enqueue a solr update into redis (place the SearchAndUpdate class into your jobs dir)
    # I am leaving that out of repo
#		Resque.enqueue(SearchAndUpdate, item.to_json)

		return docs

	end
end
