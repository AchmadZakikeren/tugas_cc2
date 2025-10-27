pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        IMAGE_NAME = "aerokrn/mobile-app"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Checkout') {
            steps {
                echo '📦 Mengambil source code...'
                checkout scm
            }
        }

        stage('Build Expo (local)') {
            steps {
                bat 'npm install'
                bat 'npx eas build --platform android --local --non-interactive'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo '🛠 Build Docker image...'
                    bat "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Login to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat 'echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin'
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                bat "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }
    }

    post {
        success {
            echo '✅ Build APK & Push Docker berhasil!'
        }
        failure {
            echo '❌ Gagal, cek log Jenkins.'
        }
    }
}
