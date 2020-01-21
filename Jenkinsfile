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
                echo "${msg}"
            }
        }
    }

}
