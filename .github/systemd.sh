#!/bin/bash

echo '
[Unit]
Description=sccache-dist buildserver
Wants=network-online.target
After=network-online.target

[Service]
Environment="SCCACHE_SYSLOG=info"
Environment="SCCACHE_NO_DAEMON=1"
Environment="RUST_BACKTRACE=1"
EnvironmentFile=/etc/conf.d/sccache/sccache.conf
ExecStart=/usr/bin/sccache-dist server --config /etc/conf.d/sccache/buildserver-config.toml --syslog $SCCACHE_SYSLOG

[Install]
WantedBy=multi-user.target' | sudo tee /etc/systemd/system/sccache-buildserver-overlay.service

echo '
[Unit]
Description=sccache-dist buildserver
Wants=network-online.target
After=network-online.target

[Service]
Environment="SCCACHE_SYSLOG=info"
Environment="SCCACHE_NO_DAEMON=1"
Environment="RUST_BACKTRACE=1"
EnvironmentFile=/etc/conf.d/sccache/sccache.conf
ExecStart=/usr/bin/sccache-dist server --config /etc/conf.d/sccache/buildserver-docker-config.toml --syslog $SCCACHE_SYSLOG

[Install]
WantedBy=multi-user.target' | sudo tee /etc/systemd/system/sccache-buildserver-docker.service

echo '
[Unit]
Description=sccache-dist scheduler
Wants=network-online.target
After=network-online.target

[Service]
Environment="SCCACHE_SYSLOG=info"
Environment="SCCACHE_NO_DAEMON=1"
Environment="RUST_BACKTRACE=1"
EnvironmentFile=/etc/conf.d/sccache/sccache.conf
ExecStart=/usr/bin/sccache-dist scheduler --config /etc/conf.d/sccache/scheduler-config.toml --syslog $SCCACHE_SYSLOG

[Install]
WantedBy=multi-user.target' | sudo tee /etc/systemd/system/sccache-scheduler.service

sudo systemctl daemon-reload
