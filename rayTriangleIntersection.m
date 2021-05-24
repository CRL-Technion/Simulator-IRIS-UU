function [flag, u, v, t] = rayTriangleIntersection (org, dir, v0, v1, v2)
% Ray/triangle intersection using the algorithm proposed by M?ller and Trumbore (1997).
%
% Input:
%    o : origin.
%    d : direction.
%    p0, p1, p2: vertices of the triangle.
% Output:
%    flag: (0) Reject, (1) Intersect.
%    u,v: barycentric coordinates.
%    t: distance from the ray origin.
% Author: 
%    Jesus Mena
epsilon = (1e-6);
    v0v1 = v1-v0;
    v0v2 = v2-v0;
    pvec  = cross(dir,v0v2);
%     a  = dot(e1,q); % determinant of the matrix M
    det  = dot(v0v1',pvec'); % determinant of the matrix M
%     if (a>-epsilon && a<epsilon)
    parallelCheck = det<=-epsilon | det>=epsilon;
%     if (sum(a>-epsilon & a<epsilon) >epsilon)
    if (sum(abs(det)<epsilon) > length(det)-1)

%     else
        % the vector is parallel to the plane (the intersection is at infinity)
        [flag, u, v, t] = deal(0,0,0,0);
        return;
    end;
    
    inv_det = (1./det)';
    tvec = org-v0;
    u = dot(tvec',pvec').*inv_det';
    
    u_outside = u>=0.0 & u<=1;

    if ((sum(u<0.0 | u>1)>epsilon) > length(u)-1)
%     else
        % the intersection is outside of the triangle
        [flag, u, v, t] = deal(0,0,0,0);
        return;          
    end;
    
    qvec = cross(tvec,v0v1);
    v = dot(dir',qvec').*inv_det';
    v_outside = v>=0.0 & u+v<=1.0;

    if (sum(v<0.0 | u+v>1.0)>length(u)-1)
%     else
        % the intersection is outside of the triangle
        [flag, u, v, t] = deal(0,0,0,0);
        return;
    end;
    
    t = inv_det'.*dot(v0v2',qvec'); % verified! 
    t =  t(parallelCheck & u_outside & v_outside);
    flag = 1; 
    return;
end
