// vars/deployStage.groovy
def call(kubeconfigPath, deploymentYaml) {
    echo "Deploying the application to Kubernetes"
    sh "kubectl --kubeconfig=${kubeconfigPath} apply -f ${deploymentYaml}"
}
