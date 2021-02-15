.PHONY: build clean clobber run push

REPO = fredblgr/
IMAGE= framac
ARCH = `uname -m`
TAG  = 2021

help:
	@echo "# Available targets:"
	@echo "#   - build: build docker image"
	@echo "#   - clean: clean docker build cache"
	@echo "#   - run: run docker container"
	@echo "#   - push: push docker image to docker hub"

# Build image
build:
	docker build --tag $(REPO)$(IMAGE):$(TAG) .
	@danglingimages=$$(docker images --filter "dangling=true" -q); \
	if [[ $$danglingimages != "" ]]; then \
	  docker rmi $$(docker images --filter "dangling=true" -q); \
	fi

# Create new builder supporting multi architecture images
newbuilder:
	docker buildx create --name newbuilder
	docker buildx use newbuilder

# --load with multiarch image fails (2021-02-15), use --push instead
buildx:
	docker buildx build --push \
	  --platform linux/arm64,linux/amd64 \
	  --tag $(REPO)$(IMAGE):$(TAG) .
	@danglingimages=$$(docker images --filter "dangling=true" -q); \
	if [[ $$danglingimages != "" ]]; then \
	  docker rmi $$(docker images --filter "dangling=true" -q); \
	fi

# Clear caches
clean:
	docker builder prune

clobber:
	docker builder prune --all

run:
	docker run --rm --tty --interactive \
		--volume ${PWD}:/workspace:rw \
		--name $(IMAGE) \
		--env="DISPLAY=host.docker.internal:0" \
		$(REPO)$(IMAGE):$(TAG)

push:
	docker push $(REPO)$(IMAGE):$(TAG)
