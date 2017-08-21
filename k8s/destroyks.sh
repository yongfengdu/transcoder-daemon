#!/bin/bash
NODENAME=${1:-nld15585poc06}
kubectl drain $NODENAME --delete-local-data --force --ignore-daemonsets
kubectl delete node $NODENAME
kubeadm reset
