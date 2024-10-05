FROM harbor.nbfc.io/proxy_cache/cloudkernels/mc

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
