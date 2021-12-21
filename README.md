# README

ssh root@51.15.229.41

## Docker steps

1.cd /opt/hire-app/spritle-hire

2.git pull

3.build: docker-compose build

4.start: docker-compose up -d

## For running rake task

1.docker ps

2.docker exec -it COPY_CONTANER_ID bash

3.RAILS_ENV=production bundle exec rake load_users:data

4.RAILS_ENV=production bundle exec rake load_questions:data

## console & log

1.bundle exec rails c -e production

2.tail -f log/production.log

## Fresh setup

Step - 1

bundle install

rake db:create

rake db:migrate

rake db:seed

Step - 2

Populate Question data -> rake load_questions:data

Populate Candidate data -> rake load_users:data

Login url

https://hiring.spritle.com

Admin credentials

admin@example.com

spritle123
