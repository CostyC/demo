pipeline {
  agent any
  environment {
        DOCKERHUB_LOGIN = credentials('dockerhub')
    }
  stages {
    stage('Build docker image') {
      steps {
        sh 'docker build -t costyc/demo-app:$BUILD_NUMBER .'
      }
    }  
    stage('Login to dockerhub') {
      steps {
        sh 'echo $DOCKERHUB_LOGIN_PSW | docker login -u $DOCKERHUB_LOGIN_USR --password-stdin'
      }
    }  
    stage('Push image to docker hub') {
      steps {
        sh 'docker push costyc/demo-app:$BUILD_NUMBER'
      }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
}