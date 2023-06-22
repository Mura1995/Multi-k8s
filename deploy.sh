docker build -t mura1995/multi-client:latest -t mura1995/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mura1995/multi-server:latest -t mura1995/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mura1995/multi-worker:latest -t mura1995/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mura1995/multi-client:latest
docker push mura1995/multi-server:latest
docker push mura1995/multi-worker:latest

docker push mura1995/multi-client:$SHA
docker push mura1995/multi-server:$SHA
docker push mura1995/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mura1995/multi-server:$SHA
kubectl set image deployments/client-deployment client=mura1995/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mura1995/multi-worker:$SHA