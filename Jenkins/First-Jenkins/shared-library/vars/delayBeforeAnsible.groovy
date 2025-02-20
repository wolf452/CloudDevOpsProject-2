def call() {
    script {
        echo "Waiting for 1 minute before proceeding..."
        sleep time: 1, unit: 'MINUTES'
        echo "Proceeding to run Ansible playbook..."
    }
}
