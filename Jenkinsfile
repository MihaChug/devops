def url = 'google.com'
def response = 'Unknown'

pipeline {
    agent any
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
               PowerShell(". '.\\PS.ps1'; -url $env:url")
            }
        }
    }

}
