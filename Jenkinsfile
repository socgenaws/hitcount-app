pipeline {
    agent { label docker-label}

    stages {
        stage('clone') {
            steps {
              checkout scm
            }     
        }
        stage('docker-build') {
            steps {
               sh "docker build -t web:1.0 ."
            }     
        }
    }
}
