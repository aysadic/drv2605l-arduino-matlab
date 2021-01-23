function go_DRV2605L(drv)
% Test Fire
go_bit=bi2de(uint8([1 0 0 0 0 0 0 0]));
writeRegister(drv,'0C',go_bit);
fprintf('Fire!\n');
end

