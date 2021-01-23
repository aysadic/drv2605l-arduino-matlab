function install_DRV2605L(drv)

topState=de2bi(readRegister(drv,'00'),8);
% Check Device Model
if bi2de(topState(6:8))==7 
    fprintf('Device ID: DRV2605L\n');
elseif bi2de(topState(6:8))==6
    fprintf('Device ID: DRV2604L\n');
elseif bi2de(topState(6:8))==4
    fprintf('Device ID: DRV2604\n');
elseif bi2de(topState(6:8))==3
    fprintf('Device ID: DRV2605\n');
end
% Check Electronics
if topState(1)==0 
    fprintf('Electronic Status: OK\n');
else
    fprintf('Electronic Status: OVERCURRENT!\n');
end
% Check Temperature
if topState(2)==0 
    fprintf('Temperature Level: OK\n');
else
    fprintf('Temperature Level: OVERHEATED!\n');
end

end

