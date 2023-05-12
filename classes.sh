#!/bin/zsh

jar -tf "$1".jar | grep ".class"