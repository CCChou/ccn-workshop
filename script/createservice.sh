#!/bin/bash

PROJECT_NAME=microservices-demo
KAFKA_HOST=my-cluster-kafka-bootstrap.amq-streams.svc:9092

oc project $PROJECT_NAME;

declare -a StringArray=("coolstore-ui" "catalog" "inventory" "cart" "order" "payment")

oc new-app --image quay.io/rhtw/coolstore-ui:1.0.0 --env=OPENSHIFT_BUILD_NAMESPACE=$PROJECT_NAME --name=coolstore-ui -n $PROJECT_NAME;
oc new-app --image quay.io/rhtw/catalog:1.3.0 --env=INVENTORY_URL=inventory:8080 --name=catalog -n $PROJECT_NAME;
oc new-app --image quay.io/rhtw/inventory:1.0.0 --name=inventory -n $PROJECT_NAME;
oc new-app --image quay.io/rhtw/cart:1.1.0 --env=KAFKA_HOST=$KAFKA_HOST --name=cart -n $PROJECT_NAME;
oc new-app --image quay.io/rhtw/order:1.1.0 --env=KAFKA_HOST=$KAFKA_HOST --name=order -n $PROJECT_NAME;
oc new-app --image quay.io/rhtw/payment:1.1.0 --env=KAFKA_HOST=$KAFKA_HOST --name=payment -n $PROJECT_NAME;

for val in ${StringArray[@]}; do
  oc expose svc $val -n $PROJECT_NAME;
done
