function rgbColor = hex2rgb(hexColor)

    if hexColor(1) == '#'
        hexColor = hexColor(2:end);
    end
    
   
    if length(hexColor) ~= 6
        error('Hex color value must be 6 characters.');
    end
    
  
    R = hex2dec(hexColor(1:2)) / 255;
    G = hex2dec(hexColor(3:4)) / 255;
    B = hex2dec(hexColor(5:6)) / 255;
    
   
    rgbColor = [R, G, B];
end
