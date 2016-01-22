#! /usr/bin/env bash

function sp() {
  sudo salt \*$1\* test.ping
}
