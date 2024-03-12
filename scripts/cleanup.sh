#!/bin/bash
for i in {1..20}
do
    oc project user$i-namespace
    oc delete OpenLibertyApplication --all
    oc delete secret --field-selector type=kubernetes.io/tls
done
