function plotquarter(xmin,xmax,ymin,ymax,z)

plot3([xmin xmax xmax xmin xmin],[ymin ymin ymax ymax ymin],[z z z z z],'k')
end