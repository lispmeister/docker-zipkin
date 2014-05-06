# docker-zipkin

Dockerfiles for starting a Zipkin instance backed by Cassandra

## Build Images

Please run `cd deploy; ./build.sh` to build the images on your own computer.
You may change the **PREFIX** in build.sh and deploy.sh as you see fit.

## Deploy Zipkin

Before you start, please edit the `deploy.sh` to change the URL to match your
Docker host IP, you may also change the port if needed. Now, run `cd deploy;
./deploy.sh` to start a complete Zipkin instance. If you did not build the
images before, you will pull the published images from Docker INDEX.

Note that if you changed PREFIX in build.sh to build your own images, you need
to make same changes here in deploy.sh. Otherwise, it will still use the
standard images pushed by me.

## Notes

Docker-Zipkin starts the services in their own container: zipkin-cassandra,
zipkin-collector, zipkin-query, zipkin-web and only link required dependencies
together.

The started Zipkin instance would be backed by a single node Cassandra. By
default, the collector port is not mapped to public. You will need to link
containers that you wish to trace with zipkin-collector or you may change the
respective line in deploy.sh to map the port.

All images with the exception of zipkin-cassandra are sharing a base image:
zipkin-base. zipkin-base and zipkin-cassandra is built on debian:sid.

## Notes (lispmeister)

When booting the images via boot2docker on OSX you will need to make
sure the guest VM ports are forwarded. Here's an example that forwards
the relevant ports for the Zipkin services:

    # vm must be powered off 
    boot2docker stop
    # collector
    VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port9410,tcp,127.0.0.1,9410,,9410"
    VBoxManage modifyvm "boot2docker-vm" --natpf1 "udp-port9410,udp,127.0.0.1,9410,,9410"
    VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port9900,tcp,127.0.0.1,9900,,9900"
    # query
    VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port9411,tcp,127.0.0.1,9411,,9411"
    # web
    VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port8080,tcp,127.0.0.1,8080,,8080"
    # cassandra
    VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port7000,tcp,127.0.0.1,7000,,7000"
    VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port7001,tcp,127.0.0.1,7001,,7001"
    VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port9042,tcp,127.0.0.1,9042,,9042"
    VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port9160,tcp,127.0.0.1,9160,,9160"
    # start VM
    boot2docker start

If you want to trace code that runs on the host you will need to
expose and forward the collector port as shown in deploy.sh.

More information on running Docker on OSX can be found here:
<http://docs.docker.io/installation/mac/>


## Authors

Zero Cho <itszero@gmail.com>

Markus Fix <lispmeister@gmail.com>
