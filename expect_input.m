function [sys,x0,str,ts]=expect_input(t,x,u,flag)
% 
% 实现了一个期望输入信号的生成器，其中输出包括信号本身、一阶导数和二阶导数。

switch flag
case 0
    [sys,x0,str,ts]=mdlInitializeSizes;     % 初始化模型尺寸
case 1
    sys=mdlDerivatives(t,x,u);  % 计算导数
case 3
    sys=mdlOutputs(t,x,u);  % 计算输出
case {2, 4, 9 }
    sys = [];  % 对于其他 flag，返回空数组
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end

% 初始化函数，定义模型的尺寸
function [sys,x0,str,ts]=mdlInitializeSizes
    sizes = simsizes;  % 创建一个 simsizes 对象
    sizes.NumContStates = 0;  % 连续状态数为0
    sizes.NumDiscStates = 0;  % 离散状态数为0
    sizes.NumOutputs = 3;  % 输出数为3
    sizes.NumInputs = 0;  % 输入数为0
    sizes.DirFeedthrough = 0;  % 不允许直接馈送
    sizes.NumSampleTimes = 0;  % 离散采样时间数为0
    
    sys=simsizes(sizes);  % 创建 sys 结构体
    x0 = [];  % 初始状态为空
    str = [];  % 状态信息为空
    ts = [];  % 采样时间为空

% 计算输出的函数
function sys=mdlOutputs(t,x,u)
    x0 = sin(t);  % 期望位置
    dx0 = cos(t);  % 输入信号的一阶导数 期望速度
    ddx0 = -sin(t);  % 输入信号的二阶导数 期望加速度

%     sys(1) = x0;  % 输出期望位置
%     sys(2) = dx0;  % 输出期望速度
%     sys(3) = ddx0;  % 输出期望加速度
    % 如果要输出常数，可以将上述三行注释掉，使用以下三行
    sys(1) = 1;
    sys(2) = 0;
    sys(3) = 0;


