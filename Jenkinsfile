pipeline {
    agent any

    stages {
        stage('git checkout') {
            steps {
                git branch: 'main', credentialsId: 'git-creds', url: 'https://github.com/saiyashu46/learning'
            }
        }
                stage('mvn package') {
            steps {
                sh 'mvn clean package'
            }
        }
                stage('tomcat-checkout') {
            steps {
                sshagent(['tomcat-checkout']) {
                    sh "scp -o StrictHostKeyChecking=no target/*war ec2-user@172.31.18.94:/opt/tomcat9/webapps"
                    sh "ssh ec2-user@172.31.18.94 /opt/tomcat9/bin/shutdown.sh"
                    sh "ssh ec2-user@172.31.18.94 /opt/tomcat9/bin/startup.sh"
                }
            }
        }
    }
}
