# Docker Ansible Automation
Git, Docker build, Docker commit, Docker push with Ansible. It is a complementary project to the [devops-test project](https://github.com/karkori/devops-test.git) that I did before.
In this project I have created a playbook to automate the docker image creation (using the Dockerfile definition) and to push it to DockerHub.
   -  Pull the code from your GitLab code (with Ansible!)
   -  Build the Docker image
   -  Push the image
## SSH configuration
To run properly this playbook you must first have the ssh-server properly configured.
### server side
With the dockerfile, I have created an image configured with all the necessary tools including ssh. First make sure the ssh service is running on the remote server:
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
