function isWcovRegion = CheckIsWcovRegion(VertexPosition)

X = [-100,100];
Y = [-11,1];
Z = [-20,0];

if (VertexPosition(1) >= X(1) && VertexPosition(1) <= X(2) &&...
        VertexPosition(2) >= Y(1) && VertexPosition(2) <= Y(2) &&...
        VertexPosition(3) >= Z(1) && VertexPosition(3) <= Z(2))
    isWcovRegion = 0;
else
    isWcovRegion = 1;
end


end