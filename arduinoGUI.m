function arduinoGUI()
    fclose all;
    close all;
    global effect angle borderThickness n r rc xc yc xs ys xb yb 
    %% Obtaining Monitor Dimensions
    set(0,'units','centimeters') 
    monitor_res=get(0,'screensize');
    monitor_res=[0 0 monitor_res(3:4)];
    mon2ir=[1 1];
        
    %% Experimental Constants
    r=5; % 10 cm Diameter Shape
    rc=r+2.5;
    n=3;
    angle=0;
    borderThickness=3;
    [xc,yc]=drawCircle(0,0,rc);
    [xs,ys]=myline(2*r,borderThickness);
    [xb,yb]=myline(2*r,borderThickness);
        
    %% GUI Design
    guiFig=figure('Units','normalized','OuterPosition',[0 0 1 1],'WindowStyle','normal'...
        ,'Resize','off','Menubar','none','Pointer','circle','WindowButtonMotionFcn',@ringMove);               
        % GUI Buttons
        buttongroup = uibuttongroup('Visible','on','Units','normalized','Position',[0,0.8,1,0.2],...
            'Title','How do you define the shape you are feeling?','TitlePosition','lefttop');
            %% Button Group Buttons
            fxButton1 = uicontrol(buttongroup,'Style','pushbutton','String','Effect #1','BackgroundColor',[0.948 0.948 0.948],'Units','normalized','Position',[0.000,0.075,0.1,0.9],'Callback',@fx1_callback);
            fxButton2 = uicontrol(buttongroup,'Style','pushbutton','String','Effect #2','BackgroundColor',[0.948 0.948 0.948],'Units','normalized','Position',[0.125,0.075,0.1,0.9],'Callback',@fx2_callback);
            fxButton3 = uicontrol(buttongroup,'Style','pushbutton','String','Effect #3','BackgroundColor',[0.948 0.948 0.948],'Units','normalized','Position',[0.250,0.075,0.1,0.9],'Callback',@fx3_callback);
            fxButton4 = uicontrol(buttongroup,'Style','pushbutton','String','Effect #4','BackgroundColor',[0.948 0.948 0.948],'Units','normalized','Position',[0.375,0.075,0.1,0.9],'Callback',@fx4_callback);
            fxButton5 = uicontrol(buttongroup,'Style','pushbutton','String','Effect #5','BackgroundColor',[0.948 0.948 0.948],'Units','normalized','Position',[0.500,0.075,0.1,0.9],'Callback',@fx5_callback);
            staticText= uicontrol(buttongroup,'Style','text','String','Haptic Ring Started','Units','normalized','Position',[0.750,0.075,0.4,0.5],'FontSize',20,'FontWeight','bold','HorizontalAlignment','left');
            
            %% Haptic Shape
            shapeBox=uibuttongroup('BorderType','none','Units','centimeters','Position',[monitor_res(3)/2-rc*mon2ir(1),monitor_res(4)*0.8/2-rc*mon2ir(2),2*rc*mon2ir(1),2*rc*mon2ir(2)]);
            shape = axes('Parent',shapeBox,'NextPlot','replace','Units','normalized','Position',[0 0 1 1]);
            hold on
            plot(xc,yc,'r');
            axis equal
            % Polygon
            plot(xs,ys,'k');
%             plot(xb,yb,'k');
            % Figure Adjustments
            axis off           
            effect=0;
    
    function fx1_callback(hObject, eventdata, handles)
        effect=1;
        staticText= uicontrol(buttongroup,'Style','text','String','LRA Effect #1'...
            ,'Units','normalized','Position',[0.750,0.075,0.4,0.5],'FontSize',20,'FontWeight','bold','HorizontalAlignment','left');
    end
    function fx2_callback(hObject, eventdata, handles)
        effect=2;
        staticText= uicontrol(buttongroup,'Style','text','String','LRA Effect #2'...
            ,'Units','normalized','Position',[0.750,0.075,0.4,0.5],'FontSize',20,'FontWeight','bold','HorizontalAlignment','left');        
    end
    function fx3_callback(hObject, eventdata, handles)
        effect=3;
        staticText= uicontrol(buttongroup,'Style','text','String','LRA Effect #3'...
            ,'Units','normalized','Position',[0.750,0.075,0.4,0.5],'FontSize',20,'FontWeight','bold','HorizontalAlignment','left');
    end
    function fx4_callback(hObject, eventdata, handles)
        effect=4;
        staticText= uicontrol(buttongroup,'Style','text','String','LRA Effect #4'...
            ,'Units','normalized','Position',[0.750,0.075,0.4,0.5],'FontSize',20,'FontWeight','bold','HorizontalAlignment','left');
    end
    function fx5_callback(hObject, eventdata, handles)
        effect=5;
        staticText= uicontrol(buttongroup,'Style','text','String','LRA Effect #5'...
            ,'Units','normalized','Position',[0.750,0.075,0.4,0.5],'FontSize',20,'FontWeight','bold','HorizontalAlignment','left');
    end
    
    function [xcircle,ycircle]=drawCircle(x,y,r)
        angle=0:0.001*pi:2*pi;
        xcircle=r*cos(angle)+x;
        ycircle=r*sin(angle)+y;
    end

    function [xv,yv]=mypolygon(r,sides,angle)
        % Definitions
        angle=angle*pi/180;
        angle=angle-(pi-2*pi/sides)/2;
        L=angle:2*pi/sides:2*pi+angle;

        % Polygon Vertices
        xv = r*cos(L)';
        yv = r*sin(L)';

        % Connecting Last Vertice to First Vertice
        xv = [xv ; xv(1)];
        yv = [yv ; yv(1)];
    end
    
    function [xv,yv]=myline(length,thickness)
        xv=[-thickness/2; thickness/2; thickness/2; -thickness/2];
        yv=[-length/2; -length/2; length/2; length/2];
        xv = [xv; xv(1)];
        yv = [yv; yv(1)];
    end
    
    function refreshGUI
    %% Haptic Shape
        cla(shape);
        statement=strcat('Question ',num2str(questionNo),'/',num2str(numel(questions_types))); 
        staticText= uicontrol(buttongroup,'Style','text','String',statement,'Units','normalized','Position',[0.750,0.075,0.4,0.5],'FontSize',20,'FontWeight','bold','HorizontalAlignment','left');
        plot(shape,xc,yc,'r');
        axis equal
        % Polygon
%       plot(xs,ys,'k');
%       plot(xb,yb,'k');
        % Figure Adjustments
        axis off           

        buttongroup.Visible = 'on';
        response=0;
    end
end