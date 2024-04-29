load("MNist_ttt4275\data_all.mat");

% Constants
chunk_size = 1000;
pixture_size = 28;

% Allocate chunked data
train_data_size = size(trainlab, 1);
test_data_size = size(testlab, 1);

num_chunk_train = train_data_size / chunk_size;
num_chunk_test = test_data_size / chunk_size;

chunked_training_data = zeros(num_chunk_train, chunk_size);
chunked_testing_data = zeros(num_chunk_test, chunk_size);


% Split traning and testing data into chunks
for i = 1:num_chunk_train
    for j = 1:chunk_size
        chunked_training_data(i,:) = trainlab((i-1)*chunk_size+ 1:(i)*chunk_size);
    end
end


for i = 1:num_chunk_test
    for j = 1:chunk_size
        chunked_testing_data(i,:) = testlab((i-1)*chunk_size+ 1:(i)*chunk_size);
    end
end




x = zeros(pixture_size, pixture_size);
x(:) = testv(i,:);
