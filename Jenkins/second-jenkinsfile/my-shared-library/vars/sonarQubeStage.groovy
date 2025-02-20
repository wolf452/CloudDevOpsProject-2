// vars/sonarQubeStage.groovy
def call() {
    withSonarQubeEnv('sonar') {
        echo "Running SonarQube analysis"
        sh "./gradlew sonarqube "
    }
}
