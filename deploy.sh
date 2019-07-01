docker build -t triphamtran/multi-client:latest -t triphamtran/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t triphamtran/multi-server:latest -t triphamtran/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t triphamtran/multi-worker:latest -t triphamtran/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push triphamtran/multi-client:latest
docker push triphamtran/multi-server:latest
docker push triphamtran/multi-worker:latest

docker push triphamtran/multi-client:$SHA
docker push triphamtran/multi-server:$SHA
docker push triphamtran/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=triphamtran/multi-server:$SHA
kubectl set image deployments/client-deployment client=triphamtran/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=triphamtran/multi-worker:$SHA

