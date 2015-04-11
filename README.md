# Mimas-V1-PWM-Demo

[![Build Status](https://jenkins.cyrozap.com/job/Mimas-V1-PWM-Demo/badge/icon)](https://jenkins.cyrozap.com/job/Mimas-V1-PWM-Demo/)
[![License](http://img.shields.io/badge/license-Apache%202.0-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0.html)

Note: The code in its current state does not actually work.

## Prerequisites

- Xilinx ISE (tested with version 14.7)
- `git`
- `make` (Linux only)

## Building

### Linux

    git clone https://github.com/cyrozap/Mimas-V1-PWM-Demo.git
    cd Mimas-V1-PWM-Demo
    source /opt/Xilinx/14.7/ISE_DS/settings64.sh
    make bin

### Windows

1.  Clone the repository with your favorite git client
    - `git clone https://github.com/cyrozap/Mimas-V1-PWM-Demo.git`
2.  Open the Xilinx ISE Project Navigator
3.  Create a new project (File -> New Project...)
    - You can enter anything you want for the name, but the Location
    and Working Directory must be the same as the folder you just
    cloned the repository into
    - The "Top-level source type" is "HDL"
    - Family: Spartan6
    - Device: XC6SLX9
	- Package: TQG144
    - Speed: -3
    - Preferred Language: Verilog
4.  Add source files (Project -> Add Source...)
    - Select `pwm_demo.v` and `mimas.ucf`
    - Click "OK"
5.  Open the properties for the "Generate Programming File" process
    - Under "General Options", enable "Create Binary Configuration File"
6.  Run the "Generate Programming File" process
