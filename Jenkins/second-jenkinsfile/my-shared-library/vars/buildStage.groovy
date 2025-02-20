// vars/buildStage.groovy
def call() {
    echo "Building the project with Gradle"
    sh "./gradlew build"
}
