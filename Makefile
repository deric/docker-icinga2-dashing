NAME=deric/icinga2-dashing
VERSIONS=$(shell cat versions.txt)
all: releases
v ?= v1.3.0

bash: build
	docker run --entrypoint /bin/bash -it $(NAME)

release: build
	$(call RELEASE,$(v))

build:
	$(call BUILD,$(v));

define BUILD
	test -d dashing-icinga2 || git clone https://github.com/Icinga/dashing-icinga2.git
	(cd dashing-icinga2 && git checkout $(1))
	docker build -t $(NAME) .
endef

define RELEASE
	$(call BUILD,$(1));
	docker tag $(NAME) $(NAME):$(1)
	docker push $(NAME):$(1)
endef

run: build
	docker run -it $(NAME)
