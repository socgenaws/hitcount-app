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
               sh "docker build -t web ."
               sh "docker tag web devopsjuly22017/web:4.0"
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
    }
}
