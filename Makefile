all:
	cd jq && git submodule update --init
	docker buildx build --push --platform linux/arm64,linux/amd64 --sbom=false --provenance=false -t apecloud/curl-jq -f Dockerfile .
