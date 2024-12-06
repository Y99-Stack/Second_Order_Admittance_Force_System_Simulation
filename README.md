# Second_Order_Admittance_System_Simulation
Second Order Admittance System Simulation in Simulink

使用 `Simulink `进行二阶导纳系统的完整仿真的示例，包括四个模块：`expect_input`、`admittance_ctrl_fext`、`position_control_fext `和 `plant_dynamics_fext`。 

打开 `Simulink `并创建一个新的模型。

在模型中添加以下模块：

- `expect_input `模块：用于生成期望输入信号。 
- `admittance_ctrl_fext `模块：表示导纳控制器，用于计算期望位置。 
- `position_control_fext `模块：表示位置控制器，用于计算控制力。 
- `plant_dynamics_fext `模块：表示系统动力学，用于计算系统响应。



----

Example of a complete simulation of a second-order admittance system using `Simulink`, consisting of four modules: `expect_input`, `admittance_ctrl_fext`, `position_control_fext`, and `plant_dynamics_fext`.

Open `Simulink `and create a new model.

Add the following modules to the model:

- `expect_input `module: Used to generate the desired input signal.
- `admittance_ctrl_fext `module: represents the admittance controller used to calculate the desired position.
- `position_control_fext `module: represents the position controller and is used to calculate the control force.
- `plant_dynamics_fext `module: Represents the system dynamics and is used to calculate the system response.
