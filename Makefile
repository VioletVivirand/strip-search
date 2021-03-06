export GOPATH=$(shell pwd)

all: search.go pkg
	go build --tags "fts5" search.go

pkg:
	go get golang.org/x/crypto/acme/autocert 
	go get github.com/mattn/go-sqlite3

.PHONY: clean deploy restart

clean: 
	rm search

deploy:
	scp js.js index.html results.html search.ahmedaj2:/home/search/search

test:
	go test --tags "fts5"

restart:
	ssh -t root.ahmedaj2 'systemctl stop peanuts-search.service'
	scp search search.ahmedaj2:/home/search/search
	ssh -t root.ahmedaj2 'systemctl start peanuts-search.service'
