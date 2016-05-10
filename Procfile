web: bundle exec rails server -p $PORT
worker:  env TERM_CHILD=1 QUEUE='*' COUNT='1' bundle exec rake resque:workers