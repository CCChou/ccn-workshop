#!/bin/bash

PROJECT_NAME=microservices-demo
PASSWORD=openshift4!

oc new-project $PROJECT_NAME

# create inventory-service database
oc new-app -n $PROJECT_NAME \
             -e POSTGRESQL_USER=inventory \
             -e POSTGRESQL_PASSWORD=$PASSWORD \
             -e POSTGRESQL_DATABASE=inventory \
             openshift/postgresql:latest \
             --name=inventory-database;

# create catalog-service database
oc new-app -n $PROJECT_NAME \
             -e POSTGRESQL_USER=catalog \
             -e POSTGRESQL_PASSWORD=$PASSWORD \
             -e POSTGRESQL_DATABASE=catalog \
             openshift/postgresql:latest \
             --name=catalog-database;

# create order-service database
oc new-app -n $PROJECT_NAME \
             --image quay.io/openshiftlabs/ccn-mongo:4.0 \
             --name=order-database;

# create cart-service database
oc new-app -n $PROJECT_NAME \
             -e REDIS_PASSWORD=$PASSWORD \
             openshift/redis:6-el8 \
             --name=cart-redis;

sleep 10

# check database pod is up
INVENTORY_DB_NAME=$(oc get pod -l deployment=inventory-database|awk 'FNR==2{print $1}');
echo $INVENTORY_DB_NAME " is READY";

CATALOG_DB_NAME=$(oc get pod -l deployment=catalog-database|awk 'FNR==2{print $1}');
echo $CATALOG_DB_NAME " is READY";

ORDER_DB_NAME=$(oc get pod -l deployment=order-database|awk 'FNR==2{print $1}');
echo $ORDER_DB_NAME " is READY";

CART_RADIS_NAME=$(oc get pod -l deployment=cart-redis|awk 'FNR==2{print $1}');
echo $CART_RADIS_NAME " is READY";