// INSTALL FLOW following this.
// rails new apptky
// vi Gemfile
// gem 'rails', '6.0.3.2'
// touch Gemfile.lock
//
//

// production
// docker-compose run web rails new . --force --no-deps --database=postgresql
// test
docker-compose run web rails new . --force --no-deps 
ls -l
sudo chown -R $USER:$USER .
docker-compose build

// config/database.yml
docker-compose up
docker-compose run web rake db:create

// destroy
// docker-compose down



