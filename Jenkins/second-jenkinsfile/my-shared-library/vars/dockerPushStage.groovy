// vars/dockerPushStage.groovy
def call() {
    echo "Pushing Docker image to Docker Hub"
    sh "docker push $DOCKER_IMAGE"
}
