Deploy Containarized ESBs in one VM
=========================================


Getting Started
-----------------------------------------


- Install Docker > 1.4

- Download the scripts contained in this folder

- Build the ESB endpoints and pack them as OSGi bundles (*.jar)


Configuring & Runing
-----------------------------------------

- Specify the download URL for downloading the ServiceMix version in the Dockerfile

- Specify the configuration parameters (e.g. number of containers, ports, sys & container memory usage, etc.) in the provision\_container.sh script

	- NOTE: internal (container) endpoints should match the endpoints specified in the ESB endpoints OSGi bundles!!

- Run ```./provision_caontainer.sh```

- Run ```sudo docker ps``` to verify that the containers are running
