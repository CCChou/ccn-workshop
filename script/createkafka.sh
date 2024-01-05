#!/bin/bash

KAFKA_PROJECT_NAME=amq-streams

oc new-project $KAFKA_PROJECT_NAME;

oc apply -f yaml/kafka.yaml -n $KAFKA_PROJECT_NAME;

oc create -f yaml/paymentstopic.yaml \
  -f yaml/orderstopic.yaml \
  -n $KAFKA_PROJECT_NAME;
