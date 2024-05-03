% OT LAB CODE STEEPEST HILL
clc
syms x y;

% Objective Function
f = (x-y+2*x*x+2*x*y+y*y);
fx = inline(f);
func = @(X)(fx(X(1),X(2)))

% Gradient Function
g = gradient(f);
gx = inline(g);
grad = @(X)(gx(X(1),X(2)))

H = hessian(f)
xi = [0,0];
tol = 0.001;
max_iter = 100;

% Iterations
for i=0:max_iter
    s = -grad(xi);
    if norm(s)<=tol
        break
    end
    lambda = (transpose(s)*s)/(transpose(s)*H*s);
    xi = xi+lambda*s;
end
opt = func(xi);

fprintf("Optimal Value is %.2f at\n" + ...
    "(x,y) is %.2f,%.2f" + ...
    "\nIterations ran %d\n\n", ...
    opt,xi(1),xi(2),i)