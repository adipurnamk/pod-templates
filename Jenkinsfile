/*
 * Runs a build on a Windows pod.
 * Tested in EKS: https://docs.aws.amazon.com/eks/latest/userguide/windows-support.html
 */
podTemplate(yaml: '''
apiVersion: "v1"
kind: "Pod"
metadata:
 spec:
  containers:
  - env:
    image: "jenkins/inbound-agent:4.13-1-jdk11-windowsservercore-ltsc2019"
    name: "jnlp"
    resources:
      limits: {}
      requests:
        memory: "256Mi"
        cpu: "100m"
    volumeMounts:
    - mountPath: "/home/jenkins/agent"
      name: "workspace-volume"
      readOnly: false
    volume:
    - "//./pipe/docker_engine://./pipe/docker_engine"
  nodeSelector:
    kubernetes.io/os: "windows"
  restartPolicy: "Never"
  volumes:
  - emptyDir:
      medium: ""
    name: "workspace-volume"
''') {
    node(POD_LABEL) {
        container('jnlp') {
            powershell '''
            Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/microsoft/Windows-Containers/Main/helpful_tools/Install-DockerCE/install-docker-ce.ps1" -o install-docker-ce.ps1
.\\install-docker-ce.ps1
            Invoke-restmethod -Uri https://raw.githubusercontent.com/Rizal-I/pod-templates/master/Dockerfile > Dockerfile
            docker build -t .
            '''
        }
    }
}
