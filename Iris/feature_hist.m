c1 = readtable('class_1.csv');
c2 = readtable('class_2.csv');
c3 = readtable('class_3.csv');

C1 = c1{:,:}';
C2 = c2{:,:}';
C3 = c3{:,:}';


% % Plot histogram for feature 1
figure(1);
histogram(C1(1,:), 'FaceColor', 'r'); hold on;
histogram(C2(1,:), 'FaceColor', 'b'); hold on;
histogram(C3(1,:), 'FaceColor', 'g');
title('Sepal length [cm]');
% 
% % Plot histogram for feature 2
figure(2);
histogram(C1(2,:), 'FaceColor', 'r'); hold on;
histogram(C2(2,:), 'FaceColor', 'b'); hold on;
histogram(C3(2,:), 'FaceColor', 'g');
title('Sepal width [cm]');
% 
% % Plot histogram for feature 3
figure(3);
histogram(C1(3,:), 'FaceColor', 'r'); hold on;
histogram(C2(3,:), 'FaceColor', 'b'); hold on;
histogram(C3(3,:), 'FaceColor', 'g');
title('Petal length [cm]');
% 
% % Plot histogram for feature 4
figure(4);
histogram(C1(4,:), 'FaceColor', 'r'); hold on;
histogram(C2(4,:), 'FaceColor', 'b'); hold on;
histogram(C3(4,:), 'FaceColor', 'g');
title('Petal width [cm]');