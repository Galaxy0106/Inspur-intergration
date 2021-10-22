#!/bin/bash
cp /etc/kolla/octavia-worker/octavia.conf /etc/kolla/octavia-api
cp /etc/kolla/octavia-worker/octavia.conf /etc/kolla/octavia-health-manager
cp /etc/kolla/octavia-worker/octavia.conf /etc/kolla/octavia-housekeeping
docker restart octavia_worker
docker restart octavia_api
docker restart octavia_health_manager
docker restart octavia_housekeeping
