/*
 * Runs a build on a Windows pod.
 * Tested in EKS: https://docs.aws.amazon.com/eks/latest/userguide/windows-support.html
 */
podTemplate(yaml: '''
apiVersion: "v1"
kind: "Pod"
metadata:
  annotations:
    buildUrl: "http://jenkins.default.svc.cluster.local:8080/job/windows-pipeline/43/"
    runUrl: "job/windows-pipeline/43/"
  labels:
    jenkins/jenkins-jenkins-agent: "true"
    jenkins/label-digest: "d4b383c5da0e0e25975e9df937ade53516cab81a"
    jenkins/label: "windows-pipeline_43-kwzgw"
  name: "windows-pipeline-43-kwzgw-07xt9-stgp5"
  namespace: "default"
spec:
  containers:
  - env:
    - name: "JENKINS_SECRET"
      value: "********"
    - name: "JENKINS_TUNNEL"
      value: "jenkins-agent.default.svc.cluster.local:50000"
    - name: "JENKINS_AGENT_NAME"
      value: "windows-pipeline"
    - name: "JENKINS_NAME"
      value: "windows-pipeline"
    - name: "JENKINS_AGENT_WORKDIR"
      value: "/home/jenkins/agent"
    - name: "JENKINS_URL"
      value: "http://jenkins.default.svc.cluster.local:8080/"
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
    - "//./pipe/docker_engine"
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
