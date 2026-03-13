pipeline {
    agent any

    environment {
        IMAGE_NAME = "minn01/ead-mern-todo-app:latest"
    }

    stages {

        stage('Build') {
            steps {
                sh '''
                cd TODO/todo_backend
                npm install

                cd ../todo_frontend
                npm install
                '''
            }
        }

        stage('Containerise') {
            steps {
                sh '''
                docker build -t $IMAGE_NAME .
                '''
            }
        }

        stage('Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker push $IMAGE_NAME
                    '''
                }
            }
        }

        stage('Complete') {
            steps {
                echo 'Pipeline finished successfully'
            }
        }
    }
}