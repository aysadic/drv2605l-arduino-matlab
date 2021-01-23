function effect_DRV2605L(drv)
% Select Waveform (Strong Click '01')
effectNo=75;
effect=de2bi(effectNo,7);
config_04=bi2de(horzcat(effect,0));
writeRegister(drv,'04',config_04);
fprintf('- Strong Click Effect Selected -\n');
end

