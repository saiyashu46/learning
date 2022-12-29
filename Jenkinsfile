pipeline {
    agent any

    stages {
        
        stage('Maven Build') {
            steps {
                sh "mvn clean package"
            }
        }
        
        stage('Docker Build') {
            steps {
                sh "docker build . -t saiyashu46/learning:${commit_id()}"
            }
        }
        stage('Docker Push') {
            steps {
                withCredentials([string(credentialsId: 'docker-hub-demo', variable: 'hubPass')]) {
                    sh "docker login -u saiyashu46 -p ${hubPass}"
                    sh "docker push saiyashu46/learning:${commit_id()}"
                }
            }
        }
        stage('Docker Deploy') {
            steps {
                sshagent(['docker-hub']) {
                    sh "ssh -o StrictHostKeyChecking=no  ec2-user@172.31.33.119 docker rm -f learning"
                    sh "ssh  ec2-user@172.31.33.119 docker run -d -p 8080:8080 --name learning saiyashu46/learning:${commit_id()}"
                }
            }
        }

    }
}
def commit_id(){
    id = sh returnStdout: true, script: 'git rev-parse HEAD'
    return id
}
