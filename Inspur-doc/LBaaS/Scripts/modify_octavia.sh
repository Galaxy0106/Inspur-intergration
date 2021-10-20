#!/bin/bash
cp /etc/kolla/octavia-worker/octavia.conf /etc/kolla/octavia-api
cp /etc/kolla/octavia-worker/octavia.conf /etc/kolla/octavia-health-manager
cp /etc/kolla/octavia-worker/octavia.conf /etc/kolla/octavia-housekeeping
docker restart octavia-worker
docker restart octavia-api
docker restart octavia-octavia-health-manager
docker restart octavia-housekeeping