function [fRoll,fPitch] = Roll_Pitch(x,y,z)

fRoll = (atan2(-y,z))*(180/pi);
fPitch = (atan2(x,sqrt(y.^2 + z.^2)))*(180/pi);

%
%Roll & Pitch Equations
 %roll  = (atan2(-fYg, fZg)*180.0)/3.14159265358979323846264338327950288;
 %pitch = (atan2(fXg, sqrt(fYg*fYg + fZg*fZg))*180.0)/3.14159265358979323846264338327950288;
%clear;