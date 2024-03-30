pipeline {
    agent {
        Docker-Server {
        }
    }
    stages {
        stage('Build UI Docker Image') {
            steps {
                container('docker') {
\                      sh 'docker build . -t bitman26/jenkins-kubernetes:${tagname}'
                 }
            }

        }
    }
}
