function calibrate_DRV2605L(drv)

% Calibration Mode Activated
fprintf('- Calibration Started -\n');
config_01=bi2de(uint8([1 1 1 0 0 0 0 0]));
writeRegister(drv,'01',config_01); % Mode -> Auto-Calibration (Needs following Inputs)

% Settings
% a) ERM_LRA (Register: 0x1A - Bit 7 - 0:ERM , 1:LRA)
% b) FB_BRAKE_FACTOR (Register: 0x1A - Bit 6:4 - btw. 0-7 (default:3)(recommended:2))
% (Difference Between startup and braking overdrive gains)
% c) LOOP_GAIN (Register: 0x1A - Bit 3:2 - btw. 0-3 (default:1)(recommended:2))
% (Back EMF Loop speed for matching input signal)
config_1A=bi2de(uint8([0 1 0 1 0 1 0 1]));
writeRegister(drv,'1A',config_1A);

% d) RATED_VOLTAGE (Register: 0x16 - Bit 7:0 - Formulation
% (default:3F))(our motors:47)
% (Average or RMS Voltage for ERM and LRA)
writeRegister(drv,'16',hex2dec('47'));

% e) OD_CLAMP (Register: 0x17 - Bit 7:0 - Formulation (default:89)(ours:7B)
% (Overdrive limits during auto-braking and startup)
writeRegister(drv,'17',hex2dec('7B'));

% f) AUTO_CAL_TIME (Register: 0x1E - Bit 5:4 - btw 0-3 (default:2)(recommended:3))
% (Length of auto-calibration time)
config_1E=bi2de(uint8([0 0 0 0 1 1 0 0]));
writeRegister(drv,'1E',config_1E);

% g) DRIVE_TIME (Register: 0x1B - Bit 4:0 - (default:19)(my:15))
% (Inital guess for drive time in LRA mode. 1/f_lra in the equation)
% (Sample rate for back-emf detection in ERM mode)
% (My LRA: 235 Hz -> (1000/235*0.5)=DRIVE_TIME*0.1+0.5 -> DRIVE_TIME=
config_1B=bi2de(uint8([1 1 1 1 0 0 0 1]));
writeRegister(drv,'1B',config_1B);

% h) SAMPLE_TIME (Register: 0x1C - Bit 5:4 - btw. 0-3 (recommended:3)
% (LRA auto-resonance sampling time)
% i) BLANKING_TIME (Register: 0x1C - Bit 3:2 - btw. 0-3 (recommended:1)
% (Blanking time before the back-EMF AD makes a conversion)
% j) IDISS_TIME (Register: 0x1C - Bit 1:0 - btw. 0-3 (recommended:1)
% (Current dissipation time)
config_1C=bi2de(uint8([1 0 1 0 1 1 1 1]));
writeRegister(drv,'1C',config_1C);

% Calibrate (GO Bit -> Register:0x0C - Bit:0 - 0:Nothing 1:GO) 
go_bit=bi2de(uint8([1 0 0 0 0 0 0 0]));
writeRegister(drv,'0C',go_bit);

% Check if calibration is successful
topState_00=de2bi(readRegister(drv,'00'),8);
if topState_00(4)==0
    fprintf('- Calibration Successful -\n');
elseif topState_00(4)==1
    fprintf('- Calibration Failed -\n');
else
    fprintf('- Cannot Read Device Status -\n');
end

end

