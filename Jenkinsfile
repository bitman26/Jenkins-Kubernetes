env.DOCKER_HOST = 'tcp://172.22.129.214:2376'

pipeline {
    agent none

    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub'
        DOCKER_IMAGE_NAME = 'bitman26/jenkins-kubernetes'
    }
    
    stages {
        stage('Build and Push Docker Image') {
            agent {
                label 'docker-cloud01'
            }
            steps {
                script {
                    // Clone do repositório
                    git branch: 'main', credentialsId: 'jenkins-ssh-git', url: 'git@github.com:bitman26/Jenkins-Kubernetes.git'
                    // Construir a imagem Docker
                    docker.build("${DOCKER_IMAGE_NAME}:v${BUILD_NUMBER}.0")
                    // Fazer push da imagem para o Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        docker.image("${DOCKER_IMAGE_NAME}:v${BUILD_NUMBER}.0").push()
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline executada com sucesso!'
        }
        failure {
            echo 'Falha na execução da pipeline.'
        }
    }
}
