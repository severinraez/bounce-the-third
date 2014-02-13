#!/bin/bash

bundle exec heel --root build --daemonize
bundle exec guard

echo ready