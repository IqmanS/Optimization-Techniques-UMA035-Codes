% Basic Feasible Solution
clc
A = [2 3 -1 4; 1 -2 6 -7];
b = [8;-3];
c = [2 3 4 7];
m = size(A,1);  %No of rows
n = size(A,2);  %No of columns
if n>=m
    nCm = nchoosek(n,m);
    p = nchoosek(1:n,2);
    
    solutions = [];
    for i = 1:nCm
        y = zeros(n,1);
        Ai = A(:,p(i,:));
        %Ax=b
        x = inv(Ai)*b;
    
        if all (x>=0 & x~=inf)
            y(p(i,:)) = x;
            solutions = [solutions y];
        end
    end
    solutions
    z = c*solutions
    [BFsol,index] = max(z)
    fprintf("Optimal Value is: %.2f, \nOptimal Solution is (%.2f, %.2f, %.2f, %.2f)\n",BFsol,solutions(:,index))
else
    fprintf("# of Constraints are more than # of Unknowns")
end