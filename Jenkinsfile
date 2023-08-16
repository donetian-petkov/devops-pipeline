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
        sh 'pwd'
        git branch: 'main', url: 'http://192.168.111.202:3000/donetian/supercalc/'
      }
    }
    stage('Build') {
      steps {
        sh 'docker build -t supercalc --file /home/jenkins/Dockerfile .'
      }
    }
    stage('Run') {
      steps {
        sh 'docker container rm -f co-calc || true'
        sh 'docker container run -d -p 8080:80 --name co-calc supercalc'
      }
    }
    stage('Test') {
      steps {
        script {
          echo 'Test #1 - reachability'
          sh 'echo $(curl --write-out "%{http_code}" --silent --output /dev/null http://192.168.111.202:8080) | grep 200'
          echo 'Test #2 - 40 + 2 = 42'
          sh "curl --silent --data 'opa=40&opr=add&opb=2' http://192.168.111.202:8080| grep 42"
          echo 'Test #3 - 150 - 108 = 42'
          sh "curl --silent --data 'opa=150&opr=sub&opb=108' http://192.168.111.202:8080 | grep 42"
        }
      }
    }
    stage('CleanUp') {
      steps {
        sh 'docker container rm -f co-calc || true'
      }
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('Push') {
      steps {
        sh 'docker image tag supercalc donetian/supercalc'
        sh 'docker push donetian/supercalc'
      }
    }
    stage('Deploy') {
      steps {
        sh 'docker container rm -f calcapp || true'
        sh 'docker container run -d -p 80:80 --name calcapp donetian/supercalc'
      }
    }
  }
  post {
    always {
      cleanWs()
    }
  }
}
