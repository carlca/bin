#!/bin/zsh

model=$1

while ! ollama run $model; do
  echo 'Oh dear!' 
  sleep 10
  ollama run $model
done
