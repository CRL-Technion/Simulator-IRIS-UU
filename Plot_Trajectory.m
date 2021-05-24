close all
CreateVideoFromMatlab = 1;%%notRecommended
nameOfVideoFile = 'myVideo';

init_plot;
define_quad_model;

patch('vertices', Environment.obj.v, 'faces', Environment.obj.f.v, ...
    'FaceVertexCData', rand(length(Environment.obj.v),1));
shading interp
alpha(.1)
% axis square;
axis equal;

plot_quad_model;
h1 = animatedline('Color','b','LineWidth',2);
h2 = animatedline('Color','r','LineWidth',2);
h3 = animatedline('Color','k','LineWidth',2);
% h4 = animatedline('Marker','o','Color','b','LineStyle','none');


% addpoints(h4,Environment.TargetsBridge(:,1),Environment.TargetsBridge(:,2),Environment.TargetsBridge(:,3));
addpoints(h1,RecordState.X(1,:),RecordState.X(2,:),RecordState.X(3,:))
addpoints(h2,RecordNavState.X(1,:),RecordNavState.X(2,:),RecordNavState.X(3,:))
addpoints(h3,Command.Pose_des_GF(:,1),Command.Pose_des_GF(:,2),Command.Pose_des_GF(:,3))
% legend([h1,h2,h3],'True','Nav','Desire','location','best')
% view([ -69.1836,  11.7112]);
view([  -55.3504,     15.9789]);

% view(3);
% v = [-5 -2 5];
% [caz,cel] = view(v)
xlim([[RecordState.X(1,1)]-50,[RecordState.X(1,1)]+50])
indexInspectedPOI = 0;
h6 = plot3(-100000,RecordState.X(2,i),RecordState.X(3,i),'k*','LineWidth',15)
xlim([[RecordState.X(1,1)]-50,[RecordState.X(1,1)]+50])

NumberOfCollision = 0;

% if (isField(F))
clear F
% end
indexF = 0;
for i=1:1:length(time)
    %     Plot the Quadrotor's Position
    if(mod(i,5)==0)
        plot_quad
        xlim([[RecordState.X(1,i)]-50,[RecordState.X(1,i)]+50])
        
        if (abs(Command.PoseSimulation(indexInspectedPOI+1,7)-i)<6)
            
            indexInspectedPOI = indexInspectedPOI+1;
            if (indexInspectedPOI<=length(collisionCheck))
                if (~collisionCheck(indexInspectedPOI))
                    NumberOfCollision = NumberOfCollision+1;
                    plot3(RecordState.X(1,i),RecordState.X(2,i),RecordState.X(3,i),'k*','LineWidth',15)
                end
            end
            currentIndexesPOI = POIInspectedCell{indexInspectedPOI}+1;
            %             currentIndexesPOICommand = Command.POICellCommand{indexInspectedPOI}+1;
            %             plot3(Environment.TargetsBridge(currentIndexesPOICommand,1),Environment.TargetsBridge(currentIndexesPOICommand,2),Environment.TargetsBridge(currentIndexesPOICommand,3),'r*','LineWidth',3);
            if (indexInspectedPOI<2)
                totalPOI = currentIndexesPOI;
                currentIndexesPOICommand = Command.POIINDEX+1;
                currentPlanedPOI= (intersect(unique(currentIndexesPOI),unique(currentIndexesPOICommand)));
                totalPlanedPOI = currentPlanedPOI;
                h5 = plot3(Environment.TargetsBridge(currentIndexesPOICommand,1),Environment.TargetsBridge(currentIndexesPOICommand,2),Environment.TargetsBridge(currentIndexesPOICommand,3),'r*','LineWidth',3);
                
                h4 = plot3(Environment.TargetsBridge(currentIndexesPOI,1),Environment.TargetsBridge(currentIndexesPOI,2),Environment.TargetsBridge(currentIndexesPOI,3),'b*','LineWidth',3);
                h7 = plot3(Environment.TargetsBridge(currentPlanedPOI,1),Environment.TargetsBridge(currentPlanedPOI,2),Environment.TargetsBridge(currentPlanedPOI,3),'g*','LineWidth',3);

            else
                totalPOI = [totalPOI,currentIndexesPOI];
                currentPlanedPOI= (intersect(unique(currentIndexesPOI),unique(currentIndexesPOICommand)));
                totalPlanedPOI = [totalPlanedPOI,currentPlanedPOI];
                plot3(Environment.TargetsBridge(currentIndexesPOI,1),Environment.TargetsBridge(currentIndexesPOI,2),Environment.TargetsBridge(currentIndexesPOI,3),'b*','LineWidth',3);
                plot3(Environment.TargetsBridge(currentPlanedPOI,1),Environment.TargetsBridge(currentPlanedPOI,2),Environment.TargetsBridge(currentPlanedPOI,3),'g*','LineWidth',3);
                
            end
            
            %             legend([h1,h2,h3,h4,h5,h6],'True','Navigation','Desire',['Inspected POIs simulation = ',num2str(0),'    '],['Inspected POIs desired = ',num2str(length(unique(Command.POIINDEX))),'    '],['Number of collisions = ',num2str(NumberOfCollision),'    '],'location','northoutside','Fontsize',20)
            dummyh = line(nan, nan, 'Linestyle', 'none', 'Marker', 'none', 'Color', 'none');
            
            legend([h1,h2,h3,h4,h7,dummyh,h5,h6],'True','Navigation','Desire',['Additional Inspected POIs simulation = ',num2str(length(unique(setdiff(totalPOI,currentIndexesPOICommand)))),'    ']...
                ,['Planned Inspected POIs simulation = ',num2str(length(unique(totalPlanedPOI))),'    ']...
                ,['Total Inspected POIs simulation = ',num2str(length(unique(totalPOI)))]...
                ,['Inspected POIs desired = ',num2str(length(unique(Command.POIINDEX))),'    ']...
                ,['Number of collisions = ',num2str(NumberOfCollision),'    '],'location','bestoutside','Fontsize',20)
        end
        
        %         campos([Quad.X_plot(i)+2,Quad.Y_plot(i)+2,Quad.Z_plot(i)+2])
        %         camtarget([Quad.X_plot(i),Quad.Y_plot(i),Quad.Z_plot(i)])
        %         camroll(0);
        %         addpoints(h1,Quad.X_plot(i),Quad.Y_plot(i),-Quad.Z_plot(i))
        %         addpoints(h2,Quad.X_plot(i),Quad.Y_plot(i),-Quad.Z_plot(i))
        % if i>1
        % v = [RecordState.X(1,i),RecordState.X(2,i),RecordState.X(3,i)]-[RecordState.X(1,i-1),RecordState.X(2,i-1),RecordState.X(3,i-1)];
        %         [caz,cel] = view(v);
        % end
        %         LimitView = 30;
        %
        %         if (caz <-LimitView)
        %             caz = -LimitView;
        %         end
        %         if ( caz >LimitView)
        %             caz = LimitView;
        %         end
        %           if (cel <-LimitView)
        %             cel = -LimitView;
        %         end
        %         if ( cel >LimitView)
        %             cel = LimitView;
        %         end
        %
        %
        %         view([caz,cel]);
        if (CreateVideoFromMatlab && (mod(i,50)==0))
            indexF = indexF+1;
            F(indexF) = getframe(gcf) ;
            %          cdata = print('-RGBImage','-r120');
            %         F(indexF) = im2frame(cdata);
        end
        drawnow limitrate
        %         legend('off')
        % drawnow
    end
end
if (CreateVideoFromMatlab)
    % create the video writer with 1 fps
    writerObj = VideoWriter([nameOfVideoFile,'.avi']);
    writerObj.FrameRate = 10;
    % set the seconds per image
    % open the video writer
    open(writerObj);
    % write the frames to the video
    for i=1:length(F)
        % convert the image to a frame
        frame = F(i) ;
        writeVideo(writerObj, frame);
    end
    % close the writer object
    close(writerObj);
end