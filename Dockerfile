FROM postgres:10.7

COPY scripts/new-docker-entrypoint.sh /usr/local/bin
COPY --chown=postgres:postgres config/* /data-configs/

ENTRYPOINT ["new-docker-entrypoint.sh"]
CMD ["postgres"]
