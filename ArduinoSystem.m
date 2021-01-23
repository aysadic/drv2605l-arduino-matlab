%% Arduino Haptic Ring Driver
clear all
close all
clc

%% Global Variables
global effect
effect=0;

%% Initialization
fprintf('- Connecting to Device -\n');

% Connect to Arduino
dev=arduino();
fprintf('Connected to Controller\n\n');

% Setup I2C Protocol
configurePin(dev,'A4','I2C');
configurePin(dev,'A5','I2C');

% Scan I2C Devices
fprintf('- Checking Sub-systems -\n');
i2c_list=scanI2CBus(dev,0);
devStatus=[0,0];

% Check IMU Status
if any(strcmpi(i2c_list,'0x28')) 
    fprintf('0x28 - IMU BNO055 is found\n');
    imu=i2cdev(dev,'0x28');
    devStatus(1)=1;
else
    fprintf('IMU not found!\n');
    devStatus(1)=0;
end

% Check I2C Multiplexer
if any(strcmpi(i2c_list,'0x70'))
    fprintf('0x70 - I2C Multiplexer TCA9548A is found\n');
    multip=i2cdev(dev,'0x70');
    devStatus(2)=1;
    % Check Haptic Drivers
    drv_list=[0,0,0,0,0,0,0,0];
    for portNo=0:1:7
        tcaSelect(portNo,multip);
        multip_list=scanI2CBus(dev,0);
        if any(strcmpi(multip_list,'0x5A'))
            fprintf(strcat('0x5A - TCA #',num2str(portNo),' Haptic Driver is found\n'));
            drv_list(portNo+1)=1;
        end
    end
    if any(strcmpi(multip_list,'0X5A'))
        drv=i2cdev(dev,'0x5A');
    end
    clear portNo multip_list
else
    fprintf('I2C Multiplexer not found\nYou may not drive multiple Haptic Actuators\n');
    devStatus(2)=0;
end

% Check Overall Device Status
if all(devStatus)
    fprintf('\n- All Systems Go -\n');
else
    fprintf('\n- Check Your Connections -\n');
end

%% DRV2605L Haptic Driver Initializations

for i=4:1:7
    tcaSelect(i,multip);
    fprintf(strcat('\n-DRV2605L #',num2str(i-3),'-\n'));
    DRV2605L_install(drv);
    DRV2605L_calibrate(drv);
    DRV2605L_library(drv);    
    DRV2605L_trigger(drv);
    DRV2605L_effect(drv);
    DRV2605L_go(drv);
    pause(3);
end











    
