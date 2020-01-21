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
            emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}\n" + "${msg}",
            recipientProviders: [[$class: 'RequesterRecipientProvider']], 
            subject: 'Jenkins Build Results'
        }
    }
}
