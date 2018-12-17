# windows-tools-release

Contains miscellaneous Windows packages to be BOSH-deployed

Mostly used to install packages on a Concourse windows-worker

## Tools Installed
- [bosh-cli](https://github.com/cloudfoundry/bosh-cli)
- [cmake](https://cmake.org/download/)
- [docker](https://docs.docker.com/docker-for-windows/install/)
- [git](https://gitforwindows.org/)
- [Golang](https://golang.org/dl/)
- [mingw32](http://www.mingw.org/)
- [mingw64](http://www.mingw.org/)
- [packer](https://www.packer.io/downloads.html)
- [processhacker](http://processhacker.sourceforge.net/downloads.php)
- [Ruby](https://rubyinstaller.org/downloads/)
- [GNU make](http://gnuwin32.sourceforge.net/packages/make.htm)

### Docker TLS usage
1.) Add variables to manifest
```
...
instance_groups:
- name: windows-vm
  instances: 1
  jobs:
    - name: docker
      release: windows-tools
      properties:
        docker:
          tls: ((docker_tls))

...
variables:
- name: default_ca
  type: certificate
  options:
    is_ca: true
    common_name: ca

- name: docker_tls
  type: certificate
  options:
    ca: default_ca
    common_name: ((internal_ip))
    alternative_names:
    - docker.local
    - 127.0.0.1
    - ((internal_ip))
    extended_key_usage:
    - client_auth
    - server_auth
```

2.) Generate creds and Extract certs
```
bosh deploy manifest.yml -v internal_ip=<vm ip> --vars-store creds.yml

bosh interpolate creds.yml --path=/docker_tls/ca > ~/.docker/my-windows-vm/ca.pem
bosh interpolate creds.yml --path=/docker_tls/certificate > ~/.docker/my-windows-vm/cert.pem
bosh interpolate creds.yml --path=/docker_tls/private_key > ~/.docker/my-windows-vm/key.pem
```

3.) Use the client
```
export DOCKER_HOST=tcp://<vm ip>:2376
export DOCKER_TLS_VERIFY=1
export DOCKER_CERT_PATH=~/.docker/my-windows-vm

docker run -it microsoft/nanoserver:<os tag>
```
