folderResult = 'C:\Users\david\OneDrive\DocumentsProjects\Thesis\results_ref';
dataOutputwithHeaderRef = readtable([folderResult,'\OutputUAVsimulationMain.txt']);
dataOutputRef = dataOutputwithHeaderRef(1:2:end,:) ;

folderResult = 'C:\Users\david\OneDrive\DocumentsProjects\Thesis\result_test_0';
dataOutputwithHeader_0 = readtable([folderResult,'\OutputUAVsimulationMain.txt']);
dataOutputTest_0= dataOutputwithHeader_0(1:2:end,:) ;

folderResult = 'C:\Users\david\OneDrive\DocumentsProjects\Thesis\result_test_5';
dataOutputwithHeader_5 = readtable([folderResult,'\OutputUAVsimulationMain.txt']);
dataOutputTest_5= dataOutputwithHeader_5(1:2:end,:) ;

folderResult = 'C:\Users\david\OneDrive\DocumentsProjects\Thesis\result_test_10';
dataOutputwithHeader_10 = readtable([folderResult,'\OutputUAVsimulationMain.txt']);
dataOutputTest_10= dataOutputwithHeader_10(1:2:end,:) ;

folderResult = 'C:\Users\david\OneDrive\DocumentsProjects\Thesis\result_test_15';
dataOutputwithHeader_15 = readtable([folderResult,'\OutputUAVsimulationMain.txt']);
dataOutputTest_15= dataOutputwithHeader_15(1:2:end,:) ;

folderResult = 'C:\Users\david\OneDrive\DocumentsProjects\Thesis\result_test_20';
dataOutputwithHeader_20 = readtable([folderResult,'\OutputUAVsimulationMain.txt']);
dataOutputTest_20= dataOutputwithHeader_20(1:2:end,:) ;
labelesBoxPlot = {'Ref','Test 0','Test 5','Test 10','Test 15'};
labeles = {'Ref','Ref fit','Test 0','Test 0 fit','Test 5','Test 5 fit','Test 10','Test 10 fit','Test 15','Test 15 fit'};

close all
figure(1)
hold on; box on; grid on;
title('Length GNSS Outages region Vs. PercentageOfPOI')
% xlabel(' Length GNSS Outages region[%]')
% ylabel('PercentageOfPOI[%]')
methodFit = 'poly1';
h1 = plot(dataOutputRef.percentageLocationError,dataOutputRef.percentageOfPOI,'*');
f= fit(dataOutputRef.percentageLocationError,dataOutputRef.percentageOfPOI,methodFit);
hfit1 = plot(f);hfit1.Color = h1.Color;hfit1.LineWidth = 2;
h2 =plot(dataOutputTest_0.percentageLocationError,dataOutputTest_0.percentageOfPOI,'*');
f= fit(dataOutputTest_0.percentageLocationError,dataOutputTest_0.percentageOfPOI,methodFit);
hfit2 = plot(f);hfit2.Color = h2.Color;hfit2.LineWidth = 2;
h3 =plot(dataOutputTest_5.percentageLocationError,dataOutputTest_5.percentageOfPOI,'*');
f= fit(dataOutputTest_5.percentageLocationError,dataOutputTest_5.percentageOfPOI,methodFit);
hfit3 = plot(f);hfit3.Color = h3.Color;hfit3.LineWidth = 2;
h4 =plot(dataOutputTest_10.percentageLocationError,dataOutputTest_10.percentageOfPOI,'*');
f= fit(dataOutputTest_10.percentageLocationError,dataOutputTest_10.percentageOfPOI,methodFit);
hfit4 = plot(f);hfit4.Color = h4.Color;hfit4.LineWidth = 2;
h5 =plot(dataOutputTest_15.percentageLocationError,dataOutputTest_15.percentageOfPOI,'*');
f= fit(dataOutputTest_15.percentageLocationError,dataOutputTest_15.percentageOfPOI,methodFit);
hfit5 = plot(f);hfit5.Color = h5.Color;hfit5.LineWidth = 2;
% plot(dataOutputTest_20.percentageLocationError,dataOutputTest_20.percentageOfPOI,'*')
xlabel(' Length GNSS Outages region[%]')
ylabel('POI Inspected[%]')
legend([h1,hfit1,h2,hfit2,h3,hfit3,h4,hfit4,h5,hfit5],labeles,'location','best')

figure(2)
hold on; box on; grid on;
title(' Length GNSS Outages region Vs. Number of collision')
% xlabel(' Length GNSS Outages region[%]')
% ylabel('Number of collision')
h1 = plot(dataOutputRef.percentageLocationError,dataOutputRef.Number_of_collision,'*');
f= fit(dataOutputRef.percentageLocationError,dataOutputRef.Number_of_collision,methodFit);
hfit1 = plot(f);hfit1.Color = h1.Color;hfit1.LineWidth = 2;
h2 = plot(dataOutputTest_0.percentageLocationError,dataOutputTest_0.Number_of_collision,'*');
f= fit(dataOutputTest_0.percentageLocationError,dataOutputTest_0.Number_of_collision,methodFit);
hfit2 = plot(f);hfit2.Color = h2.Color;hfit2.LineWidth = 2;
h3 = plot(dataOutputTest_5.percentageLocationError,dataOutputTest_5.Number_of_collision,'*');
f= fit(dataOutputTest_5.percentageLocationError,dataOutputTest_5.Number_of_collision,methodFit);
hfit3 = plot(f);hfit3.Color = h3.Color;hfit3.LineWidth = 2;
h4 = plot(dataOutputTest_10.percentageLocationError,dataOutputTest_10.Number_of_collision,'*');
f= fit(dataOutputTest_10.percentageLocationError,dataOutputTest_10.Number_of_collision,methodFit);
hfit4 = plot(f);hfit4.Color = h4.Color;hfit4.LineWidth = 2;
h5 = plot(dataOutputTest_15.percentageLocationError,dataOutputTest_15.Number_of_collision,'*');
f= fit(dataOutputTest_15.percentageLocationError,dataOutputTest_15.Number_of_collision,methodFit);
hfit5 = plot(f);hfit5.Color = h5.Color;hfit5.LineWidth = 2;
% plot(dataOutputTest_20.percentageLocationError,dataOutputTest_20.Number_of_collision,'*')
xlabel('Length GNSS Outages region[%]')
ylabel('Number of collision')

legend([h1,hfit1,h2,hfit2,h3,hfit3,h4,hfit4,h5,hfit5],labeles,'location','best')


figure(3)
hold on; box on; grid on;
title(' Length GNSS Outages region')
% boxplot([dataOutputRef.percentageLocationError,dataOutputTest_0.percentageLocationError,dataOutputTest_5.percentageLocationError,dataOutputTest_10.percentageLocationError,dataOutputTest_15.percentageLocationError,dataOutputTest_20.percentageLocationError]...
%     ,'Labels',labeles)
boxplot([dataOutputRef.percentageLocationError,dataOutputTest_0.percentageLocationError,dataOutputTest_5.percentageLocationError,dataOutputTest_10.percentageLocationError,dataOutputTest_15.percentageLocationError]...
    ,'Labels',labelesBoxPlot)
xlabel('Scenario')
ylabel('Length GNSS Outages region[%]')

figure(4)
hold on; box on; grid on;
title('Number of collision')
% boxplot([dataOutputRef.percentageLocationError,dataOutputTest_0.percentageLocationError,dataOutputTest_5.percentageLocationError,dataOutputTest_10.percentageLocationError,dataOutputTest_15.percentageLocationError,dataOutputTest_20.percentageLocationError]...
%     ,'Labels',labeles)
boxplot([dataOutputRef.Number_of_collision,dataOutputTest_0.Number_of_collision,dataOutputTest_5.Number_of_collision,dataOutputTest_10.Number_of_collision,dataOutputTest_15.Number_of_collision]...
    ,'Labels',labelesBoxPlot)
xlabel('Scenario')
ylabel('Number of collision')

figure(5)
hold on; box on; grid on;
title('POI Inspected')
% boxplot([dataOutputRef.percentageLocationError,dataOutputTest_0.percentageLocationError,dataOutputTest_5.percentageLocationError,dataOutputTest_10.percentageLocationError,dataOutputTest_15.percentageLocationError,dataOutputTest_20.percentageLocationError]...
%     ,'Labels',labeles)
boxplot([dataOutputRef.percentageOfPOI,dataOutputTest_0.percentageOfPOI,dataOutputTest_5.percentageOfPOI,dataOutputTest_10.percentageOfPOI,dataOutputTest_15.percentageOfPOI]...
    ,'Labels',labelesBoxPlot)
xlabel('Scenario')
ylabel('POI Inspected[%]')
%%

