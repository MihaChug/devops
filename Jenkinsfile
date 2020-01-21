pipeline {
    agent any
    
    environment {
        url = 'google.com'
        msg = 'BuildError'
    }
    stages {
        stage('Clone repository') {
            steps{
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/master']],
                    extensions: scm.extensions + [[$class: 'CleanCheckout']],
                    userRemoteConfigs: scm.userRemoteConfigs
                ])
            }
        }
        stage ('Check URL'){
            steps{
                script{
                    msg = powershell(returnStdout : true, script: ".\\ps.ps1 -url ${url}")
                }
            }
        }
        stage ('Print Results'){
            steps{
                echo "${msg}"
            }
        }
    }
    post {
        always {
            emailext body: "Site status: ${msg}",
            recipientProviders: [[$class: 'RequesterRecipientProvider']], 
            subject: 'Jenkins Build Results'
            emailext (
                subject: "Jenkins build results",
                body: "Site status: ${msg}",
                to: "mikhail.chugunov@travelline.ru",
                from: "mihachug@gmail.com"
            )
        }
    }
}
