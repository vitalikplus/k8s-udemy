docker build -t vitalikplus/multi-client:latest -t vitalikplus/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vitalikplus/multi-server:latest -t vitalikplus/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vitalikplus/multi-worker:latest -t vitalikplus/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vitalikplus/multi-client:latest
docker push vitalikplus/multi-server:latest
docker push vitalikplus/multi-worker:latest

docker push vitalikplus/multi-client:$SHA
docker push vitalikplus/multi-server:$SHA
docker push vitalikplus/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vitalikplus/multi-server:$SHA
kubectl set image deployments/client-deployment client=vitalikplus/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vitalikplus/multi-worker:$SHA