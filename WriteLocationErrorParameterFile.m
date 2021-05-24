function WriteLocationErrorParameterFile(fileName,parameters)
 
fileID = fopen(fileName,'w');
b_a_milli_g = parameters(1);
b_g_degPerHr = parameters(2);
avarageVelocity = parameters(3);
minTimeAllowInRistZone = parameters(4);
maxnTimeAllowInRistZone = parameters(5);
MultipleFactor = parameters(6);



fprintf(fileID,'%6.2f %6.2f %6.2f %6.2f %6.2f %6.2f\n',b_a_milli_g,b_g_degPerHr,avarageVelocity,minTimeAllowInRistZone,maxnTimeAllowInRistZone,MultipleFactor);
fclose(fileID);

end