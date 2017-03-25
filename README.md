# README

A test env for fluentd-plugin-s3 with fake-s3.

Open three terminals like [1], [2] and [3].

    [1]$ docker-compose up  ## Take a while if first time
    
    [2]$ make feed
    
    [3]$ find ./fake-s3-root
    [3]$ make ls

