kubectl exec -it `kubectl get pods -A | grep -i kubeflow | grep -i mysql | grep -v katib | awk '{print $2}'` -n kubeflow -- mysql -e 'create database mlflowdb;'
kubectl exec -it `kubectl get pods -A | grep -i kubeflow | grep -i mysql | grep -v katib | awk '{print $2}'` -n kubeflow -- mysql -e "use mlflowdb; CREATE USER 'mlflow'@'%' IDENTIFIED WITH mysql_native_password BY 'mlflow'; GRANT ALL ON mlflowdb.* TO 'mlflow'@'%';flush privileges"
helm upgrade --install mlflow apps/mlflow/mlflowchart --namespace $2 --set ns=$2