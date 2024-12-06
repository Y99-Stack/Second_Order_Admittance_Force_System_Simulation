function [sys,x0,str,ts]=position_control_fext(t,x,u,flag)
% 基于PD控制的位置控制器
% 通过计算期望位置和当前位置之间的误差，以及期望速度和当前速度之间的误差，来生成一个力，用于追踪期望位置。
switch flag
case 0
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1
    sys=mdlDerivatives(t,x,u);
case 3
    sys=mdlOutputs(t,x,u);
case {2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
    sizes = simsizes;
    sizes.NumContStates  = 0;
    sizes.NumDiscStates  = 0;
    sizes.NumOutputs     = 1; % 输出：力
    sizes.NumInputs      = 5; % 输入：期望位置 期望速度 实际位置 实际速度
    sizes.DirFeedthrough = 1;
    sizes.NumSampleTimes = 0;
    sys=simsizes(sizes);
    x0=[];
    str=[];
    ts=[];

% 计算输出的函数
function sys=mdlOutputs(t,x,u)

% PD控制系数
    m=1; % 质量
    kp = 1e6; % 比例 N/m
    kd = 2*0.7*(kp*m)^0.5; % 微分 N*s/m
    xd = u(1);  % 期望位置
    x = u(3);  % 当前位置
    dx = u(4);  % 当前速度

    % 输出力
    F = kp*(xd-x) - kd*dx;
    sys(1) = F;  % 输出力信号

