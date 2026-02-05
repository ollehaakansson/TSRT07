% This file can be used to make the necessary settings for xPC Target.

tg = xpctarget.xpc('TCPIP','192.168.0.10','22222'); % connect to target PC (RT3)
% tg = xpctarget.xpc('TCPIP','192.168.1.10','22222'); % connect to target PC (folab)
setxpcenv('CCompiler','VisualC');
setxpcenv('CompilerPath','C:\Program Files (x86)\Microsoft Visual Studio 14.0');
setxpcenv('HostTargetComm','TcpIp');
setxpcenv('TcpIpTargetAddress','192.168.0.10'); %(RT3)
% setxpcenv('TcpIpTargetAddress','192.168.1.10'); %(folab)
setxpcenv('TcpIpTargetPort','22222');
