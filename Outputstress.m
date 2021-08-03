function Outputstress(numberElements,elementNodes,xx,yy,zz,displacements,E,nodeCoordinates,numberNodes);

% Stress in elements

for e=1:numberElements;

indice=elementNodes(e,:);
elementDof=[3*indice(1)-2 3*indice(1)-1 3*indice(1) 3*indice(2)-2 3*indice(2)-1 3*indice(2)];

xa=xx(indice(2))-xx(indice(1));
ya=yy(indice(2))-yy(indice(1));
za=zz(indice(2))-zz(indice(1));

length_element=sqrt(xa*xa+ya*ya+za*za);
CX=xa/length_element;
CY=ya/length_element;
CZ=za/length_element;

sigma(e)=E/length_element*[-CX -CY -CZ CX CY CZ]*displacements(elementDof);

disp('stresses')
sigma'
end

figure(2);

 us=1:3:3*numberNodes-2;
 vs=2:3:3*numberNodes-1;
 ws=3:3:3*numberNodes;
 XX=displacements(us); % extract 1 4 7 positions or x displacement positions and assign to xx
 YY=displacements(vs);
 ZZ=displacements(ws);
 
 dispNorm=max(sqrt(XX.^2+YY.^2+ZZ.^2));
 
 scaleFact=1*dispNorm;
 
SIGMA=sort(sigma);

cc=jet(length(SIGMA));

AA=cell(1,length(SIGMA));
Pplot=[];

for e=1:numberElements
    
      X1=nodeCoordinates([elementNodes(e,1),elementNodes(e,2)],1); 
      
      Y1=nodeCoordinates([elementNodes(e,1),elementNodes(e,2)],2);
      
      Z1=nodeCoordinates([elementNodes(e,1),elementNodes(e,2)],3);
      
      X2=X1+scaleFact*XX([elementNodes(e,1),elementNodes(e,2)]); 
      
      Y2=Y1+scaleFact*YY([elementNodes(e,1),elementNodes(e,2)]);
      
      Z2=Z1+scaleFact*ZZ([elementNodes(e,1),elementNodes(e,2)]);
      
      l2=line(X2,Y2,Z2,'Color',cc(e,:),'Marker','.','MarkerSize', 15,'LineWidth',2);
      
      Pplot=[Pplot,l2];
  
      AA{1,e}=[num2str(SIGMA(e)),' Pa'];
      
     axis equal
     view(3)
     axis([-5 70 0 60 0 240])
     
end

legend(Pplot,AA);
xlabel('X')
ylabel('Y')
zlabel('Z')
title('Stress Plot of space truss')



