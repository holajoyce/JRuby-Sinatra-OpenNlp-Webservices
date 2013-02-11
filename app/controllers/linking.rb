# ---------------------------------------------------------------------------
# start here to kick off background batch jobs to link 2 datasets in solr
# with the help of OpenNLP named entity detection library 
# webservice for enqueing indexing
# SAMPLE input: localhost:28080/tag/link
# ---------------------------------------------------------------------------
get '/link' do
	parameters = {
		:n_url =>settings.nlp_url[params[]],
		:f_url =>settings.datatype1_url[params[  ]],
		:r_url =>settings.datatype2_url[params[  ]]
	}

	# kick off the main job
	Resque.enqueue(Getdatatype1, parameters.to_json)

	content_type :json
	{      
		:status => 'Here are the resque jobs started for reindexing to link datatype1 & datatype2 together, if it takes too long, you can check the status by going up a level & using the resque webservice. Ie. http://localhost:8080/resque/queues/solr_updates',
		:reindex_based_on_info => parameters
    }.to_json

end

# ------------------
# show reindexing status
# ------------------
get '/status' do
	content_type :json
	{
		:msg=>"this web service has not been implemented yet, try going one level up & using /resque service",
		:status=>"ok"
	}.to_json
end

# ---------------
# default msg
# -------------
get '/' do
	content_type :json
	{
		:status=>"ok",
		:msg=>	"Hello welcome to entity tagging server.  Available services include /tag, /link, /status, or go up a level and call resque for user interface "
	}.to_json
end

