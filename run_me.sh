#!/usr/bin/env bash

rails new . -s -m ./template.rb && mv README.TEMPLATE.md README.md && rails server