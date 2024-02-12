#!/bin/bash

# Start the GRPC server for the user code
dagster api grpc -h 0.0.0.0 -p 4000 -f repositories.py

# # Keep the container running
tail -f /dev/null
