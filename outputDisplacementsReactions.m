function outputDisplacementsReactions(displacements,stiffness,GDof,prescribedDof)

% output displacements and reactions in tabular form

% GDof: total number of degrees of freedom

% Displacements

disp('Displacements')
jj=1:GDof;format
[jj' displacements]

% reactions 

F=stiffness*displacements;
reactions=F(prescribedDof);
disp('reactions')
[prescribedDof reactions]

end