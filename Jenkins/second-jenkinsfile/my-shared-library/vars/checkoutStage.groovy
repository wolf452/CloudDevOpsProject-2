// vars/checkoutStage.groovy
def call() {
    echo "Cloning the source code from GitHub"
    git url: 'https://github.com/wolf452/CloudDevOpsProject.git', branch: 'main'
}
