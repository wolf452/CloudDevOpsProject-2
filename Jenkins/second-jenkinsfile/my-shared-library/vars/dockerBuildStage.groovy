// vars/dockerBuildStage.groovy
def call() {
    echo "Building Docker image: $DOCKER_IMAGE"
    sh "docker build -t $DOCKER_IMAGE ."
}
