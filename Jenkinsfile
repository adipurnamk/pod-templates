pipeline {
    agent {
  kubernetes {
    cloud 'kubernetes'
    inheritFrom 'default'
    nodeSelector 'windows'
    yaml '''apiVersion: v1
kind: Pod
metadata:
  labels:
    run: windows
  name: windows
spec:
  containers:
  - image: us-docker.pkg.dev/gke-windows-tools/docker-repo/gke-windows-builder:latest
    name: windows
  dnsPolicy: ClusterFirst
  restartPolicy: Always
  nodeSelector:
    beta.kubernetes.io/os: windows'''
  }
 }
}
