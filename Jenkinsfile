/*
 * Runs a build on a Windows pod.
 * Tested in EKS: https://docs.aws.amazon.com/eks/latest/userguide/windows-support.html
 */
podTemplate(yaml: '''
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: jnlp
    image: jenkins/inbound-agent:windowsservercore-ltsc2019
  - name: shell
    image: us-docker.pkg.dev/gke-windows-tools/docker-repo/gke-windows-builder:latest
    command:
    - $env:DOCKER_CLI_EXPERIMENTAL = 'enabled'
    - docker manifest create us-central1-docker.pkg.dev/gj-playground/windows-bss/multiarch-pd-jenkins:latest us-central1-docker.pkg.dev/gj-playground/windows-bss/pd-jenkins:latest_ltsc2019
    - docker manifest push us-central1-docker.pkg.dev/gj-playground/windows-bss/multiarch-pd-jenkins:latest
  nodeSelector:
    kubernetes.io/os: windows
''') {
    node(POD_LABEL) {
        container('shell') {
            powershell 'set'
        }
    }
}
