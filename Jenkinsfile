pipeline {
    agent any
    parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'master', description: 'Branch name to build')
    }
    stages {
        stage('Checkout') {
            steps {
                script {
                    // Clean workspace before checkout
                    deleteDir()
                    
                    // Checkout the master branch from the Git repository
                    git branch: 'master', url: 'https://github.com/nileshmuthal1317/cicdproject.git'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("nileshmuthal1317/myproject:${env.BUILD_ID}")
                }
            }
        }
        stage('Publish Docker Image') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'nileshmuthal1317-dockerhub', variable: 'DOCKERHUB_TOKEN')]) {
                        echo 'Logging in to Docker Hub...'
                        sh 'echo $DOCKERHUB_TOKEN | docker login -u nileshmuthal1317 --password-stdin'

                        echo 'Pushing Docker image to Docker Hub...'
                        sh 'docker push nileshmuthal1317/myproject:${env.BUILD_ID}'
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs() // Clean workspace after the build
        }
    }
}
