pipeline {
    agent any
    
    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub'
        DOCKER_IMAGE_NAME = 'bitman26/jenkins-kubernetes'
        DOCKER_HOST = 'tcp://172.22.129.214:2376'     }
    
    stages {
        stage('Build and Push Docker Image') {
            steps {
                script {
                    // Clonar o repositório
                    git branch: 'main', credentialsId: 'jenkins-ssh-git', url: 'git@github.com:bitman26/Jenkins-Kubernetes.git'
                    
                    // Construir a imagem Docker na máquina remota
                    sh "docker -H ${DOCKER_HOST} build -t ${DOCKER_IMAGE_NAME}:v${BUILD_NUMBER}.0 ."
                    
                    // Fazer login no Docker Hub (se necessário)
                    sh "docker -H ${DOCKER_HOST} login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                    
                    // Fazer push da imagem para o Docker Hub
                    sh "docker -H ${DOCKER_HOST} push ${DOCKER_IMAGE_NAME}:v${BUILD_NUMBER}.0"
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
