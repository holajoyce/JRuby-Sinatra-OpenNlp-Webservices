# Jruby Sinatra Opennlp Webservices
[![Jruby Sinatra Opennlp](https://raw.github.com/spatzle/jruby_sinatra_nlp/master/app/static/images/relevant.jpg)]()


## intro 
This project can be [warbled](http://caldersphere.rubyforge.org/warbler/) into a war file
and dropped into jsp container which provides webservices to batch update docs from one solr core with data from another solr core.

The mechanism for joining these two disjoint dataset is with the help of opennlp to tag named entities from one set and performing a search on the other and then updating both to denote there is a relationship

## Reasons for choosing jruby, sinatra

Jruby runs on top of jvm, so it can easily make use of java based [Apache OpenNLP libraries](https://opennlp.apache.org/) and sinatra is a simple micro web framework that can run with jruby to provide simple webservice interface for queries against opennlp.  Moreover, I was a little bit familar with ruby.

If you prefer to have a servlet for OpenNLP you can take a look at my [example](https://gist.github.com/spatzle/1104702), which is based on the [stanford-ner servlet](stanford-ner)

## Requirements of note
* jruby 
* jsp container such as tomcat
* opennlp jars
* create some of your own models to be used with opennlp
* [open_nlp gem](https://github.com/hck/open_nlp), there's a even more active [gem](https://github.com/louismullie/open-nlp#readme) which hadn't been tried here yet.
* [resque gem](https://github.com/defunkt/resque) for enqueueing jobs
* [jruby rack worker](https://github.com/kares/jruby-rack-worker) is a jar that enable the jsp container to run resque
* [redis](http://redis.io/) the backend for storing solr update jobs
* [rsolr gem](https://github.com/mwmitchell/rsolr)
* other required gems are in the gem file


## Resources
#### resque & redis examples
http://redistogo.com/documentation/resque



## License
[MIT](http://joyceschan.mit-license.org/)

