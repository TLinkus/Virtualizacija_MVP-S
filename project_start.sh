#!/bin/bash

chmod a+x  ansible_vm.sh vms_start.sh

source ./ansible_vm.sh

$CSSH_CON  'bash -s' < vms_start.sh
