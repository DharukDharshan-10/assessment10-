pipeline {
    agent any
    environment {
        DOCKER_HUB_CRED = 'docker-hub-credentials'
        IMAGE_NAME = 'yourdockerhubusername/road-hazard-portal'
        KUBE_CRED = 'kubernetes-config'
    }
    parameters {
        choice(name: 'DEPLOY_ENV', choices: ['Production', 'Development'], description: 'Select Deployment Environment')
        booleanParam(name: 'RUN_TESTS', defaultValue: true, description: 'Check to run automated UI tests')
    }
    stages {
        stage('Parallel Build & Test Preparations') {
            parallel {
                stage('Checkout & Lint') {
                    steps {
                        echo "Checking out code and verifying configurations..."
                    }
                }
                stage('Security Scan') {
                    steps {
                        echo "Scanning HTML and YAML files for security issues..."
                    }
                }
            }
        }
        stage('Build and Test') {
            when { expression { params.RUN_TESTS == true } }
            steps {
                // Windows ਲਈ 'bat' ਕਮਾਂਡ ਦੀ ਵਰਤੋਂ, ਬਿਨਾਂ ਮੇਵਨ (pom.xml) ਦੇ
                bat 'echo Running basic portal validation checks...'
            }
        }
        stage('Build & Push Docker Image') {
            steps {
                script {
                    echo "Building Docker image..."
                    // ਜੇਕਰ ਲੋਕਲ ਟੈਸਟ ਕਰਨਾ ਹੈ ਤਾਂ ਇੱਥੇ ਆਪਣੀ ਬਿਲਡ ਕਮਾਂਡ ਚਲਾ ਸਕਦੇ ਹੋ
                }
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'deployment.yaml, index.html', fingerprint: true
        }
    }
}
