pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "ganapathi282/trend-app"
        AWS_REGION = "us-east-1"
        EKS_CLUSTER = "trend-cluster"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                url: 'https://github.com/ganapathi282/trend-devops-project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:latest .'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS')]) {

                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                }
            }
        }

        stage('Push Image') {
            steps {
                sh 'docker push $DOCKER_IMAGE:latest'
            }
        }

        stage('Deploy to EKS') {
            steps {
                sh '''
                aws eks update-kubeconfig --region $AWS_REGION --name $EKS_CLUSTER
                kubectl apply -f deployment.yaml
                kubectl apply -f service.yaml
                kubectl rollout restart deployment trend-deployment
                '''
            }
        }
    }
}
