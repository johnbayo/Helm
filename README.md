# helm

This repository contains the code for the helm challenge. It is deployed in my gitlab registry which is accessible publicly

## Perequisites
* Azure or any Cloud Environment or Kubernetes Cluster accessible from your control machine
* docker  on your control machine for testing in dev branch

## License

See `LICENSE`

## Copyright

(c) John O. Adebayo 2020


## Tools

* kubernetes
* Docker
* gitlab
* github
* Terraform (optional)
* Azure (optional)
* helm
* kubectl

## Procedure

create 3 branches for the Devops lifecycle (dev,tua,prod)

### dev
this is the development branch 

* Docker image is built in this branch
* Using a github(github.com) personal access token, my gitlab (gitlab.com) project can access changes in github,  subsequently build new images from changes in my github repo
* images can be pulled in dev branch and tested

### tua
this is the staging area where the image is validated to know if its production ready, in a kubernetes environment

* this branch is triggered by pushing a commit tag to tua branch only
* images are tagged from dev in this script, "export_commit_for_tua.sh". default tag is dev, the commit hash can also be used
* helm binary from the bin folder can deploy the chart to the kubernetes cluster.


### prod
this is the production branch where the image is deployed to the production environment

* this branch is also triggered by push a commit tag to prod only
* images are tagged from tua (staging area) to prod 
* helm binary from the bin folder can deploy the chart to the kubernetes cluster

## installation

* download helm, kubectl, terraform (optional) binaries in the bin folder

``` bash
## helm ##
~$ wget https://get.helm.sh/helm-v3.1.2-linux-amd64.tar.gz -O /tmp/helm-v3.1.2-linux-amd64.tar.gz; tar -zxvf /tmp/helm-v3.1.2-linux-amd64.tar.gz -C /tmp/bin; mv /tmp/bin/linux-amd64/helm bin/; rm -rf bin/linux-amd64/;
## kubectl ##
~$ curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl; chmod +x kubectl;mv kubectl bin/;
## terraform ##
~$ wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip -O /tmp/terraform.zip; unzip /tmp/terraform.zip -d bin;
```

* configure the pipelines stages as seen in .gitlab-ci.yml for the different branches

* deploy your cluster and output your cluster config (optional and out of scope)
``` bash
~$ terraform output kube_config > ../k8s/config
```

*  configure the helm chart

``` bash
## create the chart ##
~$ ./bin/helm create httpservice

## change appVersion from 1.16.0 in Chart.yml ##
~$ vim k8s/httpservice/Chart.yaml
appVersion: latest

## add the configmap template and remove the ingress template ##
~$ vim k8s/httpservice/templates/configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "httpservice.fullname" . }}
  namespace: {{ .Values.namespace }}
  labels:
    {{- include "httpservice.labels" . | nindent 4 }}
data:
  myValue: {{ .Values.configmapvalue }}


# add namespace in all templates metadata (deployment,service,serviceaccount).yaml
metadata:
...
  namespace: {{ .Values.namespace }}
```

# change replica count in values.yaml
# define configmap value
# change service type and add target port
# change image pull policy
~$ vim k8s/httpservice/values.yaml
replicaCount: 3

image: registry.gitlab.com/john.bayo/helm/httpservice

pullPolicy: Always

service:
  type: NodePort
  port: 80
  targetPort: 25478

configmapvalue: foo
```

* deploy the chart

``` bash
~$ git tag 0.1
~$ git push origin 0.1
## wait about 2mins for the image to be tagged from tua to prod ##
# N.B the deploy script can also be run in the pipeline, but for this project we will trigger from the control host
~$ ./deploy.sh
```

## Endpoints

`/ --> Hello Dainty Amalia 200`

`/healthz --> 200` 