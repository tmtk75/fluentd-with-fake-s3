FROM ruby:2.1.4
RUN gem install fluentd -v 0.12.29 --no-ri --no-rdoc
RUN gem install aws-sdk -v 2.6.3 --no-ri --no-rdoc
RUN fluent-gem install fluent-plugin-s3
RUN fluentd --setup ./fluent
ENTRYPOINT ["fluentd"]
CMD ["-c", "./fluent/fluent.conf", "-vv"]
