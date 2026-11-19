FROM redis:latest
CMD ["redis-server"]
# docker build -f docker/Redis.Dockerfile -t redisnew .
# docker run -d --name myredis redisnew
# docker exec -it myredis redis-cli
