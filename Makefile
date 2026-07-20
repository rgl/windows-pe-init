GOPATH := $(shell go env GOPATH | tr '\\' '/')
GOEXE := $(shell go env GOEXE)
GOHOSTOS := $(shell go env GOHOSTOS)
GOHOSTARCH := $(shell go env GOHOSTARCH)
GOHOSTARCHVERSION := $(shell go env "GO$(shell go env GOHOSTARCH | tr '[:lower:]' '[:upper:]')")
GORELEASER := $(GOPATH)/bin/goreleaser
GOVERSIONINFO := $(GOPATH)/bin/goversioninfo
SOURCE_FILES := *.go *.manifest *.ico

# see https://github.com/goreleaser/goreleaser
# renovate: datasource=github-releases depName=goreleaser/goreleaser extractVersion=^v?(?<version>2\..+)
GORELEASER_VERSION := 2.17.0

# see https://github.com/josephspurrier/goversioninfo
# renovate: datasource=github-releases depName=josephspurrier/goversioninfo
GOVERSIONINFO_VERSION := 1.7.0

all: clean build

init: $(GORELEASER) $(GOVERSIONINFO)
	go mod download

$(GORELEASER):
	go install github.com/goreleaser/goreleaser/v2@v$(GORELEASER_VERSION)

$(GOVERSIONINFO):
	go install github.com/josephspurrier/goversioninfo/cmd/goversioninfo@v$(GOVERSIONINFO_VERSION)

build: init $(SOURCE_FILES)
	GOAMD64=v3 \
		$(GORELEASER) build --snapshot --skip=validate --clean --single-target

release-snapshot: init $(SOURCE_FILES)
	$(GORELEASER) release --snapshot --skip=publish --clean

release: init $(SOURCE_FILES)
	$(GORELEASER) release --clean

clean:
	rm -rf dist tmp* *.log *.syso *.exe

.PHONY: all init build release release-snapshot clean
