function y = firpasobanda (fs, fc, L, x)

    n = 0 : (L - 1);
    h = (2/L) * cos ((2 * pi * fc .* n) / fs);
    y = conv (x, h);

end