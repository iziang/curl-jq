all:
	git clone --depth 1 --branch jq-1.6 https://github.com/jqlang/jq.git
	cd jq && git submodule update --init
	docker buildx build --push --platform linux/arm64,linux/amd64 --sbom=false --provenance=false -t apecloud/curl-jq -f Dockerfile .
