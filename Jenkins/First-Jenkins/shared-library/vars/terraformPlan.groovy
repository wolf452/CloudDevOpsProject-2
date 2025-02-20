def call() {
    dir("${TERRAFORM_DIR}") {
        sh 'terraform plan'
    }
}
