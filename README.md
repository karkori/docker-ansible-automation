# Docker Ansible Automation
Git, Docker build, Docker commit, Docker push with Ansible. It is a complementary project to the [devops-test project](https://github.com/karkori/devops-test.git) that I did before.
In this project I have created a playbook to automate the docker image creation (using the Dockerfile definition) and to push it to DockerHub.
   -  Pull the code from your GitLab code (with Ansible!)
   -  Build the Docker image
   -  Push the image
## SSH configuration
To run properly this playbook you must first have the ssh-server properly configured.
### server side
#### Run the docker image
This Docker image is already hosted on Dockerhub. You just need to run the container:
```
sudo docker run --rm --privileged -v /var/lib/docker -p 80:8080 --cap-add=NET_ADMIN -it bourarach/ubuntu-docker:3 sh
```
in my case I am running the container with the --privileged argument because I had problems launching the docker service with the dockerd command.

#### Run the ssh service
In this images I have created an configured image with all the necessary tools including ssh. Once the container is running first make sure that the ssh service is running on the remote server:
```
service ssh status
```
If it is not running run the following command:
```
service ssh start
```
In this image we are also running docker within docker, so we must be sure that the docker service is running:
```
dockerd &
```
### Client side
We have to secure the ssh keys to be able to authenticate to the remote server. We can do it with:
```
ssh-keygen
```

in case of errors:
```
 ssh-keygen -R 172.17.0.2
```
Copying/installing the SSH keys to the remote server:
```
ssh-copy-id -i ~/.ssh/id_rsa root@172.17.0.2
```
## Run Ansible Playbook
To run the Ansible playbook we must be located within the root directory of the project and run:
```
ansible-playbook -i hosts playbook.yaml
```
With this command we are able to:
-  Pull the code from your GitLab code
-  Build the Docker image
-  Push the image
