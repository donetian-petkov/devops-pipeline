# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.ssh.insert_key = false

  config.vm.define "pipelines.do1.exam" do |pipelines|
    pipelines.vm.box="shekeriev/centos-stream-9"
    pipelines.vm.hostname = "pipelines.do1.lab"
    pipelines.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
    end
    pipelines.vm.network "private_network", ip: "192.168.111.201"
    pipelines.vm.network "forwarded_port", guest: 8080, host: 8080
    pipelines.vm.provision "shell", path: "add_hosts.sh"
    pipelines.vm.provision "shell", path: "install_jenkins.sh"
    pipelines.vm.provision "shell", path: "install_docker.sh"
    pipelines.vm.provision "shell", path: "install_node_exporter.sh"
    pipelines.vm.provision "file", source: "./Jenkinsfile", destination: "./Jenkinsfile"

  end


  config.vm.define "containers.do1.exam" do |containers|
      containers.vm.box="shekeriev/centos-stream-9"
      containers.vm.hostname = "containers.do1.lab"

      containers.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "3072"]
        vb.customize ["modifyvm", :id, "--cpus", "2"]
      end

      containers.vm.network "private_network", ip: "192.168.111.202"
      containers.vm.network "forwarded_port", guest: 5000, host: 8081

      containers.vm.provision "file", source: "./docker-compose.yml", destination: "./docker-compose.yml"

      containers.vm.provision "shell", path: "add_hosts.sh"
      containers.vm.provision "shell", path: "install_docker.sh"
      containers.vm.provision "shell", path: "run_docker.sh"

      
      containers.vm.provision "file", source: "./run_gitea.sh", destination: "./run_gitea.sh"
      
      containers.vm.provision "shell", path: "install_node_exporter.sh"

    end

     config.vm.define "monitoring.do1.exam" do |monitoring|
        monitoring.vm.box="shekeriev/centos-stream-9"
        monitoring.vm.hostname = "monitoring.do1.lab"
        monitoring.vm.provider :virtualbox do |vb|
          vb.customize ["modifyvm", :id, "--memory", "2048"]
          vb.customize ["modifyvm", :id, "--cpus", "2"]
        end
        monitoring.vm.network "private_network", ip: "192.168.111.203"
        monitoring.vm.network "forwarded_port", guest: 8080, host: 8082
        monitoring.vm.provision "shell", path: "add_hosts.sh"
              monitoring.vm.provision "shell", path: "install_prometheus.sh"
              monitoring.vm.provision "shell", path: "install_docker.sh"
              monitoring.vm.provision "shell", path: "install_grafana.sh"
      end

end
