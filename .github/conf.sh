#!/bin/bash

mkdir -p $HOME/.config/sccache
sudo mkdir -p /etc/conf.d/sccache

echo '[cache.disk]
dir = "'"$HOME/.cache/sccache"'"
[dist]
# where to find the scheduler
scheduler_url = "http://127.0.0.1:10500"
# a set of prepackaged toolchains
toolchains = []
# the maximum size of the toolchain cache in bytes
toolchain_cache_size = 5368709120
cache_dir = "'"$HOME/.cache/sccache-dist-client"'"

[dist.auth]
type = "token"
token = "preshared token"
' >  $HOME/.config/sccache/config

echo 'public_addr = "0.0.0.0:10500"
[client_auth]
type = "token"
token = "preshared token"

[server_auth]
type = "token"
token = "preshared token"
' >  $HOME/.config/sccache/scheduler-config.toml


echo '
cache_dir = "/tmp/toolchains"
public_addr = "127.0.0.1:10501"
scheduler_url = "http://127.0.0.1:10500"

[builder]
type = "overlay"
build_dir = "/tmp/build"
bwrap_path = "/usr/bin/bwrap"

[scheduler_auth]
type = "token"
token = "preshared token"
' >  $HOME/.config/sccache/buildserver-config.toml

echo '
cache_dir = "/tmp/toolchains"
public_addr = "127.0.0.1:10501"
scheduler_url = "http://127.0.0.1:10500"

[builder]
type = "docker"

[scheduler_auth]
type = "token"
token = "preshared token"
' >  $HOME/.config/sccache/buildserver-docker-config.toml

echo '
RUST_BACKTRACE=full
# SCCACHE_SYSLOG=debug
SCCACHE_LOG=info,sccache_dist=debug,sccache=debug,sccache_heartbeat=info,sccache_http=info
' >  $HOME/.config/sccache/sccache.conf

sudo cp $HOME/.config/sccache/* /etc/conf.d/sccache
