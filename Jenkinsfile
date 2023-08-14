pipeline {
  agent {
    label 'docker-node'
  }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('docker-hub')
  }
  stages {
    stage('Clone') {
      steps {
        git branch: 'main', url: 'http://192.168.99.102:3000/donetian/exam'
      }
    }
    stage('Build') {
      steps {
        sh 'docker network inspect exam-net >/dev/null 2>&1 || docker network create -d bridge exam-net
        sh 'docker image build -t img-client .'
        sh 'docker image build -t img-storage .'
        sh 'docker image build -t img-genertor .'
      }
    }
    stage('Run') {
      steps {
        sh 'docker container rm -f co-client || true'
        sh 'docker container run -d --name con-client --net exam-net -p 8080:5000 img-client'
        sh 'docker container rm -f co-storage || true'
        sh 'docker container run -d --name con-storage --net exam-net -e MYSQL_ROOT_PASSWORD=\'ExamPa\$\$w0rd\' img-storage'
        sh 'docker container rm -f co-generator || true'
        sh 'docker container run -d --name con-generator --net exam-net img-generator'
      }
    }

    stage('CleanUp') {
      steps {
        sh 'docker container rm -f co-client || true'
        sh 'docker container rm -f co-storage || true'
        sh 'docker container rm -f co-storage || true'
      }
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('Push') {
      steps {
        sh 'docker image tag img-client donetian/fun-facts'
        sh 'docker push donetian/fun-facts'
        sh 'docker image tag img-storage donetian/fun-facts'
        sh 'docker push donetian/fun-facts'
        sh 'docker image tag img-generator donetian/fun-facts'
        sh 'docker push donetian/fun-facts'
      }
    }
    stage('Deploy') {
      steps {
        sh 'docker container rm -f co-client || true'
        sh 'docker container run -d -p 80:80 --name co-client donetian/fun-facts'
        sh 'docker container rm -f co-storage || true'
        sh 'docker container run -d --name con-storage --net exam-net -e MYSQL_ROOT_PASSWORD=\'ExamPa\$\$w0rd\' donetian/fun-facts'
        sh 'docker container rm -f co-generator || true'
        sh 'docker container run -d --name con-generator --net exam-net donetian/fun-facts'
      }
    }
  }
  post {
    always {
      cleanWs()
    }
  }
}
