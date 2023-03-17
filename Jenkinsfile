pipeline {
    agent any
    tools {
        nodejs 'nodejs'
    }
    parameters {
        choice(name:'VERSION', choices:['1.0', '1.1', '1.2'], description:'Choose the version of the project')

        booleanParam(name :'executeTests', description:'Execute the tests', defaultValue:false)
    }

    stages {
        stage('Build') {
            steps {
                sh 'npm install'
                // sh 'npm run build'
            }
        }
        stage('Test') {
            steps {
                sh 'npm run test'
                echo "Test"
            }
        }
        stage('Build Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: '3fbd7947-4619-4687-a28a-12ce429129c9', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    sh 'docker build -t anhntdocker/test-jenkins-react .'
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                    sh 'docker push anhntdocker/test-jenkins-react'
                }
            }
        }
        stage ('Deploy') {
            steps {
                script {
                    def dockerCmd = 'docker run  -p 3000:3000 -d anhntdocker/test-jenkins-react:latest'
                    sshagent(['ec2-server-key']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@18.192.210.227 ${dockerCmd}"
                    }
                }
            }
        }
    }
}