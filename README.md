# Node.js App with Graceful Shutdown

This is a sample Node.js app that demonstrates how to gracefully stop the app when a Docker container is stopped.

## Building and Running the Docker Container

To build and run the Docker container, use the following commands:

```bash
# Building the Docker Image
docker build -t docker-node-graceful-exit .

# Running the Docker Container
docker run -p 3000:3000 --name node-app docker-node-graceful-exit
```


This will start the container and map port 3000 from the container to port 3000 on your host machine.

## Testing Graceful Shutdown

You can test the graceful shutdown of the Node.js app by manually stopping the Docker container using the `docker stop` command.

By default, Docker waits for 10 seconds for a container to shut down cleanly after sending it a `SIGTERM` signal before forcefully terminating it. However, this Node.js app has a signal handler that listens for the `SIGTERM` signal and performs a graceful shutdown, closing any open connections and releasing any resources before exiting.

To manually stop the container and test the graceful shutdown, use the following command:

```bash
docker stop node-app
```

This will send a `SIGTERM` signal to the container and give it a few seconds to gracefully shut down. However, since the Node.js app handles the `SIGTERM` signal and performs a graceful shutdown, it should stop much faster than the default 10 seconds that Docker waits before forcefully terminating the container.

That's it! This sample project demonstrates how to test the graceful shutdown of a Node.js app when a Docker container is stopped, using the `docker stop` command to give the app a few seconds to shut down cleanly. You can use this approach in your own projects to ensure that your app shuts down cleanly and doesn't leave any resources hanging when running in a containerized environment.
