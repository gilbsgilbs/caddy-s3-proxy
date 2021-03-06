
.PHONY: build
build: caddy

caddy: *.go go.mod Makefile
	# go get -u github.com/caddyserver/xcaddy/cmd/xcaddy  -- install xcaddy if you don't have it
	xcaddy build --output caddy --with github.com/lindenlab/caddy-s3-proxy=${CURDIR}

.PHONY: docker
docker: caddy  ## build a docker image for caddy with the s3proxy
	@docker build -t caddy .

.PHONY: test
test:  ## Run go test on source base
	@go test --race

.PHONY: lint
lint:  ## Run golint on source base
	@golangci-lint run --no-config ./...

.DEFAULT_GOAL := help
.PHONY: help
help:   ## Display this help message
	@grep -E '^[ a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

.PHONY: version
version:  ## Show the version the Makefile will build
	@echo ${VERSION}
	@echo client version: $(shell cat client/Version)
