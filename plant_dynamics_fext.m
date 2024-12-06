function [sys,x0,str,ts]=plant_dynamics_fext(t,x,u,flag)
% 函数签名定义了四个输出参数：sys, x0, str, ts
% flag 用于指示函数被调用的原因（例如初始化、导数计算、输出计算等）
% 用于实现一个单质量块系统的动力学模型。
% 模拟了一个简单的单质量块系统，其中外部施加的力通过阻尼和刚度影响系统的运动。
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
sizes.NumContStates = 2;  % 有两个连续状态（位移和速度）
sizes.NumDiscStates = 0;  % 没有离散状态
sizes.NumOutputs = 3;  % 输出两个信号（位移和速度）
sizes.NumInputs = 1;  % 输入一个信号（外力）
sizes.DirFeedthrough = 0;  % 不允许直接馈送
sizes.NumSampleTimes = 0;  % 离散采样时间数为0
sys=simsizes(sizes);
x0=[0 0];
str=[];
ts=[];

% 计算导数的函数
function sys=mdlDerivatives(t,x,u)
%     M=1;%质量
%     C=0;%阻尼
%     K=0;%刚度
%     F=u(1);%受到的控制力
%     sys(1)=x(2);
%     sys(2)=(F-C*x(2)-K*x(1))/M;
    m = 1.0; % 质量 kg
    ke = 3200; % 弹簧刚度 N/m
    cv = 1; % 粘性摩擦系数 Ns/m 
    Fc = 3; % 库仑摩擦系数 N
    x0=1;
    F=u(1); % 控制力
    Fext = -ke*(x(1)-x0); %外力
    Ff = -sign(x(2))*(cv*abs(x(2))+Fc); % 系统动力学，考虑不了外力和摩擦力
    sys(1) = x(2);
    sys(2) = (F+Fext+Ff)/m;

function sys=mdlOutputs(t,x,u)
    ke = 3200;
    sys(1)=x(1);%位移
    sys(2)=x(2);%速度
    sys(3) = -ke*(x(1)-1);

