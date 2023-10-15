```
#!/bin/sh
podName=$(kubectl get pods -n devsecops -o name --field-selector=status.phase=Running | grep openvpn)
kubectl exec -it -n devsecops $podName -- bash
```