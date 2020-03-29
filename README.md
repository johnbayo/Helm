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

## Usage
* The image is rebuilt on each push to the dev branch

``` bash
~$ docker run -p 80:25478 -it registry.gitlab.com/john.bayo/helm/httpservice/dev:latest
2020/03/29 [INFO] Starting logging.
2020/03/29 [INFO] Setting Log Level to INFO.
2020/03/29 [INFO] Listening on 0.0.0.0:25478
```

## Endpoints

`/ --> Hello Dainty Amalia 200`

`/healthz --> 200` 