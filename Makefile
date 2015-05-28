
TAG ?= latest
REGISTRY ?= quay.io/mojotech

IMAGES := debian node clojure groovy python riemann datomic

.PHONY: $(IMAGES) push push-% clean clean-%

all: $(IMAGES)

debian:
	docker build --force-rm -t $(REGISTRY)/debian:$(TAG) debian

node clojure groovy python: debian
	rm -rf $@.build
	cp -rf $@ $@.build
	sed 's|^FROM.*|FROM $(REGISTRY)/$<:$(TAG)|' $@/Dockerfile > $@.build/Dockerfile
	docker build --force-rm -t $(REGISTRY)/$@:$(TAG) $@.build

riemann datomic: clojure
	rm -rf $@.build
	cp -rf $@ $@.build
	sed 's|^FROM.*|FROM $(REGISTRY)/clojure:$(TAG)|' $@/Dockerfile > $@.build/Dockerfile
	docker build --force-rm -t $(REGISTRY)/$@:$(TAG) $@.build

push: $(IMAGES:%=push-%)
push-%:
	docker push $(REGISTRY)/$*:$(TAG)

clean: $(IMAGES:%=clean-%)
clean-%:
	-rm -rf $(wildcard *.build)
	-docker rmi -f $(REGISTRY)/$*:$(TAG)
