#!/bin/bash

PROJECT_NAME=microservices-demo

oc project $PROJECT_NAME;

declare -a StringArray=("coolstore-ui" "catalog" "inventory" "cart" "order" "payment")

oc new-app --image quay.io/rhtw/coolstore-ui:v1.0 --name=coolstore-ui -n $PROJECT_NAME;
oc new-app --image quay.io/rhtw/catalog:v1.3 --name=catalog -n $PROJECT_NAME;
oc new-app --image quay.io/rhtw/inventory:v1.0 --name=inventory -n $PROJECT_NAME;
oc new-app --image quay.io/rhtw/cart:v1.0 --name=cart -n $PROJECT_NAME;
oc new-app --image quay.io/rhtw/order:v1.0 --name=order -n $PROJECT_NAME;
oc new-app --image quay.io/rhtw/payment:v1.0 --name=payment -n $PROJECT_NAME;

for val in ${StringArray[@]}; do
  oc expose svc $val -n $PROJECT_NAME;
done

oc set env deploy/coolstore-ui OPENSHIFT_BUILD_NAMESPACE=$PROJECT_NAME;
oc set env deploy/catalog INVENTORY_URL=inventory:8080;


