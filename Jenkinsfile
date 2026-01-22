pipeline {
    agent any
    environment {
        IMAGE_NAME = "melaxa75722/devops-pipeline-visualizer"
    }
    stages {
        stage('Checkout') {
            steps { git 'https://github.com/melaxa12311/devops-pipeline-visualizer.git' }
        }
        stage('Build Docker Image') {
            steps { sh 'docker build -t $IMAGE_NAME:$BUILD_NUMBER .' }
        }
        stage('Push Docker Image') {
            steps {
                sh 'docker push $IMAGE_NAME:$BUILD_NUMBER'
                sh 'docker tag $IMAGE_NAME:$BUILD_NUMBER $IMAGE_NAME:latest'
                sh 'docker push $IMAGE_NAME:latest'
            }
        }
        stage('Deploy to Kubernetes') {
            steps { sh 'kubectl apply -f deployment.yaml && kubectl apply -f service.yaml' }
        }
    }
}
