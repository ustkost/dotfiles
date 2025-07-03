#!/usr/bin/env bash

case "$1" in
    --toggle)
        if systemctl is-active --quiet sing-box; then
            sudo systemctl stop sing-box
        else
            sudo systemctl start sing-box
        fi
        ;;
    *)
        if systemctl is-active --quiet sing-box; then
            echo "VPN: ON"
        else
            echo "VPN: OFF"
        fi
        ;;
esac
