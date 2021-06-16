docker build -t v1 --name scgc-task/webapp-up27l3 .
docker network create --subnet 172.20.235.0/24 WebAppNet-1jLQ
docker run --name scgc_webapp --network WebAppNet-1jLQ --ip 172.20.235.72 --hostname scgc_webapp_2S4JB -p 8422:8422 --restart unless-stopped scgc-task/webapp-up27l3:v1
