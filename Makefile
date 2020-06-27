build:
	GOOS=linux go build plugin.go
clean:
	rm plugin
docker-build:
	docker build -t <docker-image-name:label> .
docker-push:
	docker push <docker-image-name:label>
