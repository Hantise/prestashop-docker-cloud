# prestashop-docker-cloud
One example to deploy prestashop in staging or pre-production 

### Here is an example to run prestashop in staging
##### Files are the following 
* A Dockerfile to build the image and pull the last code from the folder web (empty for now but with prestashop)
* A folder config_files to (same from Prestashop required)
* A stack-yml for Docker-Cloud with a proxy and a virtualhost defined
