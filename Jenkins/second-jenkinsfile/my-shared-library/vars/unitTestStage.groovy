// vars/unitTestStage.groovy
def call() {
    echo "Running unit tests"
    sh "chmod +x gradlew"
    sh "./gradlew test"
}
