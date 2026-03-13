pipeline {
    agent any

    stages {

        stage('Build') {
            agent {
                docker { image 'node:22-alpine' }
            }
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
                sh 'docker build -t minn01/finead-todo-app:latest .'
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
                    docker push minn01/finead-todo-app:latest
                    '''
                }
            }
        }

        stage('Complete') {
            steps {
                echo "Pipeline completed successfully"
            }
        }
    }
}