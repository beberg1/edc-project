labs = calc_NearestNeighbor(trainv, trainlab, testv, 1000)

function labels = calc_NearestNeighbor(train_d, train_l, test_d, chunk_size)
  
    train_size = size(train_d, 1);
    test_size = size(test_d, 1);
    
    % find amount of chunks
    n_train_chunks = train_size / chunk_size;
    %n_test_chunks = test_size / chunk_size;

    % Create arrays for containing distance and corresponding label
    ex_dist = inf*ones(1, test_size);
    ex_index = -1*ones(1, test_size);

    for i = 1:test_size
        test_vec = test_d(i,:);


%         for j = 1:n_train_chunks
%             train_chunk = train_d((j-1)*chunk_size+1:j*chunk_size,:);
%             D = pdist2(test_vec,train_chunk);
%             [min_dist, index] = min(D);
%             
%             if min_dist < ex_dist(i)
%                 ex_dist(i) = min_dist;
%                 ex_index = (1-j)*chunk_size + index;
%             end
%         end
        distances = pdist2(test_vec, train_d);
        [ex_dist(i), ex_index(i)] = min(distances, );
        
        fprintf("Done with example %d of %d\n", i, test_size)
    end

    % Set correct label
    labels = train_l(ex_index + 1);
end