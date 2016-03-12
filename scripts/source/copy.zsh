#! /usr/bin/env bash

function copy() {
  cat $1 | nc -q1 localhost 65432 
}
