function displacements=solution(GDof,prescribedDof,stiffness,force)

activeDof=setdiff([1:GDof]',[prescribedDof]);
U=pinv(stiffness(activeDof,activeDof))*force(activeDof);
displacements=zeros(GDof,1);
displacements(activeDof)=U;