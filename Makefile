PROJECT = jot
VERSION = v1.0.1
RELEASE = $(PROJECT)-$(VERSION)
DISTDIR = dist/$(RELEASE)
.PHONY: scripts clean

all: win64 win32 linux64 linux32 darwin

install:
	go install

win64:
	GOOS=windows GOARCH=amd64 go build -o $(DISTDIR)/$(PROJECT).exe

win32:
	GOOS=windows GOARCH=386 go build -o $(DISTDIR)/$(PROJECT)32.exe

linux64:
	GOOS=linux GOARCH=amd64 go build -o $(DISTDIR)/$(PROJECT)_linux

linux32:
	GOOS=linux GOARCH=386 go build -o $(DISTDIR)/$(PROJECT)_linux32

darwin:
	GOOS=darwin GOARCH=amd64 go build -o $(DISTDIR)/$(PROJECT)_darwin

scripts:
	cp scripts/* $(DISTDIR) && cp README.md $(DISTDIR) && cp LICENSE $(DISTDIR)

zip: scripts
	cd dist/ && zip -r $(RELEASE).zip $(RELEASE)

tar: scripts
	cd dist/ && tar -czf $(RELEASE).tar.gz $(RELEASE)

package: zip tar

clean:
	rm -rf dist/*
