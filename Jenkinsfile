pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "melaxa12311/devops-pipeline-visualizer"
        DOCKER_TAG   = "latest"
    }

    stages {

        stage('Checkout') {
            steps {
                // Jenkins already checks out main, but we make it explicit
                git branch: 'main', url: 'https://github.com/melaxa12311/devops-pipeline-visualizer.git'
            }
        }

        stage('Build Frontend') {
            steps {
                sh '''
                cd backend/frontend/dashboard
                npm install
                npm run build || echo "No build script, skipping"
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t $DOCKER_IMAGE:$DOCKER_TAG .
                '''
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker push $DOCKER_IMAGE:$DOCKER_TAG
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                kubectl apply -f k8s/
                '''
            }
        }
    }

    post {
        success {
            echo "🎉 CI/CD Pipeline Completed Successfully!"
        }
        failure {
            echo "❌ CI/CD Pipeline Failed!"
        }
    }
}
