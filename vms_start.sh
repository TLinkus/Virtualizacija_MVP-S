#!/bin/bash

sudo apt update -y
sudo apt install -y ansible
ansible --version

ansible -m ping all

cd ~/.ansible

ansible-galaxy collection install community.general --force


cat > ymlkurimas.yml << "BMW"
- name: opennebula
  become: yes
  hosts: localhost
  collections:
    - community.general
  tasks:
    - name: python packages
      apt:
        name:
          - python3
          - python3-pip
          - python3-venv
          - build-essential
        state: present

    - name: instaliuoju pyone ir oca
      pip:
        name:
          - pyone
          - oca
        state: present
        extra_args: --break-system-packages


    - name: webserver vm
      community.general.one_vm:
        api_url: "https://grid5.mif.vu.lt/cloud3/RPC2"
        api_username: "openenbulauser2"
        api_password: "opennebulapass2"
        template_name: "ubuntu-24.04"
        attributes:
          name: "webserver vm"
        state: present

    - name: db vm
      community.general.one_vm:
        api_url: "https://grid5.mif.vu.lt/cloud3/RPC2"
        api_username: "openenbulauser3"
        api_password: "openenbulauser3"
        template_name: "ubuntu-24.04"
        attributes:
          name: "db vm"
        state: present

    - name: client vm
      community.general.one_vm:
        api_url: "https://grid5.mif.vu.lt/cloud3/RPC2"
        api_username: "openenbulauser4"
        api_password: "openenbulauser4"
        template_name: "ubuntu-24.04"
        attributes:
          name: "client vm"
        state: present
BMW

ansible-playbook ymlkurimas.yml

echo "Visi vm'ai sukurti"
