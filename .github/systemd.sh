#!/bin/bash

ls -la ./.github/system/*
sudo cp ./.github/system/* /etc/systemd/system
ls -la /etc/systemd/system
sudo systemctl daemon-reload
