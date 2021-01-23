# DRV2605L Arduino Driver for MATLAB
I have written this MATLAB script for DRV2605L Haptic Motor Driver according to protocol documented in Texas Instruments DRV2605L datasheet.

I used Sparkfun DRV2605L Breakout Board [HERE](https://www.sparkfun.com/products/14538)

For more info you can check out [HERE](https://www.ti.com/lit/ds/symlink/drv2605l.pdf?ts=1611413384762&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FDRV2605L)

You can edit the parameters according to motor type, target frequency and immersion haptic library.

You should run ArduinoSystem.m as the main file. The script initial check for all connected devices. The script is designed to scan a I2C multiplexer (TCA9458A), an IMU (BNO055) and 8 DRV2605L ICs.

After the scan is done, the script initiates a test haptic feedback for all connected DRV2605Ls

In order to successfully control the DRV2605L IC you should initiate the scripts in the following order.

<h3>1) DRV2605L_install(drv); </h3>
This initiates the DRV2605L and checks for power and temperature protection flags
<h3>2) DRV2605L_calibrate(drv);</h3> 
Here you have to configure and auto-calibrate the DRV2605L according to your setup. You can find more information at DRV2605L datasheet.
<h3>3) DRV2605L_library(drv);</h3>
Immersion provides individual libraries for ERM and LRA actuators.
<h3>4) DRV2605L_trigger(drv);</h3>
There are different trigger methods for DRV2605L, here we use the internal software trigger for haptic effects.
<h3>5) DRV2605L_effect(drv);</h3>
The desired haptic effect from the Immersion library is selected
<h3>6) DRV2605L_go(drv);</h3>
At this stage, you can run the "go script" as much as you want as you have configured the DRV2605L. It fires up the selected haptic effect

<h3>Warning</h3>
The code is a work-in-progress. Use at your discretion.
