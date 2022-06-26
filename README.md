# README

The application contains 2 directories:

* **http-app**: This is the directory containing a Ruby on Rails App that runs a program to find current weather details of Tallin using openweathermap public api. The data is exported to the Prometheus data store using Prometheus Client Exporter.
* **http-helm**: This is the directory containing the helm charts for deploying the `http-app` application as well as the `Prometheus` monitoring tool.

## Docker build and push

The application is built and pushed to a Docker repository - `promisepreston/http-app`.

The below commands will build and push the docker image:

    docker build --pull -t "promisepreston/http-app:latest" http-app
    docker push promisepreston/http-app:latest

## Helm deploy

The application is deployed using Helm to a Kubernetes cluster.

The below commands will deploy the http-app:

    helm lint http-helm --values http-helm/values.yaml
    helm upgrade --atomic --install http-app http-helm  --namespace http --create-namespace --values http-helm/values.yaml --debug --wait --timeout 5m

The below commands will deploy the prometheus app:

    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm repo update
    helm upgrade --install prometheus prometheus-community/prometheus \
    --namespace monitoring \
    --create-namespace

## Accessing the application

The application is was tested on a minikube cluster. After deploying the application using the helm commands above you can test using the commands below:

    export NODE_PORT=$(kubectl get --namespace http -o jsonpath="{.spec.ports[0].nodePort}" services http-app)
    export NODE_IP=$(kubectl get nodes --namespace http -o jsonpath="{.items[0].status.addresses[0].address}")
    echo http://$NODE_IP:$NODE_PORT

The above commands will generate the URL where you can access the application.

Please let me know if there are any concerns with the implementation and I will be pleased to clarify.
