# icinga2-dashing

A Docker image for [dashing-icinga2](https://github.com/Icinga/dashing-icinga2).

## Building

Checkouts git tag `v1.3.0`. Make sure you have at least Docker 17.05, `make` and `git` installed locally.
```
make build v=v1.3.0
```

## Running image

```
docker run -it -p 8005:8005\
 -e ICINGA2_API_HOST='localhost'\
 -e ICINGA2_API_PORT=5665\
 -e ICINGA2_API_USERNAME='root'\
 -e ICINGA2_API_PASSWORD='icinga'\
 deric/icinga2-dashing
```
