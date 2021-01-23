function library_DRV2605L(drv)
% Select LRA Library
topState_1A=de2bi(readRegister(drv,'1A'),8);
if topState_1A(8)==1
    config_03=bi2de(uint8([0 1 1 0 0 0 0 0]));
    writeRegister(drv,'03',config_03);
    fprintf('LRA Waveform Library is Selected\n');
elseif topState_1A(8)==0
    fprintf('ERM Mode: Nothing Happens\n');
else
    fprintf('Actuator Mode Error\n');
end

% Check MODE
topState_01=de2bi(readRegister(drv,'01'),8);
if topState_01(7)==0
    fprintf('- Device Ready -\n');
elseif topState_01(7)==1
    fprintf('- Device in Stand-by -\n');
else 
    printf('- Cannot Read Device Status -\n');
end
end

