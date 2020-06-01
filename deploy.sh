docker build -t ngamenichaka/multi-client:latest -t ngamenichaka/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ngamenichaka/multi-server:latest -t ngamenichaka/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ngamenichaka/multi-worker:latest -t ngamenichaka/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ngamenichaka/multi-client:latest
docker push ngamenichaka/multi-server:latest
docker push ngamenichaka/multi-worker:latest

docker push ngamenichaka/multi-client:$SHA
docker push ngamenichaka/multi-server:$SHA
docker push ngamenichaka/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ngamenichaka/multi-server:$SHA
kubectl set image deployments/server-deployment server=ngamenichaka/multi-client:$SHA
kubectl set image deployments/server-deployment server=ngamenichaka/multi-worker:$SHA