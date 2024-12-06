function [sys,x0,str,ts]=admittance_ctrl_fext(t,x,u,flag)
% 用于实现一个导纳控制器
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

% 初始化函数，定义模型的尺寸
function [sys,x0,str,ts]=mdlInitializeSizes
    sizes = simsizes;  % 创建一个 simsizes 对象
    sizes.NumContStates = 2;  % 两个连续状态变量
    sizes.NumDiscStates = 0;  % 没有离散状态
    sizes.NumOutputs = 2;  % 输出两个信号
    sizes.NumInputs = 6;  % 输入四个信号 外力 期望位置 期望速度 期望加速度
    sizes.DirFeedthrough = 0;  % 不允许直接馈送
    sizes.NumSampleTimes = 0;  % 离散采样时间数为0
    
    sys = simsizes(sizes);  % 创建 sys 结构体
    x0 = [0, 0];  % 初始状态为 [0, 0]
    str = [];  % 状态信息为空
    ts = [];  % 采样时间为空
    
    % 计算微分方程的导数
function sys=mdlDerivatives(t,x,u)

    % 阻抗参数
    Md = 0.8; % 质量 单位：kg
    Kd = 100; % 刚度 单位：N/m
    Dd = 2*0.7*sqrt(Md*Kd); % 阻尼 单位：N*s/m

    % 期望轨迹
    x0 = u(1);  % 期望位置
    dx0 = u(2);  % 期望速度
    ddx0 = u(3);  % 期望加速度
    Fext = u(6); % 外部施加的力

    % xd微分方程
    xd = x(1); % 位移
    dxd = x(2); % 速度
    ddxd = 1/Md*(Fext - Kd*(xd-x0) - Dd*(dxd-dx0)) + ddx0;

    sys(1) = dxd;  
    sys(2) = ddxd;  

% 计算输出的函数
function sys=mdlOutputs(t,x,u)
    sys(1) = x(1);  % 输出系统位移
    sys(2) = x(2);  % 输出系统速度

