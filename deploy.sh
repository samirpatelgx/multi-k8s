docker build -t samirpatelgx/multi-client:latest -t samirpatelgx/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t samirpatelgx/multi-server:latest -t samirpatelgx/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t samirpatelgx/multi-worker:latest -t samirpatelgx/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push samirpatelgx/multi-client
docker push samirpatelgx/multi-server
docker push samirpatelgx/multi-worker


docker push samirpatelgx/multi-client:$SHA
docker push samirpatelgx/multi-server:$SHA
docker push samirpatelgx/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=samirpatelgx/multi-server:$SHA
kubectl set image deployments/client-deployment client=samirpatelgx/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=samirpatelgx/multi-worker:$SHA