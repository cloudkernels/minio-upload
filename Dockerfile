FROM registry.nubificus.co.uk/minio/mc

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
