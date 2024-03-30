pipeline {
    agent any
    
    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub'
        DOCKER_IMAGE_NAME = 'bitman26/jenkins-kubernetes'
        SSH_CREDENTIALS_ID = 'ssh-key-docker'
        SSH_USER = 'teste'
        SSH_HOST = '172.22.129.214'
    }


    stages {
        stage('GIT Stage') {
            steps {
               // Clonar o repositório via SSH
               git branch: 'main', credentialsId: 'jenkins-ssh-git', url: 'git@github.com:bitman26/Jenkins-Kubernetes.git'
                script {
                    // Copiar o repositório clonado para o servidor remoto
                    sshagent(credentials: ['${SSH_CREDENTIALS_ID}']) {
                      sh "scp  -o StrictHostKeyChecking=no -r Jenkins-Kubernetes ${SSH_USER}@${SSH_HOST}:/home/teste"
                    }
                } 
            } 
        }
        
        stage('Build and Push Docker Image') {
            steps {
                script {
                    // Construir a imagem Docker
                    sshagent(credentials: ['${SSH_CREDENTIALS_ID}']) {
                        sh "ssh ${SSH_USER}@${SSH_HOST} 'cd Jenkins-Kubernetes && docker build -t ${DOCKER_IMAGE_NAME}:v${BUILD_NUMBER}.0 .'"
                    }

                    // Fazer login no Docker Hub
                    sshagent(credentials: ['${SSH_CREDENTIALS_ID}']) {
                        sh "ssh ${SSH_USER}@${SSH_HOST} 'docker login -u ${DOCKER_CREDENTIALS_ID} -p ${DOCKER_CREDENTIALS_ID}'"
                    }

                    // Fazer push da imagem para o Docker Hub
                    sshagent(credentials: ['${SSH_CREDENTIALS_ID}']) {
                        sh "ssh ${SSH_USER}@${SSH_HOST} 'docker push ${DOCKER_IMAGE_NAME}:v${BUILD_NUMBER}.0'"
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
