pipeline {
    agent any

    environment {
        SELENIUM_BROWSER = 'chrome'
    }

    stages {
        stage('Build') {
            steps {
                    withMaven (maven: 'mvn', jdk: 'OJDK11') {
                        withCredentials([usernamePassword(credentialsId: 'gpg', passwordVariable: 'KEYPW_VAR', usernameVariable: 'KEYID_VAR')])
                        {
                            sh 'mvn clean verify -Dgpg.executable=gpg -Dgpg.keyname=${KEYID_VAR} -Dgpg.passphrase=${KEYPW_VAR}'
                        }
                    }
            }
        }

        stage('Deploy') {
            when {
               anyOf {
                    branch 'main'
                    branch '2020.06'
               }
            }
            steps {
                    withMaven (maven: 'mvn', jdk: 'OJDK11', mavenSettingsConfig: 'maven-deploy-settings') {
                        withCredentials([
                        usernamePassword(credentialsId: 'ossrhs01', passwordVariable: 'PASSWORD_VAR', usernameVariable: 'USERNAME_VAR'),
                        usernamePassword(credentialsId: 'gpg', passwordVariable: 'KEYPW_VAR', usernameVariable: 'KEYID_VAR')
                        ])
                        {
                            sh 'mvn deploy -Dgpg.executable=gpg -Dgpg.keyname=${KEYID_VAR} -Dgpg.passphrase=${KEYPW_VAR} -Dossrhs01.username=${USERNAME_VAR} -Dossrhs01.password=${PASSWORD_VAR}'
                        }
                    }
            }
        }
    }

}
