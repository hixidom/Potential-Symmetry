clear;

%Script calculates and plots Potential Symmetry for a 2D grid of values and
%then plots the result. May take a minute or so for a 200x200 grid.

%X and Y values for the 2D grid.
gridx=linspace(-.2,2.2,50);
gridy=linspace(-.2,2.2,50);

%Atoms used to calculate PS, with (x,y,z) values.
atoms(1,:)=[0,0,0];
atoms(end+1,:)=[1,0,0];
%atoms(end+1,:)=[#,#,#]; %(feel free to add atoms)

%Specify source and detector locations
source=[0,0,10000]; %Source location
detector=[0,0,10000]; %Detector location

%CALCULATION:
for i=1:numel(gridx)
    for j=1:numel(gridy)
        zdata(i,j)=PSfunc([atoms;gridx(i),gridy(j),0],source,detector);
    end
end

figure(1);
clf();
contour(gridy,gridx,zdata,linspace(min(min(zdata)),max(max(zdata)),60),'fill','on')
axis image
set(gca,'fontsize',14);