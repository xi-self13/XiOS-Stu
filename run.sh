#!/bin/bash

# Stop on any error
set -e

# --- BUILD KERNEL AND ISO ---
echo "Building kernel and creating ISO..."
bash build.sh

# --- CONFIGURATION ---
QEMU_VNC_PORT=5900
WEBSOCKET_PORT=6080
ISO_FILE=my-os.iso
# Find the path to the noVNC files dynamically and safely
NOVNC_ROOT=$(find /nix/store -maxdepth 1 -type d -name "*novnc*" | head -n1)/share/novnc/


# --- CLEANUP ---
echo "Stopping previous instances..."
# Use pkill for more robust process killing
pkill -f "qemu-system-x86_64" || true
pkill -f "websockify" || true


# --- LAUNCH QEMU ---
echo "Starting QEMU..."
# Boot from the ISO and run as a background daemon
qemu-system-x86_64 -cdrom "$ISO_FILE" -vnc :$QEMU_VNC_PORT -daemonize


# --- LAUNCH WEBSOCKET PROXY ---
echo "Starting websockify proxy..."
# & runs the command in the background
websockify --web="$NOVNC_ROOT" "$WEBSOCKET_PORT" localhost:"$QEMU_VNC_PORT" &


echo " "
echo "✅ QEMU and noVNC are running!"
echo "   - The 'QEMU OS Preview' is available in the Previews tab."
