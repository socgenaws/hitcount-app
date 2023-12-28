pipeline {
    agent { label 'docker-label'}

    stages {
        stage('clone') {
            steps {
              checkout scm
            }     
        }
        stage('docker-build') {
            steps {
               sh "sudo chown ubuntu:ubuntu /var/run/docker.sock"
               sh "docker build -t web ."
               sh "docker tag web devopsjuly22017/web:4.0"
               sh "docker tag web:latest 675467602881.dkr.ecr.us-east-1.amazonaws.com/web:4.0"
            }     
        }
        stage('docker-push') {
            steps { 
              withCredentials([string(credentialsId: 'dockerpassword', variable: 'dockerpass')]) {
                    sh 'docker login -u "devopsjuly22017" -p "${dockerpass}"'
                    sh "docker push devopsjuly22017/web:4.0"
              }
            }     
        }
        stage('ecr-push') {
            steps { 
                withCredentials([[
                $class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: "awscred",
                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                      sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 675467602881.dkr.ecr.us-east-1.amazonaws.com'
                      sh "docker push 675467602881.dkr.ecr.us-east-1.amazonaws.com/web:4.0"
              }
            }     
        }
        stage('deployment') {
          steps { 
              sh "docker -H tcp://172.31.81.28:2375 stack deploy -c stack-dc.yml mystack"
              sh "docker -H tcp://172.31.81.28:2375 stack services mystack"
          }
        }
    }
}
