docker build -t itaybracha/multi-client:latest -t itaybracha/multi-client:$SHA ./client/Dockerfile ./client
docker build -t itaybracha/multi-server:latest -t itaybracha/multi-server:$SHA ./server/Dockerfile ./server
docker build -t itaybracha/multi-worker:latest -t itaybracha/multi-worker:$SHA ./worker/Dockerfile ./worker

docker push itaybracha/multi-client:latest
docker push itaybracha/multi-server:latest
docker push itaybracha/multi-worker:latest

docker push itaybracha/multi-client:$SHA
docker push itaybracha/multi-server:$SHA
docker push itaybracha/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=itaybracha/multi-server:$SHA
kubectl set image deployments/client-deployment client=itaybracha/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=itaybracha/multi-worker:$SHA