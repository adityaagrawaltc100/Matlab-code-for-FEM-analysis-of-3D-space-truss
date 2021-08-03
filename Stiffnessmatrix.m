function [stiffness]=Stiffnessmatrix(GDof,numberElements,elementNodes,xx,yy,zz,EA);
    
stiffness=zeros(GDof); % create matrix of order gdof x gdof with zero values

% computation of the system stiffness matrix

for e=1:numberElements; % to repeat command use for loop and also create a vector e with value from 1 to numberelements
    
% elementDof: element degrees of freedom (Dof)

indice=elementNodes(e,:) ; % extract 1st row from elementnodes that is element 1 nodes and all columns and assign it to indices
elementDof=[3*indice(1)-2 3*indice(1)-1 3*indice(1) 3*indice(2)-2 3*indice(2)-1 3*indice(2)] ; % create a vector, extract indice 1 and 2

xa=xx(indice(2))-xx(indice(1));
ya=yy(indice(2))-yy(indice(1));
za=zz(indice(2))-zz(indice(1));

length_element=sqrt(xa*xa+ya*ya+za*za);
CX=xa/length_element;
CY=ya/length_element;
CZ=za/length_element;

k1=EA/length_element*[CX*CX CX*CY CX*CZ -CX*CX -CX*CY -CX*CZ; CY*CX CY*CY CY*CZ -CX*CY -CY*CY -CY*CZ; CZ*CX CZ*CY CZ*CZ -CX*CZ -CY*CZ -CZ*CZ; -CX*CX -CX*CY -CX*CZ CX*CX CX*CY CX*CZ; -CX*CY -CY*CY -CY*CZ CX*CY CY*CY CY*CZ; -CX*CZ -CY*CZ -CZ*CZ CX*CZ CY*CZ CZ*CZ];
stiffness(elementDof,elementDof)= stiffness(elementDof,elementDof)+k1;
end