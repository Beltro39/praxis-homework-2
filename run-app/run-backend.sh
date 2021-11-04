#!/usr/bin/env bash
echo "Hello from backend!"
cd ../../shared
cat > .env <<- "EOF"
PORT= 4001
EOF
nohup ./vuego-demoapp &
