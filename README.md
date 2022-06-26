# README

## Docker build and push

The below commands will build and push the docker image:

    docker build --pull -t "promisepreston/http-app:latest" http-app
    docker push promisepreston/http-app:latest

## Helm deploy

The below commands will deploy the http-app:

    helm lint http-helm --values http-helm/values.yaml
    helm upgrade --atomic --install http-app http-helm  --namespace http --create-namespace --values http-helm/values.yaml --debug --wait --timeout 5m

The below commands will deploy the prometheus app:

    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm repo update
    helm upgrade --install prometheus prometheus-community/prometheus \
    --namespace monitoring \
    --create-namespace
