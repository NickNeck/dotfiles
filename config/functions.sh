#!/usr/bin/env bash

gd() {
  cd `cat $HOME/.dir_clipboard`
}

sd() {
  pwd > $HOME/.dir_clipboard
}
