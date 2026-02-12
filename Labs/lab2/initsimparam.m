
switch lower(labprocess)
    case 'elmotor'
        %% Elmotor init
        % Define the system
        % ***********************************************
        load paramel

        sys = tf([elparam.K],[elparam.T,2,0]);
%         u0 = 0;
%         y0 = 0;
        % ***********************************************
        
        % Define parameters to standard reference signal
        % ***********************************************
        tinit = 10;
        t1 = 10;
        stepheight = 5;
        % ***********************************************
    case 'vattentank'
        %% Vattentank init
        % Define the system
        % ***********************************************
        load paramvatten
        
        sys = tf([vattenparam.K],[vattenparam.T,1]);
        
         u0 = 4;
         y0 = 5.5;
        % ***********************************************
        
        % Define parameters to standard reference signal
        % ***********************************************
        tinit = 90;
        t1 = 10;
        stepheight = 2;
        % ***********************************************
    case 'vindflojel'
        %% Vindflöjel init
        % Define the system
        % ***********************************************
        load paramvind
        
%         sys = tf([vindparam.Tz*vindparam.Kp,vindparam.Kp],...
%             [vindparam.Tp3*vindparam.Tw^2,vindparam.Tw^2+2*vindparam.Zeta*vindparam.Tp3*vindparam.Tw,2*vindparam.Zeta*vindparam.Tw+vindparam.Tp3,1]);
        sys = tf([vindparam.Kp],...
            [vindparam.Tp3*vindparam.Tw^2,vindparam.Tw^2+2*vindparam.Zeta*vindparam.Tp3*vindparam.Tw,2*vindparam.Zeta*vindparam.Tw+vindparam.Tp3,1]);
%         u0 = 6;
%         y0 = 6.3;
        % ***********************************************
        
        % Define parameters to standard reference signal
        % ***********************************************
        tinit = 7;
        t1 = 20;
        stepheight = 1;
        % ***********************************************
    case 'svavandekula'
        %% Svävande kula init
        % Define the system
        % ***********************************************
        load paramkula
        
        sys = tf(kulaparam.num,kulaparam.denom);
%         u0 = 0;
%         y0 = 0;
        % ***********************************************
        
        % Define parameters to standard reference signal
        % ***********************************************
        tinit = 3;
        t1 = 10;
        stepheight = 0;
        % ***********************************************
end

% Create initial amn and umann signals
amn = [0,1];
umann = [0,0];
% Create initial reference signal
ref = [zeros(tinit/Ts,1);ones(t1/Ts,1)*stepheight];
ref = [(0:(length(ref)-1))'*Ts,ref];