pipeline {
  agent any

  stages {

    stage('Checkout') {
      steps {
         git branch: 'main', url: 'https://github.com/melaxa12311/devops-pipeline-visualizer.git'
      }
    }

    stage('Validate Project') {
      steps {
        sh '''
          echo "Checking package.json..."
          cd backend
          node -e "JSON.parse(require('fs').readFileSync('package.json'))"
        '''
      }
    }

    stage('Install Frontend') {
      steps {
        sh '''
          cd backend/frontend/dashboard
          npm install
        '''
      }
    }

    stage('Build Frontend') {
      steps {
        sh '''
          cd backend/frontend/dashboard
          npm run build
        '''
      }
    }

  }

  post {
    success {
      echo " CI Successful"
    }
    failure {
      echo "CI Failed"
    }
  }
}

