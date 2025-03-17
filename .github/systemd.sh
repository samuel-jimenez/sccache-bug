#!/bin/bash

ls -la
sudo mv ./.github/system/* /etc/systemd/system
ls -la /etc/systemd/system
sudo systemctl daemon-reload
