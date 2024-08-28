pipeline {
    agent any

    environment {
        COMPOSE_PROJECT_NAME = "dev_project_1" // Set a unique project name
        DOCKER_COMPOSE_FILE = "docker-compose.yml"

        // secrets
        BUILD_ENV = credentials('BUILD_ENV')
    }

    parameters {
            booleanParam(name: 'PLAN_TERRAFORM', defaultValue: false, description: 'Check to plan Terraform changes')
            booleanParam(name: 'APPLY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
            booleanParam(name: 'DESTROY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
            // booleanParam(name: 'BUILD_CONTAINER', defaultValue: false, description: 'Check to build Docker Container')
    }

    stages {
        stage('Clone Repository') {
            steps {
                deleteDir()
                git branch: 'master',
                    url: 'https://github.com/firstpersoncode/app-infra.git'

                sh "ls -lart"
            }
        }

        stage('Terraform Init') {
                    steps {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-jenkins']]){
                            dir('infra') {
                            sh 'echo "=================Terraform Init=================="'
                            sh 'terraform init'
                        }
                    }
                }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    if (params.PLAN_TERRAFORM) {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-jenkins']]){
                            dir('infra') {
                                sh 'echo "=================Terraform Plan=================="'
                                sh 'terraform plan'
                            }
                        }
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    if (params.APPLY_TERRAFORM) {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-jenkins'], string(credentialsId: 'BUILD_ENV', variable: 'BUILD_ENV')]){
                            script {
                                dir('infra') {
                                    sh 'echo "=================Terraform Apply=================="'
                                    sh """
                                    terraform apply -var \
                                    "build_env=${BUILD_ENV}" \
                                    -auto-approve
                                    """
                                }
                            }
                        }
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            steps {
                script {
                    if (params.DESTROY_TERRAFORM) {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-jenkins']]){
                            dir('infra') {
                                sh 'echo "=================Terraform Destroy=================="'
                                sh 'terraform destroy -auto-approve'
                            }
                        }
                    }
                }
            }
        }

        // stage('Build Docker') {
        //     steps {
        //         script {
        //             if (params.BUILD_CONTAINER) {
        //                 sh 'echo "=================Build Container=================="'
        //                 // sh 'sudo apt install docker.io -y'
        //                 // sh 'sudo usermod -aG docker ubuntu'
        //                 // sh 'newgrp docker'
        //                 // sh 'sudo chmod 777 /var/run/docker.sock'
        //                 sh 'docker version'
        //                 // sh 'sudo systemctl start docker'
        //                 // sh 'sudo systemctl enable docker'
        //                 // sh 'sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose'
        //                 // sh 'sudo chmod +x /usr/local/bin/docker-compose'
        //                 // sh 'docker-compose --version'
        //                 sh 'docker-compose -f $DOCKER_COMPOSE_FILE up -d --build'
        //                 sh '''
        //                 containers=$(docker-compose -f $DOCKER_COMPOSE_FILE ps -q)
        //                 for container in $containers; do
        //                     status=$(docker inspect --format="{{.State.Status}}" $container)
        //                     if [ "$status" != "running" ]; then
        //                         echo "Container $container is not running"
        //                         exit 1
        //                     fi
        //                 done
        //                 echo "All containers are running"
        //                 '''
        //             }
        //         }
        //     }
        // }
    }
}