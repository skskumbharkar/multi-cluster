docker build -t skskumbharkar/multi-client:latest -t skskumbharkar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t skskumbharkar/multi-server:latest -t skskumbharkar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t skskumbharkar/multi-worker:latest -t skskumbharkar/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push skskumbharkar/multi-client:latest
docker push skskumbharkar/multi-server:latest
docker push skskumbharkar/multi-worker:latest

docker push skskumbharkar/multi-client:$SHA
docker push skskumbharkar/multi-server:$SHA
docker push skskumbharkar/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=skskumbharkar/multi-client:$SHA
kubectl set image deployments/server-deployment server=skskumbharkar/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=skskumbharkar/multi-worker:$SHA
