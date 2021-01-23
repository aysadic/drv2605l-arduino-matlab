%% TCA9548 TCA Select (Port Selection)
function tcaSelect(portNo,multiplexer)

if portNo>7 || portNo<0
    fprintf('Invalid Port Number');
    return
end
portData=bitshift(1,portNo);
write(multiplexer,portData,'uint8');
end