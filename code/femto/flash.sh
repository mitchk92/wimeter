#!/usr/bin/env sh

openocd -f interface/stlink-v2.cfg -f target/stm32f1x.cfg -c init -c targets -c "halt" -c "flash write_image erase ./zig-out/bin/femto" -c "flash verify_image ./zig-out/bin/femto" -c "reset run" -c shutdown
