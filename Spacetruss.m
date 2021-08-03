% Matlab code for FEM analysis of 3D space truss
% Group H

clear all;
clc;

% Input parameters

E=1e11; % Modulus of elasticity
A=0.0001; %Area of cross-section
EA=E*A;

% Generation of coordinates and connectivity matrix

numberElements=3;
numberNodes=4;

elementNodes=[1 2;1 3;1 4];
nodeCoordinates=[25 0 200; 25 50 0; 50 0 0; 0 0 0];

xx=nodeCoordinates(:,1); % extract all rows and first column of nodecoordinate matrix and put in xx variable
yy=nodeCoordinates(:,2);
zz=nodeCoordinates(:,3);

% L=sqrt((xx(2)-xx(1))^2+(yy(2)-yy(1))^2+(zz(2)-zz(1))^2);

% Definition of F = K*x equation

GDof=3*numberNodes; %Total no. of degrees of freedom 2 per node
displacements=zeros(GDof,1); % create a row vector with zero value
force=zeros(GDof,1);

% Apply load on node 1 in y-direction

force(2)=100;
force(3)=-100; % extract position 3 from force row vector and assign value -1000 to it 

% Computation of the system stiffness matrix

[stiffness]=Stiffnessmatrix(GDof,numberElements,elementNodes,xx,yy,zz,EA);

% Boundary conditions and solution

% Essential BC

prescribedDof=[4:12]';

% Solution

displacements=solution(GDof,prescribedDof,stiffness,force);

% Visualise geometry
 
figure
clf 
hold on
Visualisegeometry(numberNodes,numberElements,nodeCoordinates,elementNodes,displacements);
 
% Stresses in members

Outputstress(numberElements,elementNodes,xx,yy,zz,displacements,E,nodeCoordinates,numberNodes)

% Output displacements and reactions

outputDisplacementsReactions(displacements,stiffness,GDof,prescribedDof);




