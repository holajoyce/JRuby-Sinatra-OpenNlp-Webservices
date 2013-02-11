# Require the necessary libraries.
require 'rubygems'
require 'sinatra'
require 'open_nlp'
require 'open-uri'
require 'json'
require 'resque/server'
require 'rsolr'
require 'nokogiri'
require 'jsonpath'

#require 'core_extensions'

# require 'sinatra/reloader' if development?

#---------------
# redis
#---------------
Resque.redis = Redis.new(
  :host => 'localhost', :port => 6379) #typical port for redis 

#---------------
# solr
#---------------
@server = "localhost" 
@port = "8983" # typical port for solr 

#----------------------------------------------------
# nlp server, warbled into a war to be run in tomcat
#----------------------------------------------------
@localhost = "localhost"
@nlpport = "8080" # typical port for tomcat

@nlp_ds2 = 'http://'+@localhost+':'+@nlpport+'/tag/'
@nlp_ds1 = 'http://'+@localhost+':'+@nlpport+'/tag/'


@datatype1_ds1 =  'http://'+@server+':'+@port+'/solr/datatype1_data_set1'
@datatype1_ds2 =  'http://'+@server+':'+@port+'/solr/datatype1_data_set2'
@datatype2_ds1 =  'http://'+@server+':'+@port+'/solr/datatype2_data_set1'
@datatype2_ds2 =  'http://'+@server+':'+@port+'/solr/datatype2_data_set2'


@datatype1_url = {"1"=>@datatype1_ds1, "10"=>@datatype1_ds2}
@datatype2_url = {"1"=>@datatype2_ds1, "10"=>@datatype2_ds2}
@nlp_url = {"1"=>@nlp_f, "10"=>@nlp_ds2}

configure do

	root = File.expand_path(File.dirname(__FILE__))
	  
	#---------------------------------------
	# global vars the sinatra way
	#---------------------------------------
	set :views, File.join(root, 'app', 'views')

  # make your own model
	# the path is an example of where tomcat can be installed, not necessarily the most optimal
	set :ner_model , OpenNlp::Model::NamedEntityDetector.new(File.join("/opt/apache-tomcat/webapps/ROOT/datatype1_myOwnModel.bin")) 
	
	# this helps you do tokenizing
  # download from here http://opennlp.sourceforge.net/models-1.5/
	set :tokenizer_model , OpenNlp::Model::Tokenizer.new("/opt/apache-tomcat/webapps/ROOT/en-token.bin") 

	set :ner_detector , OpenNlp::NamedEntityDetector.new(settings.ner_model)
	set :tokenizer , OpenNlp::Tokenizer.new(settings.tokenizer_model)

	set :datatype1_url, @datatype1_url
	set :datatype2_url, @datatype2_url
	set :nlp_url, @nlp_url
end

# Set the not found page for URIs that don't match to any specified route.
not_found do
	status 404
	erb :not_found
end

# Load the controllers.
Dir["app/controllers/*.rb"].each { |file| load file }
Dir["app/jobs/*.rb"].each { |file| require file }

