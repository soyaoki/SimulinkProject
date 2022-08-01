clear all;clc;close all;

%�ԗ��p�����[�^
m=200; %�ԑ̏d��
Fz=m*9.81; %�����׏d
Jm=0.028; %�������[�����g(���[�^)
Jw=0.021; %�������[�����g(�^�C��)

%�^�C���쓮�̓��f���̊e�W��
% K1=0.8883;
% K2=-2.7082;
% K3=3.5188;
% K4=-2.0869;
% K5=0.4536;

%�}�W�b�N�t�H�[�~�����̊e�W��
K1=6.5;
K2=1.54;
K3=-1;
K4=-4;

%�ԗ����@�p�����[�^
lf=0.75; %�d�S����O�֎��܂ł̋���
lr=0.53; %�d�S�����֎��܂ł̋���
l=lf+lr; %�z�C�[���x�[�X
h=0.35; %�d�S����
rw=0.225; %�^�C���L�����a
A=1.528; %�ʐ�
n=6.267; %�C���z�C�[�����[�^�̌�����

%���[�^�̃p�����[�^
Km=2.0;
tau_m=0.007;
alfa=rw/((Jm*n)+(Jw/n));

%�}�g���N�X
A1=[0 0 alfa; 1 0 0; 0 0 -1/tau_m];
B1=[0;0;Km];

%�]���֐��̏d��
q11=1/(0.1)^2;
q22=1/(0.01)^2;
q33=1/(10)^2;
r11=1/(0.1)^2;
Q=diag([q11 q22 q33]);
R=[r11];

%�Q�C������
K=lqr(A1,B1,Q,R);
k1=K(1,1);
k2=K(1,2);
k3=K(1,3);

%Simlation
sim('simtcs_V1')
figure
subplot(311)
plot(t.data,vw.data,'b',t.data,vb.data,'r',t.data,vwd.data,'k');
hold on;grid on;
xlabel('Time[s]')
ylabel('Wheel speed/Vehicle speed [m/s]')
subplot(312)
plot(t.data,vw.data-vwd.data)
hold on;grid on;
xlabel('Time[s]')
ylabel('Wheel speed error[m/s]')
subplot(313)
plot(t.data,Tm.data)
hold on;grid on;
xlabel('Time[s]')
ylabel('Motor torque [Nm]')

%�`�B�֐�
num=[alfa*Km*k1 alfa*Km*k2];
den=[tau_m 1+k3 alfa*Km*k1 alfa*Km*k2];
f=logspace(-1,2,1000);
w=2*pi*f;

%���g������
[mag,phase]=bode(num,den,w);
figure
subplot(211)
semilogx(f,20*log10(mag));
hold on;grid on;
subplot(212)
semilogx(f,phase);
hold on;grid on;
