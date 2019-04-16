function width = fwhm(x,y)
%Full-Width at Half-Maximum (FWHM) of the waveform y(x)
%   The FWHM result in 'width' will be in units of 'x'
%
%   Author: Yide Zhang
%   Email: yzhang34@nd.edu
%   Date: April 16, 2019
%   Copyright: University of Notre Dame, 2019

[M, I] = max(y);
half_level = M / 2;

if min(y) > half_level || y(1) > half_level
    width = max(x) - min(x);
    return
end

i_up = 1;
while sign(y(i_up)-half_level)==sign(y(i_up+1)-half_level) || y(i_up+1)<=y(i_up)
    i_up = i_up + 1;
end

if i_up >= round(length(y)/2) || i_up >= min(I) || i_up >= (length(x)-min(I))
    width = max(x) - min(x);
    return
end

width = max(x)-min(x)-2*(x(i_up)-min(x));