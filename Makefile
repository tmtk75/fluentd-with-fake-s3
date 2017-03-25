.DEFAULT_GOAL := help

feed:  ## Feed sample data to forward
	while true; \
	  do echo '{"hello":"world'`date +%s`'"}' >> in/dpkg.log; \
	  sleep 1; \
	done

clean-c:
	docker ps -qa | xargs docker rm -f

clean-all: clean-c  ## Clean up all
	rm -rf fake-s3-root in out

inspect:  ## Print fake-s3 directory
	docker inspect --format "{{range .Mounts}}{{.Source}}{{end}}" issue1827s3_s3_1

aws_opts := --endpoint-url http://127.0.0.1:4569
ls:  ## List fake-s3 recursively
	aws $(aws_opts) s3 ls --recurs s3://test-bucket

t-s3-mk:  ## test: Make a S3 bucket locally
	aws $(aws_opts) s3 mb s3://test

t-s3-cp:  ## test: Copy the README.md to a local S3 bucket
	aws $(aws_opts) s3 cp README.md s3://test
	ls fake-s3-root/test

.PHONY: help
help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'
