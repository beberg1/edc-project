function labels = calculate_NN(training_data, training_labels, testing_data, chunk_size)
    

    N = size(training_data, 1);
    train_size = size(training_data, 1);
    test_size = size(testing_data, 1);
    
    % find amount of chunks
    n_train_chunks = train_size / chunk_size;
    %n_test_chunks = test_size / chunk_size;
    
    % Create arrays for containing distance and corresponding label
    ex_dist = inf*ones(1, test_size);
    ex_index = -1*ones(1, test_size);
    
    % Iterate over each test



    for j = 1:n_train_chunks
        train_chunk = training_data((j-1)*chunk_size+1:j*chunk_size,:);
        
        % Find the smallest distance within training chunk 
        distance = dist(train_chunk, testing_data');


        for i = 1:test_size
            [min_dist, index] = min(distance(:,i));
            

            if ex_dist(i) > min_dist
                ex_dist(i) = min_dist;
                ex_index(i) = (j-1)*chunk_size + index;
            end
        end

        fprintf("Done with chunk %d of %d\n",j, n_train_chunks)
        
    
    end
    
    % Set correct label
    labels = training_labels(ex_index + 1);
end