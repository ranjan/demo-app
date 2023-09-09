## Configuring container


#### To rebuild image
~~~
#docker-compose -f docker-compose.postgresql.yml build
~~~

#### Boots up the app.
~~~
#docker-compose -f docker-compose.postgresql.yml up 
~~~

#### Detach app after boot
~~~
#docker-compose up -d
~~~

#### Create database
~~~
#docker-compose run app rake db:create
~~~

#### Run migrations.
~~~
#docker-compose run app rake db:migrate 
~~~

#### Seed database
~~~
#docker-compose run app rake db:seed
~~~

#### Shut down container
~~~
#docker-compose down
~~~

#### List all container 
~~~
#docker-compose ps -a
~~~

## Debugging docker instance


#### Container keep running, add this in Dockerfile
~~~
#ENTRYPOINT ["tail", "-f", "/dev/null"]
~~~

#### Debugging application
~~~
#docker compose exec web sh
~~~

#### See log
~~~
#docker-compose run web tail -f -n 200 log/development.log
~~~

#### Print all logs
~~~
#docker-compose -f docker-compose.postgresql.yml logs
~~~