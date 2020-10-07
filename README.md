### Docker Run
```
docker run \
--detach \
--name nzbget \
--restart unless-stopped \
--publish 6789:6789 \
--volume nzbget-config:/config \
--volume nzbget-data:/data \
bmoorman/nzbget:latest
```

### Docker Compose
```
version: "3.7"
services:
  nzbget:
    image: bmoorman/nzbget:latest
    container_name: nzbget
    restart: unless-stopped
    ports:
      - "6789:6789"
    volumes:
      - nzbget-config:/config
      - nzbget-data:/data

volumes:
  nzbget-config:
  nzbget-data:
```

### Environment Variables
|Variable|Description|Default|
|--------|-----------|-------|
|TZ|Sets the timezone|`America/Denver`|
