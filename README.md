# kangaroos_docker_container_registry_system
UMKC - Hackatron Code Submission

To use the project, import it as netbeans webapplication. Add the dependencies for HttpComponents and org.json.

There are 2 options to test the functionality.

1) Compile and run the application.This option will create and runs WEB server on local machine. Using port 8080 you can access the WEB Server and from UI you can access this application and configure functionality on remote Google Cloud.
          or
2) You can access the WEB Interface by the following URL(Note: This is UMKC internal & non routable IP. So you need to be UMKC internal network to access the below URL)
http://134.193.128.118:8080/ContainerRegisterService/
It will direct to WEB UI and from there you can play with the configuration which will act on the remote Google Cloud.

The following are the public Google cloud URL's, where the 4 Ubuntu VM's are running as an instances. These IP's are also shown in UI when you add & delete the Docker containers from which you can test the WEB server accessibility.
104.198.31.108, 104.197.32.181, 104.197.197.157, 104.197.123.27


