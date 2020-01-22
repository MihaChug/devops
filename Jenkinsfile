  pipeline {
    parameters {
        string(name: 'url', defaultValue: 'google.com', description: 'URL for check')
        string(name: 'BuildAgent', defaultValue: 'Windows', description: 'Build agent label')
    }
    agent{

        label BuildAgent

    }
    environment {

        msg = 'BuildError'

    }
    stages {

        stage('Clone repository') {

            steps{

                git branch: 'master', url: 'https://github.com/MihaChug/devops/'

            }

        }
        stage ('Check URL'){
            steps{
                script{
                    powershell('git config --global --add http.sslVersion tlsv1.2')
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
            emailext body: "URL check status: ${msg}",
            recipientProviders: [[$class: 'RequesterRecipientProvider']], 
            subject: 'Jenkins Build Results'
        }
    }
}
