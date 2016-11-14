# kangaroos_docker_container_registry_system
::::::::::::::::::::::::::::::::
UMKC - Hackatron Code Submission
::::::::::::::::::::::::::::::::

:::::::::::Abstract::::

We have created a Docker container registry service application where users can add/delete/auto provision/check usage bill/manage/ chosen container resources(WEB Servers Images) on the Docker engine hosted on the Google cloud dynamically using friendly UI which eliminates the struggle for user to get into low level technical understandings of how to configure Docker, WEB Servers, Google cloud Virtual Machines etc and provide additional advantage to replicate and  specify computing resources per services.

::::::::Application Usage Steps::::

To use the project, import it as netbeans webapplication. Add the dependencies for HttpComponents and org.json.

There are 2 options to test the functionality.

1) Compile and run the application.This option will create and runs WEB server on local machine. Using port 8080 you can access the WEB Server and from UI you can access this application and  play with the configuration which will act on the Docker engines running on remote Google Cloud.

          or
          
2) You can access the WEB Interface by the following URL(Note: This is UMKC internal & non routable IP. So you need to be UMKC internal network to access the below URL)
http://134.193.128.118:8080/ContainerRegisterService/
It will direct to WEB UI and from there you can play with the play with the configuration which will act on the Docker engines running on remote Google Cloud.

3) Once UI is loaded, first time register with the system.

4) Now login and you have neen provided with the 2 functionalities to spawn container. First with using Docker containers and second using Docker swarm. You can click on 'Add Container' and 'Manage Swarm Cluster' respectively.

5) Now You have the option to choose which Image to run in the container. nginx web server and mondo DB have been provided.

6) You have the option to specity RAM memory usage, CPU quota and replicas(for Swarm cluster) for the conatiner services.

7) When containers/swarm services are started, you ahve the option to see statistics(bill amount per user etc).

8) Any time containers/swarm services can be stopped and bill usage can be known.

9) For testing, for example if you choose nginx web server to run, the you will be specified with the public google cloud URL where web server is running. You can copy that and open in the other browser tab to check the welcome page of web server.

10) Enjoy the functionality offered by our UI which greatly simplifies the manual task of starting containers.

:::::::: Info :::::::::::::

The following are the public Google cloud URL's, where the 4 Ubuntu Virtual Machines are running as an instances and they are acting as a  docker engines. These IP's are also shown in UI when you add & delete the Docker containers from which you can test the WEB server accessibility from your machine.

104.198.31.108
104.197.32.181
104.197.197.157
104.197.123.27

::::::::::Programming Environment :::::::::::

Java/Docker REST API/Google Cloud REST API/

Netbeans

Glass Fish Server

:::::::::: Technical terms Explanation ::::::::::::::::

Docker Image : Any application packed with all needed executables.

Docker Service: An running instance of Docker Image on a container.

Replicas -- Specifies on how many docker engines the chosen service need to be running.

Docker Swarm -- It turns a pool of Docker engines into a cluster which greatly simplifies for service redundency management.

Docker Container -- Lightweight VM where Docker Images can be run.

