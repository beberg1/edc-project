labs = calc_NearestNeighbor(trainv, trainlab, testv)

function labels = calc_NearestNeighbor(train_d, train_l, test_d)
  
%     train_size = size(train_d, 1);
    test_size = size(test_d, 1);
    
    % Preallocate arrays
    ex_dist = inf*ones(1, test_size);
    ex_index = -1*ones(1, test_size);

    % Calculate distances
    for i = 1:test_size
        test_vec = test_d(i,:);
        distances = pdist2(test_vec, train_d, "euclidean");
        [min_dist, index] = min(distances);
        
        ex_dist(i) = min_dist;
        ex_index(i) = index;
        
        fprintf("Done with example %d of %d\n", i, test_size)
    end

    % Set correct label
    labels = train_l(ex_index);
end
