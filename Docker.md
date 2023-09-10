## Configuring container


#### To rebuild image
~~~
#docker build -t demo-app-image .
~~~

#### Start the app.
~~~
#docker run -d -p 3000:3000 -v $(pwd):/app --name demo-app-container demo-app-image
~~~

#### Stop the app.
~~~
#docker stop demo-app-container
~~~

#### Re start stopped container
~~~
#docker start demo-app-container
~~~

#### Check logs incase any error
~~~
docker logs demo-app-container
~~~

#### Access container command line
~~~
docker exec -it demo-app-container /bin/bash
~~~