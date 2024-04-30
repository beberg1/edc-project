% Class 1: Iris-setosa
% Class 2: Iris-versicolor
% Class 3: Iris-virginica

% Reading data from csv-files and converting tables to arrays
c1 = readtable('class_1.csv'); C1 = c1{:,:}';
c2 = readtable('class_2.csv'); C2 = c2{:,:}';
c3 = readtable('class_3.csv'); C3 = c3{:,:}';

N_training_per_class = 30;
N_testing_per_class = 20;

% Dividing the data from each class into testing and training
training_data_class_1 = C1(:,1:N_training_per_class);
testing_data_class_1 = C1(:,N_training_per_class+1:end);

training_data_class_2 = C2(:,1:N_training_per_class);
testing_data_class_2 = C2(:,N_training_per_class+1:end);

training_data_class_3 = C3(:,1:N_training_per_class);
testing_data_class_3 = C3(:,N_training_per_class+1:end);


C = 3;                                  % Number of classes
D = size(training_data_class_1,1);      % Number of features
N_training = C*N_training_per_class;    % Number of training samples

t = zeros(C,N_training);                % Label vectors
x = [training_data_class_1, training_data_class_2, training_data_class_3 ];
x = [x;ones(1,N_training)];              % Training sample vectors, with 1's



% Assigning testing label vectors for each feature sample
for i=1:N_training
    if i <= N_training_per_class % First class
        t(:,i) = [1;0;0];
    elseif i >= N_training_per_class+1 && i <= 2*N_training_per_class % Second class
        t(:,i) = [0;1;0]; 
    else
        t(:,i) = [0;0;1]; % Third class
    end
end
        


W = zeros(C,D+1);               % Weight matrix
sigmoid = @(x) 1/(1+exp(-x));   % Sigmoid function
N_iter = 1000;                  % Number of training iterations

% [0.05 0.02 0.01 0.007 0.0001];
alpha = 0.0001; % Degree of which weights are adjusted during traning

% Prepared vector for predicted class for each training sample
predicted_class_training = zeros(N_training,1);

% MSE per iteriation
MSE = zeros(1,N_iter);

%for q = 1:size(alphas,1)
% Iterative gradient descent, N iterations
for m=1:N_iter

    gradMSE = zeros(C,D+1);     % Initalize gradient of MSE w.r.t W
    MSEm = 0;                   % Initiliaze MSE of current iteration

    % Go through all samples to compute gradient of MSE and MSE
    for k=1:N_training
        zk = W*x(:,k); % Cx(D+1) 
        gk = zeros(C,1);

        for i=1:C
            gk(i) = sigmoid(zk(i));
        end

        if m == N_iter
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
known_class_training = [ones(1,N_training_per_class) 2*ones(1,N_training_per_class) 3*ones(1,N_training_per_class)]';
known_class_testing = [ones(1,N_testing_per_class) 2*ones(1,N_testing_per_class) 3*ones(1,N_testing_per_class)]';



N_testing = C*N_testing_per_class;

xt = [testing_data_class_1, testing_data_class_2, testing_data_class_3];
xt = [xt; ones(1,size(xt,2))];
predicted_class_testing = zeros(size(xt,2),1);


g = zeros(C,size(xt,2));

% Testing the linear classifier on training set
for k=1:N_testing
    zk = W*xt(:,k);
    gk = zeros(C,1);
    
    for j=1:C
        gk(j) = sigmoid(zk(j));
    end

    [m,I] = max(gk);
    % Setting assigned class of the i'th traning sample in l(i)
    predicted_class_testing(k) = I;

end

C_training = confusionmat(known_class_training, predicted_class_training);
C_testing = confusionmat(known_class_testing,predicted_class_testing);







         



