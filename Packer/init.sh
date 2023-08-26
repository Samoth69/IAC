#!/bin/bash

# parefeu actif + autorisation ssh
ufw allow 22/tcp
ufw limit 22/tcp
ufw --force enable
