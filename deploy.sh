docker build -t dpmidyett/multi-client:latest -t dpmidyett/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dpmidyett/multi-server:latest -t dpmidyett/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dpmidyett/multi-worker:latest -t dpmidyett/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dpmidyett/multi-client:latest
docker push dpmidyett/multi-client:$SHA
docker push dpmidyett/multi-server:latest
docker push dpmidyett/multi-server:$SHA
docker push dpmidyett/multi-worker:latest
docker push dpmidyett/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=stephengrider/multi-server:$SHA
kubectl set image deployments/client-deployment client=stephengrider/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker:$SHA