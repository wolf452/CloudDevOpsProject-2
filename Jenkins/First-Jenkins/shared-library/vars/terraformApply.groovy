def call() {
    dir("${TERRAFORM_DIR}") {
        sh 'terraform apply -auto-approve'
    }
}
