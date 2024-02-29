% Graphical Solution
clc
%Phase 1
A = [1 2;1 1;1 -2];
b = [10; 6 ; 1];
c = [2 1];

%Phase 2
x1 = 0:max(b);
x21 = (b(1)-A(1,1)*x1)/A(1,2);
x22 = (b(2)-A(2,1)*x1)/A(2,2);
x23 = (b(3)-A(3,1)*x1)/A(3,2);

%Phase 3
x21 = max(0,x21);
x22 = max(0,x22);
x23 = max(0,x23);

hold on
plot(x1, x21, 'r',x1, x22, 'b',x1, x23, 'g')
title("Lines")
xlabel("X-axis");
ylabel("Y-axis");

%Phase 4: Intersection with axes
c1 = find(x1 == 0);
c21 = find(x21 == 0);
c22 = find(x22 == 0);
c23 = find(x23 == 0);
coordinates = [x1([c1 c21]) x1([c1 c22]) x1([c1 c23]); x21([c1 c21]) x22([c1 c22]) x23([c1 c23])]';

%Phase 5: Intersection points
for i = 1:size(A,1)-1
    for j = i+1:size(A,1)
        % x=A^(-1)*b
        x = inv(A([i,j],:))*b([i,j]);
        coordinates = [coordinates;x'];
    end
end
coordinates = unique(coordinates,"rows");

%Phase 6
for i = 1:size(coordinates,1)
    eqn1(i) = A(1,1)*coordinates(i,1)+A(1,2)*coordinates(i,2)-b(1);
    eqn2(i) = A(2,1)*coordinates(i,1)+A(2,2)*coordinates(i,2)-b(2);
    eqn3(i) = A(3,1)*coordinates(i,1)+A(3,2)*coordinates(i,2)-b(3);
end
s1 = find(eqn1>0);
s2 = find(eqn2>0);
s3 = find(eqn3>0);
s = unique([s1 s2 s3]);
coordinates(s,:) = [];
    
%Phase 7
for i = 1:size(coordinates,1)
    obj_score(i) = 2*coordinates(i,1)+coordinates(i,2);
end
obj_score;
[score,index] = max(obj_score);
fprintf('Optimal Value of Z is: %.2f\n',score);
fprintf('Optimal Point is: (%.2f,%.2f)\n\n',coordinates(index,1),coordinates(index,2));
scatter(coordinates(index,1),coordinates(index,2),"filled")
legend("l1","l2","l3","Maxima");