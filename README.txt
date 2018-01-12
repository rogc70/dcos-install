
README.txt

This file describes the use of the python_web_service.py script 
on Mesosphere's DC/OS.

This python web service illustrates how a non-containerized application 
can connect to and request data from a containerized application.

NOTE: Before performing these steps, download the following files to your
laptop or desktop computer:

     https://s3-us-west-2.amazonaws.com/greg-palmer/python-web-service-example/marathon-nginx-launch.json
	 
     https://s3-us-west-2.amazonaws.com/greg-palmer/python-web-service-example/marathon-python-web-service-launch.json
	 
	 

To demonstrate the integration of a Dockerized application with a non-Dockerized 
application, follow these steps:

Step 1. 

Launch a DC/OS cluster with at least 3 private agent nodes and 
1 public agent node (to run Marathon-LB) on.

Also, set up your DC/OS Command Line Interface program for your specific
operating system. See: https://docs.mesosphere.com/1.9/cli/install/

Step 2.

Launch Marathon-LB on the cluster using the Universe->Packages screen
on the DC/OS Dashboard web console. Or use the DC/OS command line interface
with the command:

     $ dcos package install marathon-lb --yes

Step 3.

View the Marathon-LB/HAProxy console by pointing your web broswer to the 
following URL:

     http://<public agent node ip address>:9090/haproxy?stats

If you are running Enterprise DC/OS in STRICT mode, you will have to 
setup a trusted user (service account) to run Marathon-LB. 
See: https://docs.mesosphere.com/1.9/networking/marathon-lb/mlb-auth/

Later, you will use this page to see what service ports were assigned to your 
nginx service and your python web service. 

Step 4.

Start the nginx Docker image as a containerized application on the cluster. 
The CLI command like this can be used:

     $  dcos marathon app add marathon-nginx-launch.json

After the application launches and is healthy, refresh the 
Marathon-LB/HAProxy console to see which service port was assigned. It may
be port 10101.

Point your web browser to the Marathon-LB service port for your nginx application.

    http://<public node ip address>:10101

You should see the default nginx web server welcome screen.

Step 5.

Start the non-dockerized Python web service that will be used to access the 
Dockerized nginx service.

Use the following DC/OS CLI command:

     $  dcos marathon app add marathon-python-web-service-launch.json

After the application launches and is healthy, refresh the 
Marathon-LB/HAProxy console to see which service port was assigned. It may
be port 10102.

Point your web browser to the Marathon-LB service port for your Python
web service application.

    http://<public node ip address>:10102

You should see the default nginx web server welcome screen, but with some added 
text that was inserved by the Python web service.

---

Direct any questions or comments to greg.palmer@mesosphere.com/1