
#!/bin/bash
for i in {1..20}
do
    cat <<EOF | oc apply -f -
kind: ResourceQuota
apiVersion: v1
metadata:
  name: user$i-resourcequota
  namespace: user$i-namespace
spec:
  hard:
    limits.cpu: '2'
    limits.memory: 4Gi
    requests.cpu: '1'
    requests.memory: 2Gi
EOF

    cat <<EOF | oc apply -f -
kind: LimitRange
apiVersion: v1
metadata:
  name: cpu-limit-range
  namespace: user$i-namespace
spec:
  limits:
    - type: Container
      default:
        cpu: 400m
      defaultRequest:
        cpu: 200m
EOF

    cat <<EOF | oc apply -f -
kind: LimitRange
apiVersion: v1
metadata:
  name: mem-limit-range
  namespace: user$i-namespace
spec:
  limits:
    - type: Container
      default:
        memory: 400Mi
      defaultRequest:
        memory: 400Mi
EOF

done