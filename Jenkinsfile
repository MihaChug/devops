  pipeline {
    parameters {
        string(name: 'url', defaultValue: 'google.com', description: 'URL for check')

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
            emailext body: "URL check status: ${msg}",
            recipientProviders: [[$class: 'RequesterRecipientProvider']], 
            subject: 'Jenkins Build Results'
        }
    }
}
