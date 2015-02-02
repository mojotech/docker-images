
TAG := latest
REGISTRY := mojotech
IMAGES := debian node clojure

.PHONY: $(IMAGES) push push-% clean clean-%

all: $(IMAGES)

debian:
	docker build --force-rm -t $(REGISTRY)/debian:$(TAG) debian

$(filter-out debian,$(IMAGES)): debian
	sed 's|^FROM.*|FROM $(REGISTRY)/debian:$(TAG)|' $@/Dockerfile | docker build --force-rm -t $(REGISTRY)/$@:$(TAG) -

push: $(IMAGES:%=push-%)
push-%:
	docker push $(REGISTRY)/$*:$(TAG)

clean: $(IMAGES:%=clean-%)
clean-%:
	-docker rmi -f $(REGISTRY)/$*:$(TAG)
