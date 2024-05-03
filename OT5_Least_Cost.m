% OT LAB 4 CODE (Least Cost Method)

clc
c = [2 10 4 5; %cost per unit
    6 12 8 11;
    3 9 5 7];
a = [12 25 20]; %demand
b = [25 10 15 5]; %supply

n = size(c,2)
m = size(c,1)

if (sum(a) == sum(b))
    fprintf("Balanced")
elseif (sum(a)<sum(b))
    fprintf("Unbalanced: A<B, Row added\n")
    a = [a sum(b)-sum(a)];
    c(end+1,:) = zeros(n,1);
    m = m+1;
elseif (sum(a)>sum(b))
    fprintf("Unbalanced: A>B, Col added\n")
    b = [b sum(a)-sum(b)];
    c(:,end+1) = zeros(m,1);
    n = n+1;
end
orig_c = c;
X = zeros(m,n);

for i=1:m
    for j=1:n
        min_cost = min(min(c));
        if min_cost == inf
            break
        end
        [p1,q1] = find(min_cost == c);
        p = p1(1);
        q = q1(1);
        X(p,q) = min(a(p),b(q));
        if (min(a(p),b(q)) == a(p))
            b(q) = b(q)-a(p);
            a(p) = 0;
            c(p,:) = inf;
        else
            a(p) = a(p)-b(q);
            b(q) = 0;
            c(:,q) = inf;
        end
    end
end
X
ans = 0;
for i =1:m
    for j = 1:n
    ans = ans + orig_c(i,j)*X(i,j);
    end
end
fprintf("Least Cost is %d\n",ans)