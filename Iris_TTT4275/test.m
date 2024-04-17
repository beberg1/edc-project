% Class 1: Iris-setosa
% Class 2: Iris-versicolor
% Class 3: Iris-virginica

c1 = readtable('class_1.csv');
c2 = readtable('class_2.csv');
c3 = readtable('class_3.csv');

C1 = c1{:,:}';
C2 = c2{:,:}';
C3 = c3{:,:}';


% % Plot histogram for feature 1
% figure(1);
% histogram(C1(1,:), 'FaceColor', 'r'); hold on;
% histogram(C2(1,:), 'FaceColor', 'b'); hold on;
% histogram(C3(1,:), 'FaceColor', 'g');
% title('Sepal length [cm]');
% 
% % Plot histogram for feature 2
% figure(2);
% histogram(C1(2,:), 'FaceColor', 'r'); hold on;
% histogram(C2(2,:), 'FaceColor', 'b'); hold on;
% histogram(C3(2,:), 'FaceColor', 'g');
% title('Sepal width [cm]');
% 
% % Plot histogram for feature 3
% figure(3);
% histogram(C1(3,:), 'FaceColor', 'r'); hold on;
% histogram(C2(3,:), 'FaceColor', 'b'); hold on;
% histogram(C3(3,:), 'FaceColor', 'g');
% title('Petal length [cm]');
% 
% % Plot histogram for feature 4
% figure(4);
% histogram(C1(4,:), 'FaceColor', 'r'); hold on;
% histogram(C2(4,:), 'FaceColor', 'b'); hold on;
% histogram(C3(4,:), 'FaceColor', 'g');
% title('Petal width [cm]');


training_data_class_1 = C1(:,1:30);
testing_data_class_1 = C1(:,31:end);

training_data_class_2 = C2(:,1:30);
testing_data_class_2 = C2(:,31:end);

training_data_class_3 = C3(:,1:30);
testing_data_class_3 = C3(:,31:end);



C = 3; % Number of classes
D = size(training_data_class_1,1); % Number of features
n_samples = size(training_data_class_1,2)*3;

t = zeros(C,n_samples);
x = [training_data_class_1, training_data_class_2, training_data_class_2 ];
x = [x;ones(1,size(x,2))];



for i=1:n_samples
    if i <= 30
        t(:,i) = [1;0;0];
    elseif i >= 31 && i <= 60
        t(:,i) = [0;1;0];
    else
        t(:,i) = [0;0;1];
    end
end
        

W = zeros(C,D+1);

sigmoid = @(x) 1/(1+exp(-x));

N = 1000;
alpha = 0.05;



for m=1:N

    gradMSE = zeros(C,D+1);

    for k=1:n_samples
        zk = W*x(:,k); % Cx(D+1) 
        gk = zeros(C,1);

        for i=1:C
            gk(i) = sigmoid(zk(i));
        end

        gradMSE = gradMSE + ((gk - t(:,k)).*gk.*(1-gk))*(x(:,k)');

    end

    W = W - alpha*gradMSE;
end



xt = [testing_data_class_1, testing_data_class_2, testing_data_class_3];
l = zeros(1,size(xt,2));


g = zeros(C,size(xt,2));
for i=1:size(xt,2)

    zk = W*x(:,i);
    
    for j=1:C
        g(j,i) = sigmoid(zk(j));
    end

    [m,I] = max(g(:,i));
    l(i) = I;


end










         



