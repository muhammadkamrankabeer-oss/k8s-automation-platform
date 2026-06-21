#!/bin/bash

echo "================================="
echo "Updating system packages"
echo "================================="

apt-get update -y

echo "================================="
echo "Installing basic packages"
echo "================================="

apt-get install -y \
  curl \
  vim \
  git \
  net-tools \
  python3

echo "================================="
echo "Bootstrap completed"
echo "================================="
