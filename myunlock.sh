#!/bin/bash

i2cset -y 1 0x51 0x7b 0x9B
sleep 0.05
i2cset -y 1 0x51 0x7c 0xB0
sleep 0.05
i2cset -y 1 0x51 0x7d 0x3D
sleep 0.05
i2cset -y 1 0x51 0x7e 0xFA
sleep 0.05

