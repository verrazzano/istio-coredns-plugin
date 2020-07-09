# Copyright (C) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

build:
	GOOS=linux go build plugin.go
clean:
	rm plugin
docker-build:
	docker build -t <docker-image-name:label> .
docker-push:
	docker push <docker-image-name:label>
