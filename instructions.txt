Actions and Commands I used to create a CI/CD Pipeline with Jenkins, Docker, Grafana and Prometheus:

1. vagrant plugin install vagrant-host-shell
2. vagrant up
3. vagrant ssh pipelines.do1.exam
4. sudo visudo -> at the bottom of the file paste "jenkins ALL=(ALL)    NOPASSWD: ALL"
5. sudo usermod -s /bin/bash jenkins
6. su - (password is vagrant) and then su - jenkins 
7. ssh-keygen -t ecdsa -b 521 -m PEM
8. in new terminal - > vagrant ssh containers.do1.exam - >  sudo useradd jenkins &&  sudo passwd jenkins - > steps from 4 to 5
10. in pipelines.do1.exam - > ssh-copy-id jenkins@containers (the password is the same one which we set via passwd)
11. Then I installed Jenkins at http://192.168.111.201:8080 providing the password outputed during the setup in 2.
12. In Manage Jenkins - > Credentials - > System - > Global Credentials - > I created a Global SSH Credential with the generated private key
13. Installed SSH and Generic Webhook Trigger plugins via Manage Jenkins - > Plugins, selecting for Jenkins to be restarted
14. Manage Jenkins ->  System -> SSH Sites -> I added the containers host selecting the SSH credentials I set up in 12
15. Manage Jenkins - > Manage Nodes and Clouds- > New Node - after setting up the label (docker-node) for the node - > selected Only build jobs with label expression matching this node ; Set Launch method to Launch agents via SSH and select the Global SSH Credential 
16. I went to http://192.168.111.202:3000 and installed Gitea
17. Then I made an empty repo called supercalc
18. I copied the run_gitea.sh to the supercalc container and I executed it effectively pushing the supercalc application to the Gitea repo

- docker ps

- docker cp run_gitea.sh bee277c073e1:run_gitea.sh

- docker exec -it bee277c073e1 bash -c "chmod 755 run_gitea.sh && ./run_gitea.sh"

19. I created a new Jenkins Pipeline. In the Configure I set:

- In GitHub Project field the Gitea repo  URL (http://192.168.111.202:3000/donetian/supercalc/)

- Build Triggers - > enabled GitHub hook trigger for GITScm polling

- Build Triggers - > enabled Poll SCM   

- Build Triggers - > enabled Generic Webhook Trigger and in the Token field place "container"

- In the Pipeline script I used the content of the Jenkinsfile, which features the full pipeline - cloning the PHP script from the Gitea repo on the containers host, building an image from the cloned script, starting a Docker container on the containers host, testing the PHP script with simple calculations and then finally when everything is done pushing a Docker image of the PHP script to Docker hub and then deploying the PHP script on the containers host. 

20. In the Gitea repo - > Settings - > Webhook I set the Webhook from the Pipeline's Generic Webhook Trigger plus the token:

http://192.168.111.201:8080/generic-webhook-trigger/invoke?token=container

21. I included the jenkins user on the containers host to the docker group. Then I restarted the Docker service on the containers host and Jenkins on the pipelines host:

- sudo usermod -aG docker jenkins
  
- sudo systemctl restart docker
  
- sudo systemctl restart jenkins

22. I also copied the Dockerfile to the /home/jenkins.
23. Finally I ran Build Now on the Pipeline to check if everything works as expected and I received successful output, which can be found in the success_pipeline_output.txt
