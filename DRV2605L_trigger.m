function trigger_DRV2605L(drv)
% Select Trigger Mode (Register: 0x01)
config_01=bi2de(uint8([0 0 0 0 0 0 0 0]));
writeRegister(drv,'01',config_01);
fprintf('Internal Trigger Selected\n');
end

