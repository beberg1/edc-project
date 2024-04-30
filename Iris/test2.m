% Class 1: Iris-setosa
% Class 2: Iris-versicolor
% Class 3: Iris-virginica

% Reading data from csv-files, and converting from table to arrays
c1 = readtable('class_1.csv'); C1 = c1{:,:}';
c2 = readtable('class_2.csv'); C2 = c2{:,:}';
c3 = readtable('class_3.csv'); C3 = c3{:,:}';

N_traning_per_class = 30;


% Dividing the data from each class into testing and training
training_data_class_1 = C1(:,1:20);
testing_data_class_1 = C1(:,21:end);

training_data_class_2 = C2(:,1:20);
testing_data_class_2 = C2(:,21:end);

training_data_class_3 = C3(:,1:20);
testing_data_class_3 = C3(:,21:end);



C = 3; % Number of classes
D = size(training_data_class_1,1); % Number of features
n_samples = size(training_data_class_1,2)*3;

t = zeros(C,n_samples);
x = [training_data_class_1, training_data_class_2, training_data_class_3 ];
x = [x;ones(1,size(x,2))];


% Assigning testing label vectors for each feature sample
for i=1:n_samples
    if i <= 20 % First class
        t(:,i) = [1;0;0];
    elseif i >= 21 && i <= 40 % Second class
        t(:,i) = [0;1;0]; 
    else
        t(:,i) = [0;0;1]; % Third class
    end
end


        

% Defining weight matrix
W = zeros(C,D+1);

sigmoid = @(x) 1/(1+exp(-x));



N = 1000;
% [0.05 0.02 0.01 0.007 0.005];
alpha = 0.007;


predicted_class_training = zeros(n_samples,1);

g = zeros(C,size(x,2));

MSE = zeros(1,N);

%for q = 1:size(alphas,1)
% Iterative gradient descent, N iterations
for m=1:N

    gradMSE = zeros(C,D+1);
    MSEm = 0;

    % Go through all samples to compute gradient of MSE and MSE
    for k=1:n_samples
        zk = W*x(:,k); % Cx(D+1) 
        gk = zeros(C,1);

        for i=1:C
            gk(i) = sigmoid(zk(i));
        end

        if m == N
            [mm, I] = max(gk);
            predicted_class_training(k) = I;
        end

        MSEm = MSEm + (gk - t(:,k))'*(gk - t(:,k));
        gradMSE = gradMSE + ((gk - t(:,k)).*gk.*(1-gk))*(x(:,k)');

    end

    MSE(m) = MSEm;
    
    % Update weight-matrix in direction opposite to the gradient
    W = W - alpha*gradMSE;
end

% Known class for training-data
known_class_training = [ones(1,n_samples/3) 2*ones(1,n_samples/3) 3*ones(1,n_samples/3)]';
known_class_testing = [ones(1,30) 2*ones(1,30) 3*ones(1,30)]';





xt = [testing_data_class_1, testing_data_class_2, testing_data_class_3];
xt = [xt; ones(1,size(xt,2))];
predicted_class_testing = zeros(size(xt,2),1);


g = zeros(C,size(xt,2));

% Testing the linear classifier on training set
for i=1:size(xt,2)

    zk = W*xt(:,i);
    
    for j=1:C
        g(j,i) = sigmoid(zk(j));
    end

    [m,I] = max(g(:,i));
    % Setting assigned class of the i'th traning sample in l(i)
    predicted_class_testing(i) = I;

end

C_training = confusionmat(known_class_training, predicted_class_training);
C_testing = confusionmat(known_class_testing,predicted_class_testing);


% figure(1);
% annotation('rectangle', [0 0 1 1], 'Color', 'w');
% confusionchart(C_training);
% title('Confusion matrix for training set');
% figure(2);
% annotation('rectangle', [0 0 1 1], 'Color', 'w');
% confusionchart(C_testing);
% title('Confusion matrix for test set');
% 
% exportgraphics(figure(1),'conf_matrix_training_20_30.pdf');
% exportgraphics(figure(2),'conf_matrix_test_20_30.pdf');
% 
% 
% 
% % [0.05 0.02 0.01 0.007 0.005];
% figure(3);
% plot(MSE);
% xlabel('Iteration n');
% title('Squared error');
% legend({'$\alpha=0.05$','$\alpha=0.02$','$\alpha=0.01$','$\alpha=0.007$','$\alpha=0.005$'},'Interpreter','latex','Location','northeast');

%fig = openfig("alphas.fig");
%annotation('rectangle', [0 0 1 1], 'Color', 'w');
%exportgraphics(fig,'alphas.pdf');

% Plot histogram for feature 1
figure(1);
annotation('rectangle', [0 0 1 1], 'Color', 'w');
histogram(C1(1,:), 'FaceColor', 'r'); hold on;
histogram(C2(1,:), 'FaceColor', 'b'); hold on;
histogram(C3(1,:), 'FaceColor', 'g');
title('Sepal length');
xlabel('Sepal length [cm]');
ylabel('Number of samples');
legend('Iris-setosa', 'Iris-versicolor', 'Iris-virginica');

% Plot histogram for feature 2
figure(2);
annotation('rectangle', [0 0 1 1], 'Color', 'w');
histogram(C1(2,:), 'FaceColor', 'r'); hold on;
histogram(C2(2,:), 'FaceColor', 'b'); hold on;
histogram(C3(2,:), 'FaceColor', 'g');
title('Sepal width');
xlabel('Sepal width [cm]');
ylabel('Number of samples');
legend('Iris-setosa', 'Iris-versicolor', 'Iris-virginica');


% Plot histogram for feature 3
figure(3);
annotation('rectangle', [0 0 1 1], 'Color', 'w');
histogram(C1(3,:), 'FaceColor', 'r'); hold on;
histogram(C2(3,:), 'FaceColor', 'b'); hold on;
histogram(C3(3,:), 'FaceColor', 'g');
title('Petal length');
xlabel('Petal length [cm]');
ylabel('Number of samples');
legend('Iris-setosa', 'Iris-versicolor', 'Iris-virginica');

% Plot histogram for feature 4
figure(4);
annotation('rectangle', [0 0 1 1], 'Color', 'w');
histogram(C1(4,:), 'FaceColor', 'r'); hold on;
histogram(C2(4,:), 'FaceColor', 'b'); hold on;
histogram(C3(4,:), 'FaceColor', 'g');
title('Petal width');
xlabel('Petal width [cm]');
ylabel('Number of samples');
legend('Iris-setosa', 'Iris-versicolor', 'Iris-virginica');

exportgraphics(figure(1), 'hist_feature1.pdf');
exportgraphics(figure(2), 'hist_feature2.pdf');
exportgraphics(figure(3), 'hist_feature3.pdf');
exportgraphics(figure(4), 'hist_feature4.pdf');












         



