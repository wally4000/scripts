#!/bin/bash

lpadmin -p $4 -L "$5" -E -v ipp://$6/ipp/print -m everywhere